// Service worker de NOUR AL-ISLAM : hors connexion et rappels (notifications Web Push).
// Hors connexion : les pages deja ouvertes (Coran, lecons, invocations, horaires) restent lisibles sans internet.
// Pages personnelles, administration et connexion : jamais gardees sur l'appareil.
const VERSION = "nour-v3";
const AUDIO = "nour-audio"; // recitations telechargees a la demande : gardees d'une version a l'autre
const PAGES = `${VERSION}-pages`;
const ASSETS = `${VERSION}-assets`;
const SHELL = `${VERSION}-shell`; // page « Pas de connexion » : jamais effacee avec les pages
const OFFLINE_URL = "/hors-ligne";
const PRECACHE = ["/", "/coran", "/priere", "/priere/horaires", "/priere/invocations"];
const PRIVATE = /^\/(admin|profil|favoris|connexion|inscription|auth|api)(\/|$)/;
const MAX_PAGES = 400;

self.addEventListener("install", (event) => {
  event.waitUntil((async () => {
    const shell = await caches.open(SHELL);
    await Promise.all([OFFLINE_URL, "/manifest.webmanifest", "/icons/icon-192.png", "/favicon.svg"].map((url) => shell.add(url).catch(() => {})));
    const cache = await caches.open(PAGES);
    await Promise.all(PRECACHE.map((url) => cache.add(new Request(url, { credentials: "same-origin" })).catch(() => {})));
    await self.skipWaiting();
  })());
});

self.addEventListener("activate", (event) => {
  event.waitUntil((async () => {
    for (const name of await caches.keys()) if (!name.startsWith(VERSION) && name !== AUDIO) await caches.delete(name);
    await self.clients.claim();
  })());
});

async function trim(cache) {
  const keys = await cache.keys();
  for (let i = 0; i < keys.length - MAX_PAGES; i++) await cache.delete(keys[i]);
}

// Page ou donnees de navigation : d'abord le reseau (contenu a jour), sinon la copie gardee.
async function networkFirst(request, fallbackToOffline) {
  const cache = await caches.open(PAGES);
  try {
    const response = await fetch(request);
    if (response.ok && response.type === "basic" && !response.headers.get("Cache-Control")?.includes("no-store-sw")) {
      await cache.put(request, response.clone());
      trim(cache);
    }
    return response;
  } catch {
    const cached = await cache.match(request, { ignoreVary: true });
    if (cached) return cached;
    if (fallbackToOffline) return (await caches.match(OFFLINE_URL)) ?? Response.error();
    return Response.error();
  }
}

// Fichiers de l'application (scripts, styles, polices, icones) : la copie gardee, mise a jour en arriere-plan.
async function staleWhileRevalidate(request) {
  const cache = await caches.open(ASSETS);
  const cached = await cache.match(request);
  const fresh = fetch(request).then((response) => {
    if (response.ok) cache.put(request, response.clone());
    return response;
  }).catch(() => cached ?? Response.error());
  return cached ?? fresh;
}

// Recitation telechargee : servie depuis l'appareil, y compris par morceaux (requetes Range du lecteur audio).
async function cachedAudio(request) {
  const cache = await caches.open(AUDIO);
  const cached = await cache.match(request.url, { ignoreVary: true, ignoreSearch: false });
  if (!cached) return fetch(request);
  const range = /^bytes=(\d*)-(\d*)$/.exec(request.headers.get("Range") || "");
  const blob = await cached.blob();
  const type = cached.headers.get("Content-Type") || "audio/mpeg";
  if (!range) return new Response(blob, { status: 200, headers: { "Content-Type": type, "Content-Length": String(blob.size), "Accept-Ranges": "bytes" } });
  let start = range[1] === "" ? Math.max(0, blob.size - Number(range[2])) : Number(range[1]);
  let end = range[1] !== "" && range[2] !== "" ? Number(range[2]) : blob.size - 1;
  end = Math.min(end, blob.size - 1);
  if (start > end || start >= blob.size) return new Response(null, { status: 416, headers: { "Content-Range": `bytes */${blob.size}` } });
  return new Response(blob.slice(start, end + 1), {
    status: 206,
    headers: { "Content-Type": type, "Content-Length": String(end - start + 1), "Content-Range": `bytes ${start}-${end}/${blob.size}`, "Accept-Ranges": "bytes" },
  });
}

self.addEventListener("fetch", (event) => {
  const { request } = event;
  if (request.method !== "GET") return;
  const url = new URL(request.url);
  if (url.hostname === "download.quranicaudio.com") {
    event.respondWith(cachedAudio(request));
    return;
  }
  if (url.origin !== self.location.origin || url.pathname === "/sw.js") return;
  if (PRIVATE.test(url.pathname)) {
    // Jamais gardee ; hors connexion, on affiche la page « Pas de connexion ».
    if (request.mode === "navigate") event.respondWith(fetch(request).catch(async () => (await caches.match(OFFLINE_URL)) ?? Response.error()));
    return;
  }
  if (url.pathname.startsWith("/_next/static/") || url.pathname.startsWith("/icons/") || /\.(woff2?|ttf|svg|png|webp|css)$/.test(url.pathname)) {
    event.respondWith(staleWhileRevalidate(request));
    return;
  }
  if (request.mode === "navigate") {
    event.respondWith(networkFirst(request, true));
    return;
  }
  if (request.headers.get("RSC") === "1" || url.searchParams.has("_rsc")) {
    event.respondWith(networkFirst(request, false));
  }
});

// Enregistrer une liste de pages pour la lecture hors connexion (ex. : tout le Coran).
self.addEventListener("message", (event) => {
  const data = event.data || {};
  if (data.type === "save-pages" && Array.isArray(data.urls)) {
    event.waitUntil((async () => {
      const cache = await caches.open(PAGES);
      let done = 0;
      for (const path of data.urls) {
        if (typeof path !== "string" || !path.startsWith("/") || PRIVATE.test(path)) continue;
        try {
          const response = await fetch(path, { credentials: "same-origin" });
          if (response.ok) await cache.put(path, response);
        } catch { /* on continue avec les suivantes */ }
        done++;
        if (done % 5 === 0 || done === data.urls.length) event.source?.postMessage({ type: "save-progress", done, total: data.urls.length });
      }
    })());
  }
  if (data.type === "clear-pages") event.waitUntil(caches.delete(PAGES));
});

self.addEventListener("push", (event) => {
  let data = {};
  try { data = event.data ? event.data.json() : {}; } catch { data = { body: event.data ? event.data.text() : "" }; }
  event.waitUntil(self.registration.showNotification(data.title || "NOUR AL-ISLAM", {
    body: data.body || "",
    icon: "/icons/icon-192.png",
    badge: "/icons/icon-192.png",
    tag: data.tag || "rappel",
    data: { url: typeof data.url === "string" && data.url.startsWith("/") ? data.url : "/" },
  }));
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const url = new URL(event.notification.data?.url || "/", self.location.origin).href;
  event.waitUntil((async () => {
    const all = await self.clients.matchAll({ type: "window", includeUncontrolled: true });
    for (const client of all) {
      if (client.url === url && "focus" in client) return client.focus();
    }
    return self.clients.openWindow(url);
  })());
});
