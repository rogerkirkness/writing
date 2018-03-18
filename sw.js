---
layout: null
---

var urls = [
  {% for post in site.posts %}
  '{{ post.url }}',
  {% endfor %}
  '/'
]

self.addEventListener('install', (event) => {
  self.skipWaiting()
  event.waitUntil(
    caches.open('rogerkirkness-1').then((cache) => {
      return cache.addAll(urls)
    })
  )
})

self.addEventListener("activate", function(e){
  e.waitUntil(
    caches.keys().then(function(cacheNames){
      return Promise.all(
        cacheNames.filter(function(cacheName){
          return cacheName.startsWith("rogerkirkness")
            && cacheName != staticCacheName
        }).map(function(cacheName){
          return cache.delete(cacheName)
        })
      )
    })
  )
})

self.addEventListener("fetch", function(e){
  e.respondWith(
     caches.match(e.request).then(function(response) {
       return response || fetch(e.request)
     })
   )
})