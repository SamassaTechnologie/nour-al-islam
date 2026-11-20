// Hors connexion : pages gardees par le service worker, page « Pas de connexion », Coran complet, effacement.
// Lancer avec PW_CHANNEL=chromium (Chromium complet).
import { chromium } from "playwright";

const base = process.env.BASE_URL;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const context = await browser.newContext({ locale: "fr-FR", timezoneId: "Africa/Bamako", viewport: { width: 390, height: 844 } });
const page = await context.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push(e.message));

await page.goto(base, { waitUntil: "networkidle" });
await page.waitForFunction(async () => Boolean(await navigator.serviceWorker.getRegistration("/")), null, { timeout: 20000 });
await page.reload({ waitUntil: "networkidle" });
check("service worker actif sur la page", await page.evaluate(() => Boolean(navigator.serviceWorker.controller)));

for (const path of ["/coran/1", "/priere/horaires", "/priere/invocations", "/connexion"]) await page.goto(base + path, { waitUntil: "networkidle" });
const fatihaOnline = (await page.goto(base + "/coran/1", { waitUntil: "networkidle" }), await page.textContent("h1"));

await context.setOffline(true);
await page.goto(base + "/coran/1", { waitUntil: "domcontentloaded" });
check("hors connexion : sourate déjà ouverte lisible", (await page.textContent("h1")) === fatihaOnline && await page.locator("[data-ayah-id]").count() === 7, await page.textContent("h1"));
await page.waitForSelector("[data-offline-banner]");
check("bandeau « Hors connexion » affiché", (await page.textContent("[data-offline-banner]")).includes("Hors connexion"));
await page.goto(base + "/priere/horaires", { waitUntil: "domcontentloaded" });
await page.waitForSelector("[data-prayer]");
check("hors connexion : horaires de prière calculés", await page.locator("[data-prayer]").count() === 6);
await page.goto(base + "/coran/2", { waitUntil: "domcontentloaded" });
check("page jamais ouverte : page « Pas de connexion »", await page.locator("[data-offline-page]").count() === 1);
await page.goto(base + "/connexion", { waitUntil: "domcontentloaded" });
check("page de connexion jamais gardée", await page.locator("[data-offline-page]").count() === 1);
await context.setOffline(false);

// Tout le Coran.
await page.goto(base + "/coran", { waitUntil: "networkidle" });
await page.click("[data-save-quran] button");
await page.waitForSelector('[data-save-quran="saved"]', { timeout: 240000 });
const usage = await page.evaluate(async () => (await navigator.storage.estimate()).usage);
console.log(`INFO  espace utilisé sur l'appareil : ${(usage / 1e6).toFixed(1)} Mo`);
await context.setOffline(true);
let all = true;
for (const n of [2, 18, 36, 114]) {
  await page.goto(`${base}/coran/${n}`, { waitUntil: "domcontentloaded" });
  if (await page.locator("[data-offline-page]").count() || !(await page.locator("[data-ayah-id]").count())) { all = false; console.log("  manque", n); }
}
check("Coran gardé : sourates 2, 18, 36 et 114 lisibles hors connexion", all);
await context.setOffline(false);

// Changement de session (connexion ou deconnexion) : les pages gardees sont effacees.
await page.evaluate(() => localStorage.setItem("nour_signed_in", "1"));
await page.goto(base + "/priere", { waitUntil: "networkidle" });
await page.waitForTimeout(1500);
await context.setOffline(true);
await page.goto(`${base}/coran/36`, { waitUntil: "domcontentloaded" });
check("après changement de session : pages gardées effacées", await page.locator("[data-offline-page]").count() === 1);
await context.setOffline(false);

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
