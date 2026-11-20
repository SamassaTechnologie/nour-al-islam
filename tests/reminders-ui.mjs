// Rappels : interface sur la page des horaires (etats, aide iPhone, service worker).
import { chromium } from "playwright";

const base = process.env.BASE_URL;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const watch = (p) => { p.on("pageerror", (e) => errors.push(e.message)); };

// Navigateur courant : section affichee, choix coches par defaut, bouton d'activation.
const ctx = await browser.newContext({ locale: "fr-FR", timezoneId: "Africa/Bamako" });
const page = await ctx.newPage(); watch(page);
await page.goto(`${base}/priere/horaires`, { waitUntil: "networkidle" });
await page.waitForSelector('[data-reminders="off"], [data-reminders="unsupported"]');
const state = await page.getAttribute("[data-reminders]", "data-reminders");
check("section Rappels affichée (navigateur compatible)", state === "off", state);
check("rappels des prières et des invocations cochés par défaut", await page.isChecked('[data-choice="prayers"]') && await page.isChecked('[data-choice="adhkar"]'));
await page.uncheck('[data-choice="prayers"]'); await page.uncheck('[data-choice="adhkar"]');
check("rien de coché : bouton d'activation désactivé", await page.isDisabled("[data-reminders-toggle]"));
await page.reload({ waitUntil: "networkidle" });
await page.waitForSelector('[data-reminders="off"]');
check("choix gardés après rechargement", !(await page.isChecked('[data-choice="prayers"]')) && !(await page.isChecked('[data-choice="adhkar"]')));
check("mention de confidentialité affichée", (await page.textContent('[data-reminders]')).includes("environ 1 km"));
const sw = await page.evaluate(async () => (await fetch("/sw.js")).status);
check("service worker publié (/sw.js)", sw === 200, String(sw));

// Activation avec permission accordee (le service de notifications du navigateur de test peut refuser l'abonnement).
const granted = await browser.newContext({ locale: "fr-FR", permissions: ["notifications"] });
const g = await granted.newPage(); watch(g);
await g.goto(`${base}/priere/horaires`, { waitUntil: "networkidle" });
await g.waitForSelector('[data-reminders="off"]');
await g.click("[data-reminders-toggle]");
await g.waitForFunction(() => document.querySelector('[data-reminders="on"]') || document.querySelector('[data-reminders] [role="alert"]'), null, { timeout: 30000 });
const after = await g.getAttribute("[data-reminders]", "data-reminders");
const registered = await g.evaluate(async () => Boolean(await navigator.serviceWorker.getRegistration("/")));
check("service worker enregistré après « Activer »", registered);
console.log(`INFO  activation dans le navigateur de test : ${after === "on" ? "abonnement créé" : "refusée par le service de notifications du navigateur de test (message d'erreur affiché)"}`);
if (after === "on") {
  check("message « Rappels activés pour Bamako »", (await g.textContent("[data-reminders-on]")).includes("Bamako"));
  await g.click("[data-reminders-toggle]");
  await g.waitForSelector('[data-reminders="off"]', { timeout: 20000 });
  check("désactivation", true);
} else {
  check("échec d'abonnement : message clair", (await g.textContent('[data-reminders] [role="alert"]')).includes("Réessayez"));
}

// iPhone sans ajout a l'ecran d'accueil : aide affichee.
const ios = await browser.newContext({ locale: "fr-FR", userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1", viewport: { width: 390, height: 844 } });
await ios.addInitScript(() => { delete window.PushManager; });
const i = await ios.newPage(); watch(i);
await i.goto(`${base}/priere/horaires`, { waitUntil: "networkidle" });
await i.waitForSelector('[data-reminders="ios"]');
check("iPhone : aide « Sur l'écran d'accueil » en 4 étapes", (await i.$$("[data-ios-help] li")).length === 4 && (await i.textContent("[data-ios-help]")).includes("Sur l’écran d’accueil"));
await i.setViewportSize({ width: 320, height: 800 });
check("iPhone : pas de débordement à 320 px", await i.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth) <= 0);

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
