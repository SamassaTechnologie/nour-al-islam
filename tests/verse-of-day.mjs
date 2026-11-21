// Verset du jour : reference attendue pour la date, texte arabe identique au texte verrouille, liens, arabe.
import { chromium } from "playwright";
import { execSync } from "node:child_process";

const BASE = process.env.BASE_URL ?? "https://nour-al-islam.vercel.app";
const { SUPABASE_URL: url, SUPABASE_KEY: key } = process.env;
let failures = 0;
const check = (ok, label, extra = "") => {
  console.log(`${ok ? "OK " : "ECHEC"} ${label}${extra ? ` (${extra})` : ""}`);
  if (!ok) failures++;
};
const src = execSync("npx --yes esbuild src/lib/verse-of-day.ts --bundle=false --format=esm --log-level=error").toString();
const list = JSON.parse(src.match(/VERSES_OF_DAY = (\[[\s\S]*?\]);/)[1]);
const now = new Date();
const day = Math.floor(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()) / 86400000);
const [s, n] = list[day % list.length];

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 360, height: 800 } });
await page.goto(BASE, { waitUntil: "networkidle" });
const ref = await page.getAttribute("[data-verse-of-day]", "data-verse-of-day");
check(ref === `${s}:${n}`, "verset attendu pour aujourd'hui", `${ref} / ${s}:${n}`);
const shown = (await page.textContent("[data-verse-of-day] [lang=ar]")).trim();
const res = await fetch(`${url}/rest/v1/ayahs?select=text_uthmani,bismillah_length&surah=eq.${s}&number=eq.${n}`, { headers: { apikey: key } });
const [row] = await res.json();
check(shown === row.text_uthmani.slice(row.bismillah_length).trim(), "texte arabe identique au texte verrouillé");
await page.click("[data-verse-tafsir] summary");
check((await page.textContent("[data-verse-tafsir]")).length > 40, "explication du Tafsir affichée");
const links = await page.$$eval("[data-verse-of-day] a", (as) => as.map((a) => a.getAttribute("href")));
for (const href of links) {
  const r = await page.request.get(`${BASE}${href.split("#")[0]}`);
  check(r.status() === 200, `lien ${href}`);
}
check(!(await page.evaluate(() => document.documentElement.scrollWidth > innerWidth)), "pas de débordement à 360 px");
const ar = await browser.newContext({ viewport: { width: 360, height: 800 } });
await ar.addCookies([{ name: "nour_locale", value: "ar", url: BASE }]);
const pa = await ar.newPage();
await pa.goto(BASE, { waitUntil: "networkidle" });
check((await pa.textContent("#verset-du-jour")).includes("آية اليوم"), "arabe : titre");
await browser.close();
console.log(failures ? `${failures} echec(s)` : "Tout est correct");
process.exit(failures ? 1 : 0);
