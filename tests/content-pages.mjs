// Pages des lecons vues par l'equipe : contenu, references (Coran, hadiths, livres), avis des savants, quiz.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const editor = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
await editor.auth.signInWithPassword({ email: `exeditor@${domain}`, password });
const items = (await editor.from("content_items").select("id,slug,published_revision_id").not("published_revision_id", "is", null)).data;
check("10 lecons publiees", items.length === 10, String(items.length));

const browser = await chromium.launch({ channel: "chrome" });
const errors = [];
const page = await (await browser.newContext({ viewport: { width: 320, height: 800 }, locale: "fr-FR" })).newPage();
page.on("pageerror", (e) => errors.push(e.message));
await page.goto(`${base}/connexion?suivant=/apprendre`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });

for (const item of items) {
  const rev = item.published_revision_id;
  const [refs, opinions, questions] = await Promise.all([
    editor.from("content_references").select("kind,url").eq("revision_id", rev),
    editor.from("content_opinions").select("holder").eq("revision_id", rev),
    editor.from("content_questions").select("id").eq("revision_id", rev),
  ]);
  const res = await page.goto(`${base}/apprendre/${item.slug}`, { waitUntil: "networkidle" });
  const text = await page.textContent("main");
  const hadiths = refs.data.filter((r) => r.kind === "hadith").length;
  const links = refs.data.filter((r) => r.url).length;
  const problems = [];
  if (res.status() !== 200) problems.push(`statut ${res.status()}`);
  if ((await page.locator("main li.py-3").count()) < refs.data.length) problems.push("references manquantes");
  if (hadiths && (text.match(/Degré :/g) ?? []).length !== hadiths) problems.push("degres des hadiths");
  if ((await page.locator("[data-source-link]").count()) !== links) problems.push("liens de source");
  if (opinions.data.length && !opinions.data.every((o) => text.includes(o.holder))) problems.push("avis des savants");
  if (questions.data.length && !text.includes(`Question 1 sur ${questions.data.length}`)) problems.push("quiz");
  if (!text.includes("en attente de validation par des savants")) problems.push("mention provisoire");
  if (text.includes("undefined") || text.includes("null")) problems.push("valeur vide affichee");
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - innerWidth);
  if (overflow > 0) problems.push(`debordement ${overflow}px`);
  check(`${item.slug} (${refs.data.length} ref., ${hadiths} hadiths, ${opinions.data.length} avis, ${questions.data.length} questions)`, problems.length === 0, problems.join(", "));
}
await page.goto(`${base}/apprendre/ablutions-obligations-et-avis`, { waitUntil: "networkidle" });
check("titre « Avis des savants » et note de prudence", (await page.textContent("main")).includes("Avis des savants") && (await page.textContent("main")).includes("consultez un savant qualifié"));
check("lien lisible vers sunnah.com", (await page.locator("[data-source-link]").allTextContents()).some((t) => t === "Voir la source sur sunnah.com"));
await page.screenshot({ path: "/vercel/essai/avis.png", fullPage: true });
await page.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
const sections = await page.$$eval("[data-section]", (els) => els.map((e) => e.getAttribute("data-section")));
check("rubriques : arabe, tajwid, purification", sections.join(",") === "arabe,tajwid,purification", sections.join(","));
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
