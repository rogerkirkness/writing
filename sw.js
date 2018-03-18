'use strict'
importScripts('sw-toolbox.js')
toolbox.precache(["index.html","default.html","post.html"])
toolbox.router.get('/images/*', toolbox.cacheFirst)
toolbox.router.get('/*', toolbox.networkFirst, { networkTimeoutSeconds: 5})