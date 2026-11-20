// Recitation par sourate entiere (cote navigateur) : choix du recitant, reperes des versets,
// et telechargement pour l'ecoute sans internet selon les conditions de Quran Foundation :
// - telechargement seulement a la demande de l'utilisateur ;
// - fichier garde dans le stockage prive de l'application (Cache Storage), jamais exporte ;
// - verification au moins tous les 7 jours : remplace si l'adresse change, retire si la source le retire ;
// - Quran Foundation et le recitant sont cites ; l'utilisateur peut tout retirer.

export type ChapterReciter = { id: number; name: string; style: string | null };
export type VerseTiming = { number: number; from: number; to: number };
export type ChapterAudio = { url: string; size: number | null; timings: VerseTiming[] };
export type Download = { reciter: number; reciterName: string; surah: number; url: string; bytes: number; savedAt: number; checkedAt: number };

export const AUDIO_CACHE = "nour-audio";
export const RECITER_KEY = "nour_reciter";
const DOWNLOADS_KEY = "nour_audio_downloads";
const WEEK = 7 * 86400_000;

export function stored(key: string) {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
}

export function store(key: string, value: string) {
  try {
    localStorage.setItem(key, value);
  } catch {
    // Reglage conserve seulement pendant la visite.
  }
}

export const reciterLabel = (r: ChapterReciter) => (r.style && r.style !== "Murattal" ? `${r.name} (${r.style})` : r.name);

export const chapterKey = (reciter: number, surah: number) => `/api/audio?reciter=${reciter}&surah=${surah}`;

export async function fetchReciters(): Promise<ChapterReciter[]> {
  const res = await fetch("/api/audio?chapters=1");
  if (!res.ok) throw new Error("audio");
  const list = ((await res.json()) as { reciters: ChapterReciter[] }).reciters;
  // Deux enregistrements du meme recitant : on garde le premier (le plus complet).
  const seen = new Set<string>();
  return list.filter((r) => {
    const key = reciterLabel(r);
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

export function defaultReciter(list: ChapterReciter[]) {
  const saved = Number(stored(RECITER_KEY));
  if (list.some((r) => r.id === saved)) return saved;
  return (list.find((r) => /afasy/i.test(r.name)) ?? list[0]).id;
}

// Les reperes d'une sourate telechargee sont gardes avec le fichier : la lecture marche sans internet.
export async function fetchChapter(reciter: number, surah: number): Promise<ChapterAudio> {
  const key = chapterKey(reciter, surah);
  try {
    const res = await fetch(key);
    if (res.ok) return ((await res.json()) as { chapter: ChapterAudio }).chapter;
  } catch {
    // Hors connexion : on essaie la copie gardee.
  }
  const cached = await cachedChapter(reciter, surah);
  if (cached) return cached;
  throw new Error("audio");
}

async function cachedChapter(reciter: number, surah: number) {
  if (!("caches" in window)) return null;
  const cache = await caches.open(AUDIO_CACHE);
  const res = await cache.match(chapterKey(reciter, surah));
  return res ? ((await res.json()) as { chapter: ChapterAudio }).chapter : null;
}

// Verset en cours a l'instant t (ms). Entre deux versets (silence), on garde le precedent.
export function verseAt(timings: VerseTiming[], ms: number) {
  let found = timings[0];
  for (const t of timings) {
    if (t.from <= ms) found = t;
    else break;
  }
  return found;
}

export function listDownloads(): Download[] {
  try {
    const data = JSON.parse(stored(DOWNLOADS_KEY) ?? "[]");
    return Array.isArray(data) ? data : [];
  } catch {
    return [];
  }
}

function saveDownloads(list: Download[]) {
  store(DOWNLOADS_KEY, JSON.stringify(list));
  window.dispatchEvent(new Event("nour-downloads"));
}

export const findDownload = (reciter: number, surah: number) => listDownloads().find((d) => d.reciter === reciter && d.surah === surah) ?? null;

export async function downloadChapter(reciter: number, reciterName: string, surah: number, onProgress: (ratio: number) => void) {
  const chapter = await fetchChapter(reciter, surah);
  const cache = await caches.open(AUDIO_CACHE);
  navigator.storage?.persist?.().catch(() => undefined);
  const res = await fetch(chapter.url, { mode: "cors" });
  if (!res.ok || !res.body) throw new Error("download");
  const total = Number(res.headers.get("Content-Length")) || chapter.size || 0;
  let received = 0;
  const reader = res.body.getReader();
  const counted = new ReadableStream<Uint8Array>({
    async pull(controller) {
      const { done, value } = await reader.read();
      if (done) {
        controller.close();
        return;
      }
      received += value.byteLength;
      if (total) onProgress(Math.min(received / total, 1));
      controller.enqueue(value);
    },
    cancel: (reason) => reader.cancel(reason),
  });
  await cache.put(chapter.url, new Response(counted, { headers: { "Content-Type": res.headers.get("Content-Type") ?? "audio/mpeg" } }));
  await cache.put(chapterKey(reciter, surah), new Response(JSON.stringify({ chapter }), { headers: { "Content-Type": "application/json" } }));
  const now = Date.now();
  const list = listDownloads().filter((d) => !(d.reciter === reciter && d.surah === surah));
  list.push({ reciter, reciterName, surah, url: chapter.url, bytes: received, savedAt: now, checkedAt: now });
  saveDownloads(list);
}

export async function removeDownload(reciter: number, surah: number) {
  const item = findDownload(reciter, surah);
  if ("caches" in window) {
    const cache = await caches.open(AUDIO_CACHE);
    if (item) await cache.delete(item.url);
    await cache.delete(chapterKey(reciter, surah));
  }
  saveDownloads(listDownloads().filter((d) => !(d.reciter === reciter && d.surah === surah)));
}

// Verification hebdomadaire des fichiers gardes (conditions de Quran Foundation).
let syncing = false;
export async function syncDownloads() {
  if (syncing || !navigator.onLine || !("caches" in window)) return;
  syncing = true;
  try {
    for (const item of listDownloads()) {
      if (Date.now() - item.checkedAt < WEEK) continue;
      let res: Response;
      try {
        res = await fetch(chapterKey(item.reciter, item.surah), { cache: "no-store" });
      } catch {
        continue;
      }
      if (res.status === 400 || res.status === 404) {
        await removeDownload(item.reciter, item.surah);
        continue;
      }
      if (!res.ok) continue;
      const chapter = ((await res.json()) as { chapter: ChapterAudio }).chapter;
      if (chapter.url !== item.url) {
        await removeDownload(item.reciter, item.surah);
        await downloadChapter(item.reciter, item.reciterName, item.surah, () => undefined).catch(() => undefined);
        continue;
      }
      const cache = await caches.open(AUDIO_CACHE);
      await cache.put(chapterKey(item.reciter, item.surah), new Response(JSON.stringify({ chapter }), { headers: { "Content-Type": "application/json" } }));
      saveDownloads(listDownloads().map((d) => (d.reciter === item.reciter && d.surah === item.surah ? { ...d, checkedAt: Date.now() } : d)));
    }
  } finally {
    syncing = false;
  }
}

export function formatSize(bytes: number) {
  return bytes >= 1_000_000 ? `${(bytes / 1_000_000).toFixed(1)} Mo` : `${Math.max(1, Math.round(bytes / 1000))} Ko`;
}
