// Accueil : parcours cliquable, acces rapide, aucun lien mort ; texte arabe complet.
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const browser = await chromium.launch();
for (const locale of ["fr", "ar"]) {
  const context = await browser.newContext({ viewport: { width: 396, height: 859 } });
  if (locale === "ar") await context.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
  const page = await context.newPage();
  await page.goto(BASE, { waitUntil: "networkidle" });
  const steps = await page.$$eval("[data-step] a", (links) => links.map((a) => ({ href: a.getAttribute("href"), text: a.textContent.trim() })));
  check(steps.length === 5, `${locale} : 5 etapes cliquables`);
  check(steps.every((s) => s.text.length > 8), `${locale} : chaque etape a un titre et une description`, steps.map((s) => s.text.length).join(","));
  const quick = await page.$$eval("[data-quick]", (links) => links.map((a) => a.getAttribute("href")));
  check(quick.length === 8, `${locale} : 8 acces rapides`);
  check(!(await page.content()).includes("En préparation") && !(await page.content()).includes("قيد الإعداد"), `${locale} : plus de « En préparation »`);
  for (const href of [...new Set([...steps.map((s) => s.href.split("#")[0]), ...quick])]) {
    const res = await page.request.get(`${BASE}${href}`);
    check(res.status() === 200, `${locale} : ${href}`, String(res.status()));
  }
  await context.close();
}
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
