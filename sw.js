---
layout: none
---
importScripts('https://storage.googleapis.com/workbox-cdn/releases/7.1.0/workbox-sw.js');

const { registerRoute } = workbox.routing;
const { CacheFirst, NetworkFirst, StaleWhileRevalidate } = workbox.strategies;
const { CacheableResponse } = workbox.cacheableResponse;

workbox.core.setCacheNameDetails({
  prefix: 'rogerkirkness.com',
  suffix: '{{ site.time | date: "%Y%m%d%H%M" }}'
});

registerRoute(
  '/',
  new NetworkFirst()
);

registerRoute(
  new RegExp('/\\d{4}/\\d{2}/\\d{2}/.+'),
  new CacheFirst()
)

workbox.precaching.precacheAndRoute([
  { url: '/', revision: '{{ site.time | date: "%Y%m%d%H%M" }}' },
  { url: '/css/main.css', revision: '{{ site.time | date: "%Y%m%d%H%M" }}' },
  { url: '/favicon.ico', revision: '{{ site.time | date: "%Y%m%d%H%M" }}' },
  {% for post in site.posts -%}
  { url: '{{ post.url }}', revision: '{{ post.date | date: "%Y-%m-%d"}}' },
  {% endfor -%}
])

registerRoute(
  ({request}) => request.destination === 'image' ,
  new CacheFirst({
    plugins: [
      new CacheableResponse({statuses: [0, 200]})
    ],
  })
);

registerRoute(
  /\/(css|images)\//,
  new CacheFirst()
);
