var urls = []

{% for post in site.posts %}
urls.push({{ post.url }})
{% endfor %}

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('rogerkirkness').then((cache) => {
      return cache.addAll(urls)
    })
  )
})