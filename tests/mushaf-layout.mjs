// Mesure du remplissage de l'ecran par le Mushaf (telephone et tablette).
// Usage : BASE_URL=https://nour-al-islam.vercel.app node tests/mushaf-layout.mjs
import { chromium } from "playwright";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
const VIEWPORTS = [
  { name: "telephone", width: 396, height: 859, standalone: true },
  { name: "petit", width: 360, height: 740, standalone: true },
  { name: "tablette", width: 820, height: 1180, standalone: false },
];
const PAGES = [1, 2, 50, 300, 604];

const browser = await chromium.launch();
const report = [];
for (const vp of VIEWPORTS) {
  const context = await browser.newContext({ viewport: { width: vp.width, height: vp.height }, deviceScaleFactor: 2, isMobile: vp.width < 600, hasTouch: true });
  const page = await context.newPage();
  for (const n of PAGES) {
    await page.goto(`${BASE}/coran/mushaf/${n}`, { waitUntil: "networkidle" });
    await page.waitForSelector("article[data-ready]", { timeout: 30000 }).catch(() => undefined);
    const m = await page.evaluate(() => {
      const r = (el) => (el ? el.getBoundingClientRect() : null);
      const stage = r(document.querySelector(".mushaf-stage"));
      const lines = document.querySelector(".mushaf-lines");
      const lr = r(lines);
      const rows = [...document.querySelectorAll(".mushaf-line")];
      const used = rows.map((row) => [...row.children].reduce((s, c) => s + c.getBoundingClientRect().width, 0));
      const font = lines ? parseFloat(getComputedStyle(lines).fontSize) : 0;
      return {
        stage: stage && { w: Math.round(stage.width), h: Math.round(stage.height), top: Math.round(stage.top) },
        lines: lr && { w: Math.round(lr.width), h: Math.round(lr.height), top: Math.round(lr.top) },
        font: Math.round(font * 10) / 10,
        rows: rows.length,
        maxUsedEm: font ? Math.round((Math.max(...used) / font) * 100) / 100 : 0,
        bar: r(document.querySelector(".audio-bar"))?.top,
        full: rows.filter((row) => row.hasAttribute("data-full")).length,
      };
    });
    report.push({ vp: vp.name, page: n, ...m });
  }
  await context.close();
}
console.log(JSON.stringify(report));
await browser.close();
