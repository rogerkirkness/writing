---
layout: null
---

var urls = [
  {% for post in site.posts %}
  '{{ post.url }}',
  {% endfor %}
  '/'
]

var currentCacheName = 'rogerkirkness-' + String(urls.length) 

self.addEventListener('install', (event) => {
  self.skipWaiting()
  event.waitUntil(
    caches.open(currentCacheName).then((cache) => {
      return cache.addAll(urls)
    })
  )
})

self.addEventListener('activate', function(e){
  e.waitUntil(
    caches.keys().then(function(cacheNames){
      return Promise.all(
        cacheNames.filter(function(cacheName){
          return cacheName.startsWith('rogerkirkness')
            && cacheName != currentCacheName
        }).map(function(cacheName){
          return cache.delete(cacheName)
        })
      )
    })
  )
})

self.addEventListener('fetch', function(e){
  e.respondWith(
     caches.match(e.request).then(function(response) {
       return response || fetch(e.request)
     })
   )
})