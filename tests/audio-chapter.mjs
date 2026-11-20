// Recitation par sourate entiere : lecture continue, versets suivis, telechargement et ecoute hors connexion.
// Usage : BASE_URL=https://nour-al-islam.vercel.app node tests/audio-chapter.mjs
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};

const browser = await chromium.launch({ args: ["--autoplay-policy=no-user-gesture-required"] });
const context = await browser.newContext({ viewport: { width: 396, height: 859 }, isMobile: true, hasTouch: true });
const page = await context.newPage();

// 1. Lecture d'une sourate : un seul fichier, le verset en cours avance.
await page.goto(`${BASE}/coran/112`, { waitUntil: "networkidle" });
await page.waitForFunction(() => document.querySelector("[data-audio-verse]"), null, { timeout: 30000 });
check(await page.locator("[data-audio-mode=chapter]").count() === 1, "lecteur par sourate entiere");
await page.click("[data-audio-toggle]");
await page.waitForFunction(() => { const a = document.querySelector("audio"); return a && !a.paused && a.currentTime > 0.5; }, null, { timeout: 30000 });
const src = await page.evaluate(() => document.querySelector("audio").src);
check(/download\.quranicaudio\.com\/.+\/112\.mp3$/.test(src), "fichier continu de la sourate", src);
await page.evaluate(() => { document.querySelector("audio").currentTime = 6; });
await page.waitForFunction(() => /112:(2|3)/.test(document.querySelector("[data-audio-verse]")?.textContent ?? ""), null, { timeout: 15000 });
check(true, "le verset en cours suit la lecture");
check(await page.locator("#v112-2[data-playing], #v112-3[data-playing]").count() === 1, "verset en cours surligne");
const session = await page.evaluate(() => navigator.mediaSession?.metadata?.title ?? "");
check(/112:/.test(session), "commandes de l'ecran verrouille (Media Session)", session);

// 2. Clic sur « Ecouter ce verset » : saut dans le meme fichier.
await page.click('[data-play-verse="4"]');
await page.waitForFunction(() => /112:4/.test(document.querySelector("[data-audio-verse]")?.textContent ?? ""), null, { timeout: 15000 });
check(await page.evaluate(() => document.querySelector("audio").src) === src, "saut au verset 4 sans changer de fichier");
await page.click("[data-audio-toggle]");

// 3. Telechargement puis ecoute sans internet.
await page.evaluate(() => navigator.serviceWorker.ready);
await page.reload({ waitUntil: "networkidle" });
await page.waitForFunction(() => document.querySelector("[data-audio-verse]"), null, { timeout: 30000 });
await page.click("[data-audio-settings]");
await page.click("[data-download-button]");
await page.waitForSelector("[data-download=saved]", { timeout: 60000 });
const cached = await page.evaluate(async (url) => Boolean(await (await caches.open("nour-audio")).match(url)), src);
check(cached, "fichier garde dans le stockage de l'application");
await context.setOffline(true);
await page.reload({ waitUntil: "load" }).catch(() => undefined);
await page.waitForFunction(() => document.querySelector("[data-audio-verse]"), null, { timeout: 30000 }).catch(() => undefined);
await page.click("[data-audio-toggle]").catch(() => undefined);
const offline = await page.waitForFunction(() => { const a = document.querySelector("audio"); return a && !a.paused && a.currentTime > 0.5; }, null, { timeout: 20000 }).then(() => true).catch(() => false);
check(offline, "ecoute sans internet", offline ? "" : await page.evaluate(() => `${document.querySelector("[data-audio-status]")?.textContent} | ${document.querySelector("audio")?.src} | ${document.querySelector("audio")?.error?.code}`).catch((e) => String(e)));
await page.evaluate(() => { const a = document.querySelector("audio"); a.currentTime = 9; });
const seek = await page.waitForFunction(() => /112:(3|4)/.test(document.querySelector("[data-audio-verse]")?.textContent ?? ""), null, { timeout: 15000 }).then(() => true).catch(() => false);
check(seek, "deplacement dans le fichier hors connexion (requetes partielles)");
await context.setOffline(false);

// 4. Retrait du telechargement.
await page.reload({ waitUntil: "networkidle" });
await page.waitForFunction(() => document.querySelector("[data-audio-verse]"), null, { timeout: 30000 });
await page.click("[data-audio-settings]");
await page.getByRole("button", { name: /Retirer|حذف/ }).click();
await page.waitForSelector("[data-download=none]", { timeout: 10000 });
const removed = await page.evaluate(async (url) => !(await (await caches.open("nour-audio")).match(url)), src);
check(removed, "fichier retire de l'appareil");

// 5. Mushaf : meme lecteur continu.
await page.goto(`${BASE}/coran/mushaf/604`, { waitUntil: "networkidle" });
await page.waitForSelector("article[data-ready]", { timeout: 30000 });
const pageEm = await page.evaluate(() => document.querySelector("article").style.getPropertyValue("--mushaf-em"));
check(Number(pageEm) > 9 && Number(pageEm) <= 15.2, "largeur de page mesuree", pageEm);
await page.locator(".audio-bar button.rounded-full").click();
await page.waitForFunction(() => { const a = document.querySelector("audio"); return a && !a.paused && a.currentTime > 0.3; }, null, { timeout: 30000 });
const mushafSrc = await page.evaluate(() => document.querySelector("audio").src);
check(/download\.quranicaudio\.com\/.+\/112\.mp3$/.test(mushafSrc), "Mushaf : fichier continu de la sourate", mushafSrc);
check(await page.locator("[data-current]").count() > 0, "Mushaf : mots du verset surlignes");

await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
