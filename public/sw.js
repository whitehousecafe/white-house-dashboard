// Service Worker for White House Cafe Push Notifications
// Installed and runs in the browser background independently of open tabs.

self.addEventListener('push', function(event) {
  console.log('[Service Worker] Push Event Received.');

  if (!event.data) {
    console.warn('[Service Worker] Push event contains no payload data.');
    return;
  }

  let title = 'WHITE HOUSE CAFE';
  let options = {};

  try {
    const payload = event.data.json();
    console.log('[Service Worker] Parsed push notification payload:', payload);

    const orderId = payload.id;
    const customerName = payload.customer_name || 'Customer';
    const totalAmount = payload.total || 0;

    title = payload.title || 'WHITE HOUSE CAFE';
    options = {
      body: payload.body || `New Order #${orderId}\nCustomer: ${customerName}\nTotal: ₹${totalAmount}`,
      icon: '/favicon.ico',
      badge: '/favicon.ico',
      tag: orderId ? `new-order-${orderId}` : 'new-order-general',
      renotify: true,
      requireInteraction: true,
      data: {
        orderId: orderId,
        url: payload.url || '/' // Dynamically passed target admin page URL
      }
    };
  } catch (err) {
    console.warn('[Service Worker] Payload is not JSON. Falling back to plain text parsing:', err);
    options = {
      body: event.data.text(),
      icon: '/favicon.ico',
      badge: '/favicon.ico',
      tag: 'new-order-fallback',
      data: {
        url: '/'
      }
    };
  }

  event.waitUntil(
    self.registration.showNotification(title, options)
  );
});

self.addEventListener('notificationclick', function(event) {
  console.log('[Service Worker] Notification Clicked.');
  event.notification.close();

  // Retrieve the target URL from metadata
  const targetUrl = (event.notification.data && event.notification.data.url) 
    ? event.notification.data.url 
    : '/';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true })
      .then(function(clientList) {
        // Attempt to find an existing admin dashboard tab and focus it
        for (let i = 0; i < clientList.length; i++) {
          const client = clientList[i];
          const clientUrl = new URL(client.url, self.location.origin).href;
          const checkUrl = new URL(targetUrl, self.location.origin).href;
          
          if (clientUrl === checkUrl && 'focus' in client) {
            return client.focus();
          }
        }
        // Fallback: search if any dashboard/admin window exists, if so focus it
        for (let i = 0; i < clientList.length; i++) {
          const client = clientList[i];
          if (client.url.includes('/admin') || client.url.includes('adminTab=') || client.url.includes('view=admin')) {
            if ('focus' in client) return client.focus();
          }
        }

        // If no matching dashboard tab is open, open a new one
        if (clients.openWindow) {
          return clients.openWindow(targetUrl);
        }
      })
  );
});
