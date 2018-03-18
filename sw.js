importScripts('sw-toolbox.js').catch((error) => { console.error(error) })
toolbox.precache(['/*'])
toolbox.router.get('/*', toolbox.cacheFirst, {networkTimeoutSeconds: 5})