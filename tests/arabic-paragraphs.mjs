// Paragraphes arabes des lecons : sens d'ecriture, texte identique a la base, pas de debordement.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const editor = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
await editor.auth.signInWithPassword({ email: `exeditor@${domain}`, password });
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const page = await (await browser.newContext({ viewport: { width: 320, height: 800 }, locale: "fr-FR" })).newPage();
page.on("pageerror", (e) => errors.push(e.message));
await page.goto(`${base}/connexion?suivant=/apprendre`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });

const arabicStart = /^[؀-ۿ]/;
for (const slug of ["tashahhud-et-priere-sur-le-prophete", "voyelles-sukun-chadda", "ablutions", "prosternation-de-l-oubli", "awra-dans-la-priere", "horaires-des-prieres", "moments-interdits-pour-prier", "reunion-de-deux-prieres"]) {
  const item = (await editor.from("content_items").select("published_revision_id").eq("slug", slug).single()).data;
  const body = (await editor.from("content_revisions").select("body").eq("id", item.published_revision_id).single()).data.body;
  const parts = body.split(/\n\s*\n/).map((p) => p.trim()).filter(Boolean);
  await page.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
  const shown = await page.$$eval("article p[dir='auto']", (ps) => ps.map((p) => ({ text: p.textContent.trim(), dir: getComputedStyle(p).direction, align: getComputedStyle(p).textAlign })));
  check(`${slug} : tous les paragraphes affichés`, shown.length === parts.length, `${shown.length}/${parts.length}`);
  const arabic = shown.filter((p) => arabicStart.test(p.text));
  const latin = shown.filter((p) => !arabicStart.test(p.text));
  check(`${slug} : paragraphes arabes de droite à gauche (${arabic.length})`, arabic.every((p) => p.dir === "rtl"));
  check(`${slug} : paragraphes français de gauche à droite`, latin.every((p) => p.dir === "ltr"));
  check(`${slug} : texte identique à la base`, parts.every((t, i) => shown[i]?.text === t));
  check(`${slug} : pas de débordement à 320 px`, (await page.evaluate(() => document.documentElement.scrollWidth - innerWidth)) <= 0);
}
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
