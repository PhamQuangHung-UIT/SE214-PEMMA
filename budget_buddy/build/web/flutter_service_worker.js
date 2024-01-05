'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".well-known/assetlinks.json": "ae14a4334f101854922f1aa2a0d3705c",
"assets/AssetManifest.bin": "28f1bbb325e9c7d94c8d5e07c6ec7283",
"assets/AssetManifest.json": "8cabd2f956427c85262f09fe28dc9f3f",
"assets/assets/fonts/MontserratRomanBold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/fonts/MontserratRomanLight.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/fonts/MontserratRomanMedium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/fonts/MontserratRomanRegular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/fonts/MontserratRomanSemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/images/30-days.png": "aaac2eebe870408fc54d53514f1af730",
"assets/assets/images/7-days.png": "ac5960e92a2f5f13d0d9ac92c920c4d5",
"assets/assets/images/arrow-1.png": "14284de2fd6c4f8e4c0104ec315cc84b",
"assets/assets/images/arrow-down.png": "edad3cfbb4ee21d7a6e4af31d52867a2",
"assets/assets/images/arrow.png": "44f319c4d59104ef0de3cd91ca3ea628",
"assets/assets/images/avatar-1.png": "0c4de50f1eeb3560f0abe2412baf9c9e",
"assets/assets/images/avatar.png": "306c452f4ad09e6f643bcf5fcdb46d15",
"assets/assets/images/bar-chart-1.png": "cbe2de6adcd66a24a82c5b5c2e1d822e",
"assets/assets/images/bar-chart.png": "b629ce30e2f834d9e63b1d889eae5976",
"assets/assets/images/bell.png": "d00525e99e2b1ce7a1e524e7d73eabf2",
"assets/assets/images/calendar-1.png": "6eacf7fbe0816d1c92a5b260c9b57128",
"assets/assets/images/calendar-2.png": "46524d8ace64704917b49b45ef59c74e",
"assets/assets/images/calendar.png": "856b01a291e7d53d13717f81864c4056",
"assets/assets/images/casual-t-shirt-.png": "23e70f868fc996a156ba4ad049ca65de",
"assets/assets/images/change.png": "2dfcc7a84ac9d4ea06944c17688e34f9",
"assets/assets/images/check.png": "4270a3ff6bac3d9fa374c0a909896e9f",
"assets/assets/images/clock.png": "6b82b01085d59577b3ed4138d88cca1c",
"assets/assets/images/close.png": "a035e66f92b6119c31e5e56e0d1dd303",
"assets/assets/images/election-event-on-a-calendar-with-star-symbol.png": "9a66cf2935e53306699da97fe1ae2e79",
"assets/assets/images/electricity-bill.png": "cb82eab932ba89596aa9bc966d29f45b",
"assets/assets/images/facebook.png": "1a99bcdab2c2d9e3d39ee4956bf4123a",
"assets/assets/images/fuel.png": "52c0067fc0eee1a4501fe04579a1f9b8",
"assets/assets/images/gmail.png": "f3f618c9434c0e71b340eff840f5fa80",
"assets/assets/images/hidden.png": "c547d1df9fad13b31b86de0f27e6deb0",
"assets/assets/images/hide.png": "c4e178905fd45e2568868ef21669b2d0",
"assets/assets/images/home-1.png": "8eefb9d8640c4b9c65761aea548ef269",
"assets/assets/images/home.png": "e7e84d632ea46d5ca2f29be5509f0f67",
"assets/assets/images/logo.png": "ef877b80204475ddf9c94fdacc4d14bf",
"assets/assets/images/logout.png": "5e967b348938a2eba0c8635ec9217977",
"assets/assets/images/minus.png": "417d4116733e2e394436c22840d8227c",
"assets/assets/images/money-bag-1.png": "79b9b917e2c5cc161aa9ba7c475ade5a",
"assets/assets/images/money-bag.png": "e3f5bce02f1042182c50dc63e030e249",
"assets/assets/images/notes.png": "31d486a6160fcd4fd2ac3c1576ebc724",
"assets/assets/images/notification.png": "7c06a5f507cb100a22a9017d8b07e864",
"assets/assets/images/padlock.png": "f0eddaa057270fd61a48d431ba393cc5",
"assets/assets/images/pen-1.png": "0712356bf07f7c55ef5bae864ae884f8",
"assets/assets/images/pen.png": "6aa34663a485deb88e19f4dd1e65e0e1",
"assets/assets/images/plane.png": "5e3d5a9452d2563fee18b109399834c7",
"assets/assets/images/plus-1.png": "f8adfcb82cd687a5e64b5a30b06ed70b",
"assets/assets/images/plus.png": "6d8a40d20c5b55bd7b9381261f4b6203",
"assets/assets/images/profile-user.png": "1ceb8f968a976f4fec56bb32f94ef04d",
"assets/assets/images/reject-1.png": "e80cdafa3dc8b1fda2f27ab81f3e045c",
"assets/assets/images/reject.png": "c81a72b1254a1f562a2535a0c9df0365",
"assets/assets/images/restaurant.png": "d6bccf2015be38040c9c70e6b9aa2a54",
"assets/assets/images/salary.png": "8199b0ee649a8189f5626a78398cd348",
"assets/assets/images/setting.png": "ccf6081cb8aee2aae5dcf77b1aa088e9",
"assets/assets/images/shopping-bag.png": "875b56bb389c498e706d0674cd28e955",
"assets/assets/images/smartphone.png": "0cd0986f500dacb9b3ef563aef1f04b6",
"assets/assets/images/sort.png": "04e0452bec729a409db13c90c9fbb704",
"assets/assets/images/translation.png": "2a44312a7ead3d98facefc2c79db4a00",
"assets/assets/images/trash-bin.png": "9076ffe17472c08a9b331ef58627dfe4",
"assets/assets/images/view.png": "507dd08f6ab8132ded9f213181f5c6b4",
"assets/assets/images/visible.png": "6c10219023863e78c3814bf1cf2508c1",
"assets/assets/images/wages.png": "c3b5b7df2e36ab97e705dacaf2326c7e",
"assets/FontManifest.json": "7dd98b0eacf3082958a5535cf8a93547",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/NOTICES": "7bbbfa02cfce8edbd43fa963c7a73c80",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "6f14beece58579251490bf82e4bccd3e",
"/": "6f14beece58579251490bf82e4bccd3e",
"main.dart.js": "71330f88c6b2360773db889d678b19e5",
"manifest.json": "77f9c23c2ebfd01ed90894a79bf9c987",
"version.json": "c8af59cadbd6acb4404cbf436fcac032"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
