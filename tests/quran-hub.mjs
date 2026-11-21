// Page Coran reorganisee : tuiles, page « Sans internet », etat des telechargements.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
for (const [locale, width] of [["fr", 396], ["fr", 320], ["ar", 396]]) {
  const context = await browser.newContext({ viewport: { width, height: 859 } });
  if (locale === "ar") await context.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
  const page = await context.newPage();
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto(`${BASE}/coran`, { waitUntil: "networkidle" });
  const tiles = await page.$$eval("[data-tile]", (els) => els.map((e) => [e.dataset.tile, e.getAttribute("href")]));
  check(tiles.length === 4, `${locale} ${width}px : 4 tuiles`, tiles.map((t) => t[0]).join(","));
  for (const [, href] of tiles) {
    const res = await page.request.get(`${BASE}${href}`);
    check(res.status() === 200, `${locale} ${width}px : ${href}`, String(res.status()));
  }
  check(await page.locator("[data-save-quran], [data-audio-downloads]").count() === 0, `${locale} : plus de blocs de téléchargement sur la page Coran`);
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth > innerWidth);
  check(!overflow, `${locale} ${width}px : pas de débordement`);
  await page.click('[data-tile="offline"]');
  await page.waitForURL(/\/coran\/hors-ligne/);
  await page.waitForSelector("[data-save-quran]");
  check(await page.locator("[data-downloads-empty]").count() === 1, `${locale} : page Sans internet, liste vide expliquée`);
  // Une recitation enregistree (simulee dans la liste de l'appareil) apparait dans la tuile et la liste.
  await page.evaluate(() => localStorage.setItem("nour_audio_downloads", JSON.stringify([{ reciter: 7, reciterName: "Mishari Rashid al-`Afasy", surah: 112, url: "https://download.quranicaudio.com/x/112.mp3", bytes: 800000, savedAt: Date.now(), checkedAt: Date.now() }])));
  await page.reload({ waitUntil: "networkidle" });
  check(await page.locator("[data-remove-download]").count() === 1, `${locale} : récitation listée`);
  await page.goto(`${BASE}/coran`, { waitUntil: "networkidle" });
  const status = await page.textContent("[data-offline-status]");
  check(/800 Ko/.test(status), `${locale} : tuile Sans internet résume l'état`, status);
  await page.goto(`${BASE}/coran/hors-ligne`, { waitUntil: "networkidle" });
  await page.click("[data-remove-download]");
  await page.waitForSelector("[data-downloads-empty]");
  check(true, `${locale} : retrait depuis la liste`);
  check(errors.length === 0, `${locale} : aucune erreur`, errors.join(" | "));
  await context.close();
}
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
