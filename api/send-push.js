import webpush from 'web-push';
import { createClient } from '@supabase/supabase-js';

export default async function handler(req, res) {
  console.log('[Push Endpoint] Received request.');

  // 1. Validate HTTP Method
  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  // 2. Validate Authorization
  const authHeader = req.headers.authorization;
  const webhookSecret = process.env.PUSH_WEBHOOK_SECRET;

  if (!webhookSecret) {
    console.error('[Push Endpoint] PUSH_WEBHOOK_SECRET is not configured on the server.');
    return res.status(500).json({ error: 'Webhook secret is not configured on the server.' });
  }

  if (authHeader !== `Bearer ${webhookSecret}`) {
    console.warn('[Push Endpoint] Unauthorized request attempt.');
    return res.status(401).json({ error: 'Unauthorized' });
  }

  const record = req.body.record || req.body;
  const id = record.id || req.body.id;

  // 3. Validate request payload
  if (!id) {
    return res.status(400).json({ error: 'Missing required field: id' });
  }

  let totalVal = record.total || req.body.total || 0;

  // 4. Initialize Supabase Admin Client
  const supabaseUrl = process.env.VITE_SUPABASE_URL;
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseServiceKey) {
    console.error('[Push Endpoint] Supabase URL or Service Role Key is not configured.');
    return res.status(500).json({ error: 'Database credentials are not configured.' });
  }

  const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

  try {
    // 5. Idempotency Check / Duplicate Protection
    // Try to insert order ID into push_notifications_log. Unique constraint handles race conditions.
    const { error: logError } = await supabaseAdmin
      .from('push_notifications_log')
      .insert({ order_id: id });

    if (logError) {
      // Code '23505' is standard PostgreSQL unique violation
      if (logError.code === '23505') {
        console.log(`[Push Endpoint] Order #${id} has already been notified. Skipping to prevent duplicate.`);
        return res.status(200).json({ message: `Order #${id} already notified. Idempotency rule applied.` });
      }
      throw logError;
    }

    // 6. Fetch order details from Supabase if items are not provided in request body
    let items = record.items || req.body.items;
    
    if (!items || !Array.isArray(items)) {
      try {
        console.log(`[Push Endpoint] Fetching order details for order #${id} from Supabase...`);
        const { data: orderData, error: orderError } = await supabaseAdmin
          .from('orders')
          .select('items, total')
          .eq('id', id)
          .single();

        if (!orderError && orderData) {
          items = orderData.items;
          if (!totalVal) totalVal = orderData.total;
          console.log(`[Push Endpoint] Successfully fetched items from Supabase for order #${id}.`);
        } else {
          console.warn(`[Push Endpoint] Failed to fetch order #${id} from Supabase:`, orderError);
        }
      } catch (fetchErr) {
        console.error(`[Push Endpoint] Error querying order #${id}:`, fetchErr);
      }
    }

    // Calculate total product quantity
    let itemCount = 0;
    if (items && Array.isArray(items)) {
      const foodItems = items.filter(i => i && !i.isAddressMetadata);
      itemCount = foodItems.reduce((sum, item) => sum + (item.quantity || 1), 0);
    }

    // Format body text: New order #128 for 3 items totaling ₹635.
    let bodyText = `New order #${id} totaling ₹${totalVal}.`;
    if (itemCount > 0) {
      bodyText = `New order #${id} for ${itemCount} item${itemCount > 1 ? 's' : ''} totaling ₹${totalVal}.`;
    }

    // 7. Initialize web-push VAPID configuration
    const vapidPublicKey = process.env.VITE_VAPID_PUBLIC_KEY;
    const vapidPrivateKey = process.env.VAPID_PRIVATE_KEY;
    const vapidSubject = process.env.VAPID_SUBJECT;

    if (!vapidPublicKey || !vapidPrivateKey || !vapidSubject) {
      console.error('[Push Endpoint] VAPID keys or subject are not configured.');
      return res.status(500).json({ error: 'Server VAPID keys are not configured.' });
    }

    webpush.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);

    // 8. Fetch all active push subscriptions
    const { data: subscriptions, error: dbError } = await supabaseAdmin
      .from('push_subscriptions')
      .select('*');

    if (dbError) throw dbError;

    if (!subscriptions || subscriptions.length === 0) {
      console.log('[Push Endpoint] No active subscriptions. Notification complete.');
      return res.status(200).json({ message: 'No registered push subscriptions found.' });
    }

    // 9. Construct push payload
    const payload = JSON.stringify({
      id: id,
      total: totalVal,
      title: 'White House Cafe',
      body: bodyText,
      url: '/admin?adminTab=orders' // Deep link to orders screen on click
    });

    console.log(`[Push Endpoint] Sending push alerts for Order #${id} to ${subscriptions.length} devices.`);

    // 9. Dispatch push messages in parallel
    const results = await Promise.allSettled(
      subscriptions.map(async (subRecord) => {
        const pushSubscription = {
          endpoint: subRecord.endpoint,
          keys: {
            p256dh: subRecord.keys?.p256dh,
            auth: subRecord.keys?.auth
          }
        };

        try {
          await webpush.sendNotification(pushSubscription, payload);
          return { status: 'success', endpoint: subRecord.endpoint };
        } catch (pushErr) {
          // Clean up expired or disabled endpoints (errors 404 or 410)
          if (pushErr.statusCode === 404 || pushErr.statusCode === 410) {
            console.warn(`[Push Endpoint] Subscription expired (status: ${pushErr.statusCode}). Removing endpoint.`);
            await supabaseAdmin
              .from('push_subscriptions')
              .delete()
              .eq('id', subRecord.id);
            return { status: 'expired_removed', endpoint: subRecord.endpoint };
          }
          throw pushErr;
        }
      })
    );

    // 10. Log summary results
    const summary = {
      total: subscriptions.length,
      success: results.filter(r => r.status === 'fulfilled' && r.value.status === 'success').length,
      removed: results.filter(r => r.status === 'fulfilled' && r.value.status === 'expired_removed').length,
      failed: results.filter(r => r.status === 'rejected').length
    };

    console.log('[Push Endpoint] Broadcast results summary:', summary);
    return res.status(200).json({ message: 'Push notifications processed', summary });

  } catch (error) {
    console.error('[Push Endpoint] Error occurred during execution:', error);
    return res.status(500).json({ error: error.message || 'Internal Server error' });
  }
}
