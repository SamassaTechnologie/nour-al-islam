import { mkdir } from "node:fs/promises";
import { chromium } from "playwright-core";

const base = process.env.BASE_URL ?? "http://localhost:3000";
const out = "tests/screenshots";
await mkdir(out, { recursive: true });
const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH ?? "/usr/bin/google-chrome", args: ["--no-sandbox"] });

const variants = [
  { name: "fr-clair", locale: "fr", theme: "light" },
  { name: "ar-clair", locale: "ar", theme: "light" },
  { name: "fr-sombre", locale: "fr", theme: "dark" },
];
const pages = [["accueil", "/"], ["inscription", "/inscription"], ["coran", "/coran"]];
let problems = 0;

for (const v of variants) {
  const context = await browser.newContext({ viewport: { width: 375, height: 812 }, deviceScaleFactor: 2, isMobile: true, hasTouch: true });
  const { hostname } = new URL(base);
  await context.addCookies([
    { name: "nour_locale", value: v.locale, domain: hostname, path: "/" },
    { name: "nour_theme", value: v.theme, domain: hostname, path: "/" },
  ]);
  const page = await context.newPage();
  page.on("pageerror", (e) => { problems++; console.log("ERREUR JS", v.name, e.message); });
  for (const [label, path] of pages) {
    await page.goto(base + path, { waitUntil: "networkidle" });
    await page.waitForTimeout(1700);
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
    const small = await page.$$eval("main a, main button, header a, header button, nav a", (els) =>
      els.filter((e) => { const r = e.getBoundingClientRect(); return r.width > 0 && r.height < 44 && getComputedStyle(e).display !== "inline"; }).map((e) => e.textContent?.trim()));
    if (overflow > 0 || small.length) { problems++; console.log("PROBLEME", v.name, label, { overflow, small }); }
    await page.screenshot({ path: `${out}/${v.name}-${label}.png` });
    if (label === "accueil") await page.screenshot({ path: `${out}/${v.name}-${label}-complet.png`, fullPage: true });
  }
  await context.close();
}
await browser.close();
console.log(problems ? `${problems} probleme(s)` : "Aucun debordement ni zone tactile trop petite");
process.exit(problems ? 1 : 0);
