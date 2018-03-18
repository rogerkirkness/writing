self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('rogerkirkness').then((cache) => {
      return cache.addAll([
        '/*'
      ])
    })
  )
})