self.addEventListener('install', (event) => {
  return cache.addAll([
    '/*'
  ])
})