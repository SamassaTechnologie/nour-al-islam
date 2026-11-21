// Plan de lecture (khatm) : creation, part du jour, lecture, Mushaf, retard, arret, arabe.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
const context = await browser.newContext({ viewport: { width: 360, height: 800 } });
const page = await context.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push(e.message));

await page.goto(`${BASE}/coran`, { waitUntil: "networkidle" });
check(await page.locator('[data-khatm-card="new"]').count() === 1, "page Coran : carte « Plan de lecture »");
await page.click("[data-khatm-card]");
await page.waitForURL(/\/coran\/plan/);
await page.waitForSelector('[data-khatm="new"]');
await page.click('[data-days="30"]');
check((await page.textContent("[data-per-day]")).includes("21"), "30 jours : environ 21 pages par jour", await page.textContent("[data-per-day]"));
await page.click("[data-khatm-start]");
await page.waitForSelector('[data-khatm="active"]');
check(await page.getAttribute("[data-khatm-portion]", "data-khatm-portion") === "1-20", "jour 1 : pages 1 à 20");
const range = await page.textContent("[data-khatm-portion]");
check(range.includes("1:1") && range.includes("2:134"), "repères : de 1:1 à 2:134 (page 21 commence à 2:135)", range.replace(/\s+/g, " ").slice(0, 120));
check(await page.getAttribute("[data-khatm-mushaf]", "href") === "/coran/mushaf/1", "lien vers le Mushaf à la bonne page");
await page.click("[data-khatm-mark]");
await page.waitForSelector("[data-khatm-today]");
check(await page.getAttribute("[data-khatm-portion]", "data-khatm-portion") === "21-40", "part lue : la suivante est 21 à 40");
check((await page.textContent("[data-khatm-status]")).includes("avance"), "en avance sur le jour 1", await page.textContent("[data-khatm-status]"));

await page.goto(`${BASE}/coran`, { waitUntil: "networkidle" });
const card = await page.textContent("[data-khatm-card]");
check(/21 à 40/.test(card), "carte : part suivante affichée", card);

await page.goto(`${BASE}/coran/mushaf/45`, { waitUntil: "networkidle" });
await page.goto(`${BASE}/coran/plan`, { waitUntil: "networkidle" });
await page.waitForSelector("[data-khatm-seen]");
check(await page.getAttribute("[data-khatm-seen]", "data-khatm-seen") === "45", "Mushaf ouvert à la page 45 : proposé");
await page.click("[data-khatm-seen] button");
await page.waitForSelector('[data-khatm="active"][data-done="45"]');
check(await page.getAttribute("[data-khatm-portion]", "data-khatm-portion") === "46-60", "compté jusqu'à 45 : part suivante 46 à 60");

// Retard : plan commence il y a 5 jours.
await page.evaluate(() => {
  const d = new Date(Date.now() - 5 * 86400000);
  const start = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  localStorage.setItem("nour_khatm", JSON.stringify({ days: 30, start, done: 20, log: [] }));
});
await page.reload({ waitUntil: "networkidle" });
const status = await page.textContent("[data-khatm-status]");
check(/retard de 101/.test(status), "5 jours plus tard avec 20 pages lues : en retard de 101 pages", status);

await page.click("[data-khatm-stop]");
await page.click("[data-khatm-stop]");
await page.waitForSelector('[data-khatm="new"]');
check(true, "arrêt du plan après confirmation");

// Fin du khatm
await page.evaluate(() => localStorage.setItem("nour_khatm", JSON.stringify({ days: 7, start: "2026-11-15", done: 600, log: [] })));
await page.reload({ waitUntil: "networkidle" });
check(await page.getAttribute("[data-khatm-portion]", "data-khatm-portion") === "601-604", "dernière part : 601 à 604");
check((await page.textContent("[data-khatm-portion]")).includes("114:6"), "fin : 114:6");
await page.click("[data-khatm-mark]");
await page.waitForSelector("[data-khatm-finished]");
check(true, "khatm terminé affiché");
const overflow = await page.evaluate(() => document.documentElement.scrollWidth > innerWidth);
check(!overflow, "pas de débordement à 360 px");

const ar = await browser.newContext({ viewport: { width: 360, height: 800 } });
await ar.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
const pa = await ar.newPage();
await pa.goto(`${BASE}/coran/plan`, { waitUntil: "networkidle" });
await pa.click("[data-khatm-start]");
await pa.waitForSelector("[data-khatm-portion]");
check((await pa.textContent("[data-khatm-portion]")).includes("الفاتحة"), "arabe : noms des sourates en arabe");
check(errors.length === 0, "aucune erreur", errors.join(" | "));
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
