---
layout: none
---
importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js');

const { registerRoute } = workbox.routing;
const { CacheFirst, NetworkFirst, StaleWhileRevalidate } = workbox.strategies;
const { CacheableResponse } = workbox.cacheableResponse;

workbox.core.setCacheNameDetails({
  prefix: 'rogerkirkness.com',
  suffix: '{{ site.time | date: "%Y%m%d%H" }}'
});

registerRoute(
  '/',
  new NetworkFirst()
);

registerRoute(
  new RegExp('/\\d{4}/\\d{2}/\\d{2}/.+'),
  new StaleWhileRevalidate()
)

workbox.precaching.precacheAndRoute([
  {% for post in site.posts -%}
  { url: '{{ post.url }}', revision: '{{ post.date | date: "%Y-%m-%d"}}' },
  {% endfor -%}
  { url: '/', revision: '{{ site.time | date: "%Y%m%d%H%M" }}' },
])
