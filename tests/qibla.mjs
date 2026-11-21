// Page Qibla : angle calcule, boussole simulee (evenements d'orientation), sans capteur, ville, arabe.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
const context = await browser.newContext({ viewport: { width: 360, height: 800 }, isMobile: true, hasTouch: true });
const page = await context.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push(e.message));
// Telephone tourne vers un cap donne (alpha absolu = 360 - cap).
const turn = (heading) => page.evaluate(async (h) => {
  for (let i = 0; i < 30; i++) {
    window.dispatchEvent(new DeviceOrientationEvent("deviceorientationabsolute", { alpha: (360 - h) % 360, beta: 0, gamma: 0, absolute: true }));
    await new Promise((r) => setTimeout(r, 20));
  }
}, heading);

await page.goto(`${BASE}/priere/qibla`, { waitUntil: "networkidle" });
await page.waitForSelector("[data-qibla]");
check(await page.getAttribute("[data-qibla]", "data-bearing") === "72.3", "Bamako : 72,3° (référence géodésique 72,4°)");
check((await page.textContent("[data-qibla-status]")).includes("5"), "distance affichée", await page.textContent("[data-qibla-status]"));
await page.click("[data-qibla-start]");
await turn(72);
await page.waitForTimeout(200);
check(await page.getAttribute("[data-qibla]", "data-state") === "on", "boussole active");
check(await page.locator("[data-qibla][data-facing]").count() === 1, "face à la Qibla", await page.textContent("[data-qibla-turn]"));
await turn(0);
await page.waitForTimeout(200);
const turnText = await page.textContent("[data-qibla-turn]");
check(/droite de 7[12]°/.test(turnText), "téléphone vers le nord : tourner à droite d'environ 72°", turnText);
await turn(150);
await page.waitForTimeout(200);
check(/gauche de 7[78]°/.test(await page.textContent("[data-qibla-turn]")), "téléphone au sud-est : tourner à gauche", await page.textContent("[data-qibla-turn]"));
const dial = await page.getAttribute("[data-qibla-dial]", "style");
check(/rotate\(-1(4|5)\d/.test(dial), "le cadran tourne avec le téléphone", dial);

await page.selectOption("[data-qibla-city]", "Paris");
check(await page.getAttribute("[data-qibla]", "data-bearing") === "119.2", "Paris : 119,2° (référence 119,0°)");
await page.goto(`${BASE}/priere/horaires`, { waitUntil: "networkidle" });
check(await page.getAttribute("[data-prayer-times]", "data-place") === "Paris", "même lieu que les horaires de prière");

// Sans capteur
const p2 = await (await browser.newContext({ viewport: { width: 360, height: 800 } })).newPage();
await p2.goto(`${BASE}/priere/qibla`, { waitUntil: "networkidle" });
await p2.click("[data-qibla-start]");
await p2.waitForSelector("[data-qibla-none]", { timeout: 6000 }).then(() => check(true, "sans boussole : explication affichée")).catch(() => check(false, "sans boussole : explication affichée"));
const overflow = await p2.evaluate(() => document.documentElement.scrollWidth > innerWidth);
check(!overflow, "pas de débordement à 360 px");

// Arabe, liens
const ar = await browser.newContext({ viewport: { width: 360, height: 800 } });
await ar.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
const p3 = await ar.newPage();
await p3.goto(`${BASE}/priere/qibla`, { waitUntil: "networkidle" });
check((await p3.textContent("h1")).includes("القبلة"), "arabe : titre");
await p3.goto(`${BASE}/priere`, { waitUntil: "networkidle" });
check(await p3.locator('[data-open-qibla]').count() === 1, "lien depuis la page Prière");
await p3.goto(BASE, { waitUntil: "networkidle" });
check(await p3.locator('[data-quick="/priere/qibla"]').count() === 1, "accès rapide sur l'accueil");
check(errors.length === 0, "aucune erreur", errors.join(" | "));
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
