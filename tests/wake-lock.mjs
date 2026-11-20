// Ecran allume pendant la recitation : verrou demande a la lecture, rendu a la pause.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch({ args: ["--autoplay-policy=no-user-gesture-required"] });
const context = await browser.newContext({ viewport: { width: 396, height: 859 }, isMobile: true, hasTouch: true });
// Verrou simule : le navigateur de test n'a pas d'ecran a garder allume.
await context.addInitScript(() => {
  window.__locks = { requested: 0, released: 0 };
  Object.defineProperty(navigator, "wakeLock", {
    value: { request: async () => { window.__locks.requested++; const s = { released: false, release: async () => { if (!s.released) { s.released = true; window.__locks.released++; } } }; return s; } },
  });
});
const page = await context.newPage();
for (const [url, toggle] of [["/coran/112", "[data-audio-toggle]"], ["/coran/mushaf/604", ".audio-bar button.rounded-full"]]) {
  await page.goto(`${BASE}${url}`, { waitUntil: "networkidle" });
  await page.waitForTimeout(1500);
  check(await page.evaluate(() => window.__locks.requested) === 0, `${url} : pas de verrou avant la lecture`);
  await page.click(toggle);
  await page.waitForFunction(() => { const a = document.querySelector("audio"); return a && !a.paused && a.currentTime > 0.3; }, null, { timeout: 30000 });
  await page.waitForTimeout(300);
  check(await page.evaluate(() => window.__locks.requested) === 1, `${url} : ecran garde allume pendant la lecture`);
  await page.click(toggle);
  await page.waitForTimeout(500);
  check(await page.evaluate(() => window.__locks.released) === 1, `${url} : verrou rendu a la pause`);
}
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
