// Fenetre du verset dans le Mushaf (traduction, tafsir, lecture dans la sourate) et mot a mot par verset.
// Usage : BASE_URL=https://nour-al-islam.vercel.app node tests/verse-tools.mjs
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };

const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
for (const vp of [{ width: 320, height: 640 }, { width: 396, height: 859 }]) {
  const context = await browser.newContext({ viewport: vp, isMobile: true, hasTouch: true, locale: "fr-FR" });
  const page = await context.newPage();
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto(`${BASE}/coran/mushaf/50`, { waitUntil: "networkidle" });
  await page.waitForSelector("article[data-ready]", { timeout: 30000 });
  // Verset choisi : le premier mot de la 3e ligne.
  const word = page.locator(".mushaf-line[data-line] .mushaf-word").nth(20);
  const key = await word.getAttribute("data-v");
  await word.tap();
  const sheet = page.locator(`[data-verse-sheet="${key}"]`);
  await sheet.waitFor({ timeout: 10000 });
  check(`${vp.width} px : fenetre ouverte pour ${key}`, await sheet.isVisible());
  const shown = (await page.locator("[data-sheet-text]").textContent())?.trim();
  const expected = await page.evaluate((k) => Array.from(document.querySelectorAll("[data-translations] li")).find((li) => li.dataset.key === k)?.textContent?.trim(), key);
  check(`${vp.width} px : traduction identique au texte verrouille`, Boolean(expected) && shown === expected, shown?.slice(0, 60));
  const [s, v] = key.split(":");
  check(`${vp.width} px : lien tafsir`, (await page.locator("[data-sheet-tafsir]").getAttribute("href")) === `/coran/${s}/tafsir#t${v}`);
  check(`${vp.width} px : lien lecture dans la sourate`, (await page.locator("[data-sheet-read]").getAttribute("href")) === `/coran/${s}#v${s}-${v}`);
  check(`${vp.width} px : mot a mot cache au visiteur`, (await page.locator("[data-sheet-wbw]").count()) === 0);
  const over = await page.evaluate(() => document.documentElement.scrollWidth - innerWidth);
  check(`${vp.width} px : pas de debordement`, over <= 0, String(over));
  const box = await sheet.boundingBox();
  check(`${vp.width} px : fenetre dans l'ecran`, box && box.y >= 0 && box.y + box.height <= vp.height + 1, JSON.stringify(box));
  // Un autre verset remplace le premier.
  const other = page.locator(`.mushaf-word:not([data-v="${key}"])`).last();
  const otherKey = await other.getAttribute("data-v");
  await page.locator("[data-sheet-close]").tap();
  check(`${vp.width} px : fenetre fermee`, (await page.locator("[data-verse-sheet]").count()) === 0);
  await other.tap();
  await page.locator(`[data-verse-sheet="${otherKey}"]`).waitFor({ timeout: 10000 });
  check(`${vp.width} px : autre verset ${otherKey}`, true);
  // Le lien tafsir mene au bon verset.
  await page.locator("[data-sheet-tafsir]").tap();
  await page.waitForURL(/\/tafsir/, { timeout: 20000 });
  const [os, ov] = otherKey.split(":");
  check(`${vp.width} px : page du tafsir ouverte`, page.url().endsWith(`/coran/${os}/tafsir#t${ov}`) && (await page.locator(`#t${ov}`).count()) === 1, page.url());
  // Page de la sourate : pas de bouton mot a mot pour un visiteur.
  await page.goto(`${BASE}/coran/2`, { waitUntil: "networkidle" });
  check(`${vp.width} px : sourate sans mot a mot pour le visiteur`, (await page.locator("[data-wbw-verse]").count()) === 0 && (await page.locator("[data-wbw-toggle]").count()) === 0);
  const res = await page.request.get(`${BASE}/api/mot-a-mot?surah=2`);
  check(`${vp.width} px : mot a mot refuse au visiteur`, res.status() === 403);
  await context.close();
}
check("aucune erreur de page", errors.length === 0, errors.join(" | "));
await browser.close();
console.log(failed ? `${failed} echec(s)` : "Tout est correct");
process.exit(failed ? 1 : 0);
