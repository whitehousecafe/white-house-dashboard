// Service Worker for White House Cafe Push Notifications & Offline Caching
// Installed and runs in the browser background independently of open tabs.

const CACHE_NAME = 'white-house-cafe-v1';
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/manifest.webmanifest',
  '/icons/icon-192.png',
  '/icons/icon-512.png',
  '/icons/icon-maskable-192.png',
  '/icons/icon-maskable-512.png',
  '/icons/apple-touch-icon.png',
  '/icons/badge-72.png'
];

// Caching strategy: Cache First for static shell assets, bypass for dynamic resources
self.addEventListener('install', function(event) {
  console.log('[Service Worker] Installing service worker.');
  event.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  console.log('[Service Worker] Activating service worker.');
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.map(function(cacheName) {
          if (cacheName !== CACHE_NAME) {
            console.log('[Service Worker] Clearing old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener('fetch', function(event) {
  const url = new URL(event.request.url);

  // Do NOT cache non-GET requests, Supabase database calls, or serverless API requests
  if (
    event.request.method !== 'GET' ||
    url.pathname.includes('/api/') ||
    url.hostname.includes('supabase')
  ) {
    return;
  }

  event.respondWith(
    caches.match(event.request).then(function(cachedResponse) {
      if (cachedResponse) {
        return cachedResponse;
      }
      return fetch(event.request).then(function(networkResponse) {
        if (!networkResponse || networkResponse.status !== 200 || networkResponse.type !== 'basic') {
          return networkResponse;
        }

        // Cache newly fetched static assets dynamically
        const responseToCache = networkResponse.clone();
        caches.open(CACHE_NAME).then(function(cache) {
          cache.put(event.request, responseToCache);
        });

        return networkResponse;
      }).catch(function() {
        // Fallback or silent error if network fails
      });
    })
  );
});

self.addEventListener('push', function(event) {
  console.log('[Service Worker] Push Event Received.');

  if (!event.data) {
    console.warn('[Service Worker] Push event contains no payload data.');
    return;
  }

  let title = 'White House Cafe';
  let options = {};

  try {
    const payload = event.data.json();
    console.log('[Service Worker] Parsed push notification payload:', payload);

    const orderId = payload.id;
    const totalAmount = payload.total || 0;

    title = payload.title || 'White House Cafe';
    options = {
      body: payload.body || `New Order #${orderId} totaling ₹${totalAmount}`,
      icon: '/icons/icon-192.png',
      badge: '/icons/badge-72.png',
      tag: orderId ? `order-${orderId}` : 'new-order-general',
      renotify: true,
      requireInteraction: true,
      data: {
        orderId: orderId,
        url: payload.url || '/?adminTab=orders' // Target URL
      }
    };
  } catch (err) {
    console.warn('[Service Worker] Payload is not JSON. Falling back to plain text parsing:', err);
    options = {
      body: event.data.text(),
      icon: '/icons/icon-192.png',
      badge: '/icons/badge-72.png',
      tag: 'new-order-fallback',
      data: {
        url: '/?adminTab=orders'
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

  // Retrieve the target URL from metadata (default to Orders tab on root URL)
  const targetUrl = (event.notification.data && event.notification.data.url) 
    ? event.notification.data.url 
    : '/?adminTab=orders';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true })
      .then(function(clientList) {
        // 1. Attempt to find an existing dashboard tab open at the root URL path
        for (let i = 0; i < clientList.length; i++) {
          const client = clientList[i];
          const clientUrl = new URL(client.url, self.location.origin);
          
          if (clientUrl.pathname === '/' && 'focus' in client) {
            client.focus();
            if ('navigate' in client) {
              return client.navigate(targetUrl);
            }
            return;
          }
        }

        // 2. Fallback: focus any tab showing the admin page and navigate it
        for (let i = 0; i < clientList.length; i++) {
          const client = clientList[i];
          if (client.url.includes('adminTab=') || client.url.includes('view=admin') || client.url.includes('/admin')) {
            if ('focus' in client) {
              client.focus();
              if ('navigate' in client) {
                return client.navigate(targetUrl);
              }
              return;
            }
          }
        }

        // 3. If no matching dashboard tab is open, open a new window
        if (clients.openWindow) {
          return clients.openWindow(targetUrl);
        }
      })
  );
});
