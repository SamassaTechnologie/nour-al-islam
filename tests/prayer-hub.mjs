// Page Priere et page Apprendre vues par un visiteur : message juste, liste cliquable, rubriques pliables.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 396, height: 859 } });
const errors = [];
page.on("pageerror", (e) => errors.push(e.message));

await page.goto(`${BASE}/priere`, { waitUntil: "networkidle" });
const status = await page.textContent("[data-section-status]");
check(!/pas encore ouverte/.test(status), "Priere : plus de « pas encore ouverte »", status);
const links = await page.$$eval("[data-planned-link]", (as) => as.map((a) => a.getAttribute("href")));
check(links.length === 4, "Priere : les 4 elements de la liste sont cliquables", links.join(" "));
for (const href of links) {
  const res = await page.request.get(`${BASE}${href.split("#")[0]}`);
  check(res.status() === 200, `lien ${href}`, String(res.status()));
}
await page.click('[data-planned-link][href="/priere/horaires"]');
await page.waitForURL(/\/priere\/horaires/);
check(true, "clic vers les horaires");

await page.goto(`${BASE}/apprendre#rubrique-priere`, { waitUntil: "networkidle" });
const learn = await page.textContent("[data-section-status]");
check(/mémorisation/.test(learn), "Apprendre : message juste", learn);
const sections = await page.$$eval("details[data-section]", (els) => els.map((e) => ({ id: e.id, open: e.open })));
check(sections.length === 0, "Apprendre (visiteur) : aucune lecon visible avant validation", String(sections.length));
check(errors.length === 0, "aucune erreur dans la page", errors.join(" | "));

// Arabe
const ar = await browser.newContext({ viewport: { width: 396, height: 859 } });
await ar.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
const pa = await ar.newPage();
await pa.goto(`${BASE}/priere`, { waitUntil: "networkidle" });
check(/مواقيت الصلاة متاحة/.test(await pa.textContent("[data-section-status]")), "arabe : message juste");
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
