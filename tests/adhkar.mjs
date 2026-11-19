// Invocations : texte arabe identique a la source, compteur, sources, acces, affichage a 320 px.
// ADHKAR_JSON : fichier produit par scripts/adhkar/extract.py (texte exact decoupe dans les recueils).
import { readFileSync } from "node:fs";
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain, ADHKAR_JSON: sourceFile = "/tmp/h/adhkar.json" } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const source = Object.values(JSON.parse(readFileSync(sourceFile, "utf8")));
const sourceTexts = new Set(source.map((s) => s.arabic));
const SLUGS = ["adhkar-matin-et-soir", "adhkar-sommeil-et-reveil", "adhkar-mosquee", "adhkar-apres-la-priere"];

const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];

// Visiteur : les invocations relues seulement par l'IA ne sont pas visibles.
const visitor = await (await browser.newContext({ viewport: { width: 320, height: 800 }, locale: "fr-FR" })).newPage();
visitor.on("pageerror", (e) => errors.push(e.message));
await visitor.goto(`${base}/priere/invocations`, { waitUntil: "networkidle" });
check("visiteur : aucune invocation provisoire affichée", (await visitor.$$("[data-adhkar-category]")).length === 0 && !!(await visitor.$("[data-empty]")));
const hidden = await visitor.goto(`${base}/priere/invocations/${SLUGS[0]}`, { waitUntil: "networkidle" });
check("visiteur : page d'une catégorie provisoire introuvable", hidden.status() === 404, String(hidden.status()));
const anon = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
const { data: anonRows } = await anon.from("content_adhkar").select("id");
check("visiteur : aucune invocation lisible par l'API", (anonRows ?? []).length === 0, String((anonRows ?? []).length));

// Equipe : connexion avec un compte editeur temporaire.
const page = await (await browser.newContext({ viewport: { width: 320, height: 800 }, locale: "fr-FR" })).newPage();
page.on("pageerror", (e) => errors.push(e.message));
await page.goto(`${base}/connexion?suivant=/priere`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });

await page.goto(`${base}/priere`, { waitUntil: "networkidle" });
check("Prière : lien vers les invocations", !!(await page.$('[data-open-adhkar][href="/priere/invocations"]')));
await page.goto(`${base}/priere/invocations`, { waitUntil: "networkidle" });
const categories = await page.$$eval("[data-adhkar-category]", (els) => els.map((e) => e.getAttribute("data-adhkar-category")));
check("liste des catégories dans l'ordre", categories.join() === SLUGS.join(), categories.join(", "));
check("catégories marquées provisoires", (await page.$$("[data-adhkar-category] [data-provisional]")).length === SLUGS.length);

const shownTexts = [];
for (const slug of SLUGS) {
  await page.goto(`${base}/priere/invocations/${slug}`, { waitUntil: "networkidle" });
  const cards = await page.$$eval("[data-dhikr]", (els) => els.map((e) => {
    const ar = e.querySelector("[data-arabic]");
    return { arabic: ar.textContent, dir: getComputedStyle(ar).direction, lang: ar.getAttribute("lang"), translit: !!e.querySelector("[data-translit]")?.textContent.trim(), repeat: Number(e.querySelector("[data-repeat]").dataset.repeat), counter: !!e.querySelector("[data-counter]"), source: e.querySelector("[data-source]")?.textContent ?? "", link: e.querySelector("[data-source-link]")?.getAttribute("href") ?? "" };
  }));
  shownTexts.push(...cards.map((c) => c.arabic));
  check(`${slug} : ${cards.length} invocations affichées`, cards.length > 0);
  check(`${slug} : texte arabe identique, caractère par caractère, au texte de la source`, cards.every((c) => sourceTexts.has(c.arabic)), cards.filter((c) => !sourceTexts.has(c.arabic)).map((c) => c.arabic.slice(0, 20)).join(" | "));
  check(`${slug} : arabe de droite à gauche`, cards.every((c) => c.dir === "rtl" && c.lang === "ar"));
  check(`${slug} : phonétique présente`, cards.every((c) => c.translit));
  check(`${slug} : source avec degré d'authenticité et lien sunnah.com`, cards.every((c) => /Degré d’authenticité/.test(c.source) && c.link.startsWith("https://sunnah.com/")));
  check(`${slug} : compteur seulement pour les invocations répétées`, cards.every((c) => c.counter === (c.repeat > 1)));
  check(`${slug} : bandeau provisoire`, !!(await page.$("[data-provisional]")));
  check(`${slug} : pas de débordement à 320 px`, (await page.evaluate(() => document.documentElement.scrollWidth - innerWidth)) <= 0);
}
check("toutes les invocations de la source sont affichées", source.every((s) => shownTexts.includes(s.arabic)), `${shownTexts.length}/${source.length}`);

// Compteur : trois touchers pour une invocation a dire trois fois, puis remise a zero.
await page.goto(`${base}/priere/invocations/${SLUGS[0]}`, { waitUntil: "networkidle" });
const counter = page.locator('[data-counter][data-total="3"]').first();
const button = counter.locator("button[data-count]");
for (let i = 0; i < 3; i++) await button.click();
check("compteur : 3 sur 3 après trois touchers", (await counter.locator("[data-progress]").textContent()).trim() === "3 sur 3");
check("compteur : bouton « Terminé » désactivé", (await button.textContent()).trim() === "Terminé" && await button.isDisabled());
await counter.locator("[data-reset]").click();
check("compteur : « Recommencer » remet à zéro", (await counter.locator("[data-progress]").textContent()).trim() === "0 sur 3" && !(await button.isDisabled()));
const hundred = page.locator('[data-counter][data-total="100"]').first();
for (let i = 0; i < 100; i++) await hundred.locator("button[data-count]").click();
check("compteur : 100 sur 100 pour « subḥāna llāhi wa bi-ḥamdih »", (await hundred.locator("[data-progress]").textContent()).trim() === "100 sur 100");

// Les invocations ne se melangent pas aux lecons.
await page.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
check("Apprendre : aucune catégorie d'invocations", (await page.$$('[data-section="adhkar"]')).length === 0);
await page.goto(`${base}/apprendre/adhkar-mosquee`, { waitUntil: "networkidle" });
check("ancienne adresse redirigée vers la Prière", page.url().endsWith("/priere/invocations/adhkar-mosquee"), page.url());

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
