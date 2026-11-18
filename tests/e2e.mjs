// Parcours reel a la taille iPhone 13 mini, contre l'application deployee et Supabase.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright-core";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, USER_A: a, TEST_PASSWORD: password, CHROME_PATH: chrome } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => {
  if (!ok) failed++;
  console.log(`${ok ? "OK    " : "ECHEC "} ${label}${detail ? ` : ${detail}` : ""}`);
};

const browser = await chromium.launch({ executablePath: chrome || undefined, args: ["--no-sandbox"] });
const context = await browser.newContext({ viewport: { width: 375, height: 812 }, deviceScaleFactor: 3, isMobile: true, hasTouch: true });
const page = await context.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push(e.message));
const rtlOverflow = () => page.evaluate(() => document.documentElement.scrollWidth - innerWidth);

const home = await page.goto(base, { waitUntil: "networkidle" });
check("accueil accessible", home.status() === 200);
check("nom affiche", (await page.textContent("h1")).includes("NOUR AL-ISLAM"));
check("en-tetes de securite", home.headers()["x-frame-options"] === "DENY" && home.headers()["x-content-type-options"] === "nosniff");
check("manifeste", (await page.request.get(`${base}/manifest.webmanifest`)).ok());
check("icone iPhone", (await page.request.get(`${base}/icons/apple-touch-icon.png`)).ok());

await page.goto(`${base}/profil`, { waitUntil: "networkidle" });
check("espace protege sans session", page.url().includes("/connexion"));

await page.goto(`${base}/inscription`, { waitUntil: "networkidle" });
await page.fill('input[name="name"]', "Essai Inscription");
await page.fill('input[name="email"]', `essai.${Date.now()}@example.com`);
await page.fill('input[name="password"]', password);
await page.tap('main button[type="submit"]');
await page.waitForSelector('main [role="status"], main [role="alert"]', { timeout: 20000 }).catch(() => {});
console.log("INFO   resultat inscription :", (await page.textContent("main")).replace(/\s+/g, " ").slice(0, 170));

await page.goto(`${base}/connexion`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', a);
await page.fill('input[name="password"]', "mauvais-mot-de-passe");
await page.tap('main button[type="submit"]');
await page.waitForSelector('main [role="alert"]', { timeout: 20000 });
check("mauvais mot de passe refuse", (await page.textContent('main [role="alert"]')).includes("incorrect"));

await page.fill('input[name="password"]', password);
await page.tap('main button[type="submit"]');
await page.waitForURL("**/profil", { timeout: 20000 });
check("connexion reussie", (await page.textContent("h1")).includes("Compte A"));
check("pas de debordement sur le profil", (await rtlOverflow()) <= 0);

await page.fill('input[name="name"]', "Compte A modifie");
await page.tap('main form:has(input[name="name"]) button[type="submit"]');
await page.waitForSelector('main [role="status"]', { timeout: 20000 });
await page.reload({ waitUntil: "networkidle" });
check("nom modifie et conserve", (await page.textContent("h1")).includes("Compte A modifie"));

await page.tap('main button:has-text("العربية")');
await page.waitForSelector('html[dir="rtl"]', { timeout: 20000 });
check("arabe et sens droite-gauche", (await page.getAttribute("html", "lang")) === "ar");
check("pas de debordement en arabe", (await rtlOverflow()) <= 0);
await page.tap('main button:has-text("داكن")');
await page.waitForSelector('html[data-theme="dark"]', { timeout: 20000 });
check("mode sombre", true);
await page.tap('main button:has-text("Français")');
await page.waitForSelector('html[dir="ltr"]', { timeout: 20000 });

await page.tap('main button:has-text("Me déconnecter")');
await page.waitForURL(`${base}/`, { timeout: 20000 });
await page.goto(`${base}/profil`, { waitUntil: "networkidle" });
check("deconnexion effective", page.url().includes("/connexion"));
check("aucune erreur JavaScript", errors.length === 0, errors.join(" | "));
await browser.close();

const anon = createClient(url, key, { auth: { persistSession: false } });
const anonRead = await anon.from("profiles").select("id");
check("visiteur anonyme sans acces aux profils", Boolean(anonRead.error) || anonRead.data.length === 0);

const sb = createClient(url, key, { auth: { persistSession: false } });
const { data: login, error: loginError } = await sb.auth.signInWithPassword({ email: a, password });
check("connexion directe", !loginError);
const me = login.user.id;
const all = await sb.from("profiles").select("id, role");
check("un utilisateur ne lit que son profil", all.data?.length === 1 && all.data[0].id === me);
const escalate = await sb.from("profiles").update({ role: "admin" }).eq("id", me).select();
check("impossible de se donner le role admin", Boolean(escalate.error), escalate.error?.message);
const after = await sb.from("profiles").select("role").eq("id", me).single();
check("role inchange", after.data?.role === "user");
const other = await sb.from("profiles").update({ display_name: "Pirate" }).neq("id", me).select();
check("impossible de modifier un autre compte", !other.error && other.data.length === 0);
const bad = await sb.from("profiles").update({ display_name: "x" }).eq("id", me).select();
check("nom invalide refuse par la base", Boolean(bad.error));

console.log(failed ? `${failed} echec(s)` : "Tous les controles sont passes");
process.exit(failed ? 1 : 0);
