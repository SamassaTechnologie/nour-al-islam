// Parcours d'apprentissage : rubriques ordonnees, lecons numerotees, etat des exercices, place modifiable par l'equipe.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
const ARABIC = ["les-28-lettres-arabes", "voyelles-sukun-chadda", "voyelles-longues", "tanwin-et-hamza", "alif-de-liaison-et-article"];
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const anon = () => createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
async function login(name) {
  const c = anon();
  const { error } = await c.auth.signInWithPassword({ email: `${name}@${domain}`, password });
  if (error) throw new Error(`${name}: ${error.message}`);
  return c;
}
const [plain, editor] = [await login("explain"), await login("exeditor")];
const items = (await editor.from("content_items").select("id,slug,position,published_revision_id")).data;
const bySlug = Object.fromEntries(items.map((i) => [i.slug, i]));
check("places du parcours d'arabe 1 a 5", ARABIC.every((s, n) => bySlug[s]?.position === n + 1));
const tajwid = bySlug["nun-sakina-et-tanwin"];
const setPos = (c, p) => c.rpc("set_content_position", { p_item: tajwid.id, p_position: p });
check("utilisateur simple : place refusee", !!(await setPos(plain, 2)).error);
check("public : place refusee", !!(await setPos(anon(), 2)).error);
check("place hors limites refusee", !!(await setPos(editor, 1000)).error);
check("editeur : place modifiee", !(await setPos(editor, 2)).error && (await editor.from("content_items").select("position").eq("id", tajwid.id).single()).data.position === 2);
const log = (await editor.from("audit_log").select("action,from_value,to_value").eq("item_id", tajwid.id).eq("action", "position_changed")).data;
check("changement de place inscrit au journal", log.some((r) => r.from_value === "1" && r.to_value === "2"));
check("retour a la place 1", !(await setPos(editor, 1)).error);
const first = bySlug[ARABIC[0]];
const total = (await editor.from("content_questions").select("id").eq("revision_id", first.published_revision_id)).data.length;
check("resultat d'essai enregistre", !(await editor.from("quiz_attempts").insert({ item_id: first.id, revision_id: first.published_revision_id, score: total, total })).error);

const browser = await chromium.launch({ channel: "chrome" });
const errors = [];
async function open(width, name) {
  const p = await (await browser.newContext({ viewport: { width, height: 800 }, locale: "fr-FR" })).newPage();
  p.on("pageerror", (e) => errors.push(e.message));
  if (name) {
    await p.goto(`${base}/connexion?suivant=/apprendre`, { waitUntil: "networkidle" });
    await p.fill('input[name="email"]', `${name}@${domain}`);
    await p.fill('input[name="password"]', password);
    await p.click('main button[type="submit"]');
    await p.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });
  }
  await p.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
  return p;
}
const staff = await open(320, "exeditor");
const sections = await staff.$$eval("[data-section]", (els) => els.map((e) => e.getAttribute("data-section")));
check("rubriques : arabe puis Tajwid", sections[0] === "arabe" && sections[1] === "tajwid", sections.join(","));
const order = await staff.$$eval('[data-section="arabe"] [data-lesson]', (els) => els.map((e) => e.getAttribute("data-lesson")));
check("lecons d'arabe dans l'ordre du parcours", JSON.stringify(order) === JSON.stringify(ARABIC), order.join(","));
check("titre de rubrique « Lire l’arabe »", (await staff.textContent('[data-section="arabe"] h2')) === "Lire l’arabe");
check("numero 1 affiche", (await staff.textContent(`[data-lesson="${ARABIC[0]}"] a`)).includes("1"));
check("exercices faits affiches", (await staff.textContent(`[data-lesson="${ARABIC[0]}"] [data-done]`)).includes(`${total} / ${total}`));
check("exercices a faire affiches", (await staff.locator("[data-todo]").count()) === 5);
check("sans debordement a 320 px", (await staff.evaluate(() => document.documentElement.scrollWidth - innerWidth)) <= 0);
await staff.goto(`${base}/admin/contenus/${tajwid.id}`, { waitUntil: "networkidle" });
check("fiche : champ de place present", (await staff.locator('input[name="position"]').inputValue()) === "1");
const pub = await open(375);
check("public : aucune lecon provisoire", (await pub.locator("[data-lesson]").count()) === 0);
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
