self.importScripts('/sw-toolbox.js')
self.toolbox.precache(['/*'])
toolbox.router.get('/*', toolbox.cacheFirst, {networkTimeoutSeconds: 5})