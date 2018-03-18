importScripts('sw-toolbox.js')
toolbox.precache(['/*'])
toolbox.router.get('/*', toolbox.cacheFirst)