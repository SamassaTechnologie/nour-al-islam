// Taille de l'ecriture du Mushaf a l'horizontale : boutons A- / A+, reglage garde.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
const font = (page) => page.evaluate(() => parseFloat(getComputedStyle(document.querySelector(".mushaf-lines")).fontSize));
const width = (page) => page.evaluate(() => [document.querySelector(".mushaf-lines").getBoundingClientRect().width, document.querySelector(".mushaf-stage").getBoundingClientRect().width]);

const portrait = await browser.newContext({ viewport: { width: 396, height: 859 }, isMobile: true, hasTouch: true });
const p = await portrait.newPage();
await p.goto(`${BASE}/coran/mushaf/300`, { waitUntil: "networkidle" });
await p.waitForSelector("article[data-ready]");
await p.click(".audio-bar [aria-expanded]");
check(await p.locator("[data-mushaf-zoom]").count() === 0, "verticale : pas de reglage (la page remplit deja l'ecran)");
await portrait.close();

const context = await browser.newContext({ viewport: { width: 937, height: 396 }, isMobile: true, hasTouch: true });
const page = await context.newPage();
await page.goto(`${BASE}/coran/mushaf/300`, { waitUntil: "networkidle" });
await page.waitForSelector("article[data-ready]");
const base = await font(page);
check(Math.round(base) === 40, "horizontale : 40 px par defaut", String(base));
await page.click(".audio-bar [aria-expanded]");
check(await page.locator("[data-mushaf-zoom]").count() === 1, "horizontale : reglage affiche");
await page.click("[data-zoom-in]");
await page.click("[data-zoom-in]");
const bigger = await font(page);
check(bigger > base * 1.25, "A+ agrandit", `${base} -> ${bigger}`);
check(await page.textContent("[data-zoom-value]") === "130 %", "valeur affichee");
for (let i = 0; i < 6; i++) await page.click("[data-zoom-in]", { force: true }).catch(() => undefined);
const [w, stage] = await width(page);
check(w <= stage + 1, "jamais plus large que l'ecran", `${Math.round(w)} / ${Math.round(stage)}`);
check(await page.isDisabled("[data-zoom-in]"), "A+ desactive au maximum");
for (let i = 0; i < 10; i++) await page.click("[data-zoom-out]", { force: true }).catch(() => undefined);
const smaller = await font(page);
check(Math.round(smaller) === 28, "A- reduit jusqu'a 70 %", String(smaller));
check(await page.isDisabled("[data-zoom-out]"), "A- desactive au minimum");
await page.click("[data-zoom-in]");
await page.goto(`${BASE}/coran/mushaf/301`, { waitUntil: "networkidle" });
await page.waitForSelector("article[data-ready]");
check(Math.round(await font(page)) === 32, "reglage garde d'une page a l'autre", String(await font(page)));
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
