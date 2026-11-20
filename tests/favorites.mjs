// Favoris : bouton sur les lecons et les invocations, page /favoris, compteur dans « Mon espace ».
// Utilise un compte de test neuf. Lancer avec node.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const db = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
await db.auth.signInWithPassword({ email: `exeditor@${domain}`, password });

const LESSON = "le-tawhid", ADHKAR = "adhkar-matin-et-soir";
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const context = await browser.newContext({ viewport: { width: 375, height: 800 }, locale: "fr-FR" });
const page = await context.newPage();
page.on("pageerror", (e) => errors.push(e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });

// Visiteur : pas de bouton, page des favoris reservee.
await page.goto(`${base}/favoris`, { waitUntil: "networkidle" });
check("visiteur : /favoris redirige vers la connexion", page.url().includes("/connexion"));

await page.goto(`${base}/connexion?suivant=/favoris`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => u.pathname === "/favoris", { timeout: 20000 });
await page.waitForLoadState("networkidle");
check("compte neuf : aucun favori", await page.locator("[data-favorites-empty]").count() === 1);

const favState = async () => page.getAttribute("[data-favorite]", "data-favorite");
const toggle = async (path, expected) => {
  await page.goto(`${base}${path}`, { waitUntil: "networkidle" });
  await page.click("[data-favorite]");
  await page.waitForSelector(`[data-favorite="${expected}"]`, { timeout: 15000 });
  await page.reload({ waitUntil: "networkidle" });
  return favState();
};

await page.goto(`${base}/apprendre/${LESSON}`, { waitUntil: "networkidle" });
check("leçon : bouton présent, non coché", await favState() === "0");
check("leçon : ajoutée, état conservé après rechargement", await toggle(`/apprendre/${LESSON}`, "1") === "1");
check("bouton accessible (aria-pressed)", await page.getAttribute("[data-favorite]", "aria-pressed") === "true");
check("invocations : ajoutées, état conservé après rechargement", await toggle(`/priere/invocations/${ADHKAR}`, "1") === "1");

await page.goto(`${base}/favoris`, { waitUntil: "networkidle" });
const lessons = await page.$$eval('[data-favorites="lessons"] [data-favorite-item]', (els) => els.map((e) => [e.dataset.favoriteItem, e.querySelector("a").getAttribute("href")]));
const adhkar = await page.$$eval('[data-favorites="adhkar"] [data-favorite-item]', (els) => els.map((e) => [e.dataset.favoriteItem, e.querySelector("a").getAttribute("href")]));
check("page des favoris : la leçon, avec son lien", JSON.stringify(lessons) === JSON.stringify([[LESSON, `/apprendre/${LESSON}`]]), JSON.stringify(lessons));
check("page des favoris : les invocations, avec leur lien", JSON.stringify(adhkar) === JSON.stringify([[ADHKAR, `/priere/invocations/${ADHKAR}`]]), JSON.stringify(adhkar));

await page.goto(`${base}/profil`, { waitUntil: "networkidle" });
check("Mon espace : « Mes favoris : 2 »", (await page.textContent("[data-favorites-link]")).includes("2"));

check("leçon : retirée", await toggle(`/apprendre/${LESSON}`, "0") === "0");
await page.goto(`${base}/favoris`, { waitUntil: "networkidle" });
check("page des favoris : la leçon retirée n'apparaît plus", await page.locator('[data-favorites="lessons"]').count() === 0 && await page.locator('[data-favorites="adhkar"] [data-favorite-item]').count() === 1);

// Securite : impossible d'ecrire un favori au nom d'un autre compte.
const item = (await db.from("content_items").select("id").eq("slug", LESSON).single()).data;
const forged = await db.from("favorites").insert({ user_id: "00000000-0000-0000-0000-000000000001", item_id: item.id });
check("favori au nom d'un autre compte refusé", Boolean(forged.error), forged.error?.message ?? "accepté !");
const own = await db.from("favorites").select("item_id");
check("lecture : seulement ses propres favoris (1)", own.data?.length === 1, String(own.data?.length));

for (const width of [320, 1280]) {
  await page.setViewportSize({ width, height: 800 });
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  check(`/favoris : pas de débordement à ${width} px`, overflow <= 0, String(overflow));
}
await context.addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await page.reload({ waitUntil: "networkidle" });
check("version arabe : titre « مفضلتي »", (await page.textContent("h1")).includes("مفضلتي"));

// Visiteur sur une lecon : pas de bouton.
const visitor = await (await browser.newContext()).newPage();
await visitor.goto(`${base}/apprendre/les-28-lettres-arabes`, { waitUntil: "networkidle" });
check("visiteur : pas de bouton favori sur une leçon publiée", await visitor.locator("[data-favorite]").count() === 0);

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
