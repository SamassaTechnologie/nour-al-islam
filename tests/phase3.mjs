// Circuit de validation : droits reels et parcours complet contre l'application deployee.
import crypto from "node:crypto";
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
const mail = (name) => `${name}@${domain}`;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const denied = (label, r) => check(label, !!r.error, r.error?.message?.slice(0, 70) ?? "accepte a tort");

function totp(secret) {
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
  let bits = "";
  for (const c of secret.replace(/=+$/, "").toUpperCase()) bits += alphabet.indexOf(c).toString(2).padStart(5, "0");
  const raw = Buffer.from(bits.match(/.{8}/g).map((b) => parseInt(b, 2)));
  const counter = Buffer.alloc(8);
  counter.writeBigUInt64BE(BigInt(Math.floor(Date.now() / 30000)));
  const h = crypto.createHmac("sha1", raw).update(counter).digest();
  const o = h[19] & 15;
  return String((h.readUInt32BE(o) & 0x7fffffff) % 1000000).padStart(6, "0");
}
const anon = () => createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
async function login(name) {
  const c = anon();
  const { error } = await c.auth.signInWithPassword({ email: mail(name), password });
  if (error) throw new Error(`${name}: ${error.message}`);
  return c;
}
async function strong(c, secret) {
  let id = (await c.auth.mfa.listFactors()).data.totp[0]?.id;
  if (!id) {
    const e = await c.auth.mfa.enroll({ factorType: "totp", friendlyName: "essai" });
    id = e.data.id; secret = e.data.totp.secret;
  }
  const r = await c.auth.mfa.challengeAndVerify({ factorId: id, code: totp(secret) });
  if (r.error) throw new Error(r.error.message);
  return secret;
}

const browser = await chromium.launch({ channel: "chrome" });
const context = async () => browser.newContext({ viewport: { width: 375, height: 812 }, isMobile: true, hasTouch: true, locale: "fr-FR" });
const errors = [];
async function uiLogin(name, next = "/admin") {
  const ctx = await context();
  const p = await ctx.newPage();
  p.on("pageerror", (e) => errors.push(e.message));
  await p.goto(`${base}/connexion?suivant=${next}`, { waitUntil: "networkidle" });
  await p.fill('input[name="email"]', mail(name));
  await p.fill('input[name="password"]', password);
  await p.tap('main button[type="submit"]');
  return p;
}
const over = (p) => p.evaluate(() => document.documentElement.scrollWidth - innerWidth);
const status = (p, s) => p.waitForSelector(`[data-status="${s}"]`, { timeout: 20000 }).then(() => true).catch(() => false);

// Acces
const pub = await context().then((c) => c.newPage());
await pub.goto(`${base}/admin`, { waitUntil: "networkidle" });
check("visiteur renvoye vers connexion", pub.url().includes("/connexion"));
const plainUi = await uiLogin("plain", "/profil");
await plainUi.waitForURL("**/profil", { timeout: 20000 });
check("utilisateur simple sans lien admin", (await plainUi.locator('a[href="/admin"]').count()) === 0);
check("utilisateur simple : admin introuvable", (await plainUi.goto(`${base}/admin`)).status() === 404);

// Reviseur : double authentification imposee
const reviewerUi = await uiLogin("reviewer");
await reviewerUi.waitForURL("**/admin/securite", { timeout: 20000 });
check("reviseur oblige de passer par la double authentification", true);
await reviewerUi.getByRole("button", { name: "Activer la double authentification" }).tap();
await reviewerUi.waitForSelector("[data-mfa-secret]", { timeout: 20000 });
check("code QR affiche", await reviewerUi.locator('img[alt^="Code QR"]').isVisible());
const reviewerSecret = (await reviewerUi.textContent("[data-mfa-secret]")).trim();
await reviewerUi.fill('input[name="code"]', "000000");
await reviewerUi.getByRole("button", { name: "Valider" }).tap();
await reviewerUi.waitForSelector('main [role="alert"]', { timeout: 20000 });
check("mauvais code refuse", (await reviewerUi.textContent('main [role="alert"]')).includes("incorrect"));
await reviewerUi.fill('input[name="code"]', totp(reviewerSecret));
await reviewerUi.getByRole("button", { name: "Valider" }).tap();
await reviewerUi.waitForURL(/\/admin$/, { timeout: 20000 });
check("double authentification activee", true);

// Parcours complet dans l'interface
const title = `Essai phase trois ${Date.now()}`;
const editorUi = await uiLogin("editor");
await editorUi.waitForURL(/\/admin$/, { timeout: 20000 });
await editorUi.goto(`${base}/admin/utilisateurs`);
check("editeur : gestion des utilisateurs introuvable", await editorUi.locator("h1").first().textContent().then((t) => !t.includes("Utilisateurs")));
await editorUi.goto(`${base}/admin/contenus/nouveau`, { waitUntil: "networkidle" });
await editorUi.fill('input[name="title"]', title);
await editorUi.getByRole("button", { name: "Créer le brouillon" }).tap();
await editorUi.waitForURL(/contenus\/[0-9a-f-]{36}$/, { timeout: 20000 });
const itemUrl = editorUi.url();
check("brouillon cree", await status(editorUi, "draft"));
await editorUi.fill('textarea[name="body"]', "Premier paragraphe de cet essai automatique.\n\nSecond paragraphe de cet essai.");
await editorUi.getByRole("button", { name: "Enregistrer" }).tap();
await editorUi.waitForSelector("text=Enregistré.", { timeout: 20000 });
const add = async (summary, fields, button, kind) => {
  await editorUi.locator("summary", { hasText: summary }).tap();
  const box = editorUi.locator("details", { hasText: summary });
  for (const [n, v] of Object.entries(fields)) await box.locator(`[name="${n}"]`).fill(v);
  await box.getByRole("button", { name: button }).tap();
  await editorUi.waitForSelector(`[data-reference="${kind}"]`, { timeout: 20000 });
};
await add("Ajouter un verset", { ayah_from: "2" }, "Ajouter le verset", "quran");
await add("Ajouter un hadith", { collection: "RECUEIL ESSAI", edition: "Edition essai", hadith_number: "1", source_title: "Source essai", grade: "Degre essai", graded_by: "Auteur essai" }, "Ajouter le hadith", "hadith");
await add("Ajouter un ouvrage", { author: "AUTEUR ESSAI", source_title: "Ouvrage essai", locator: "p. 1" }, "Ajouter l’ouvrage", "book");
check("page contenu sans debordement", (await over(editorUi)) <= 0);
await editorUi.getByRole("button", { name: "Envoyer à la vérification des sources" }).tap();
check("envoi a la verification", await status(editorUi, "source_check"));
check("auteur ne peut pas verifier", (await editorUi.getByRole("button", { name: "Confirmer les sources" }).count()) === 0);
const checkerUi = await uiLogin("checker");
await checkerUi.waitForURL(/\/admin$/, { timeout: 20000 });
await checkerUi.goto(itemUrl, { waitUntil: "networkidle" });
for (let left = 3; left > 0; left--) {
  await checkerUi.getByRole("button", { name: "Vérifiée dans l’ouvrage d’origine" }).first().tap();
  await checkerUi.waitForFunction((n) => [...document.querySelectorAll("button")].filter((b) => b.textContent.includes("Vérifiée dans")).length === n, left - 1, { timeout: 20000 });
}
await checkerUi.getByRole("button", { name: "Confirmer les sources" }).tap();
check("sources confirmees", await status(checkerUi, "in_review"));
await reviewerUi.goto(itemUrl, { waitUntil: "networkidle" });
await reviewerUi.getByRole("button", { name: "Approuver et publier" }).tap();
check("publication par le reviseur", await status(reviewerUi, "published"));
await pub.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
check("contenu liste publiquement", (await pub.textContent("main")).includes(title));
await pub.getByRole("link", { name: new RegExp(title) }).tap();
await pub.waitForURL(/apprendre\/essai/, { timeout: 20000 });
const text = await pub.textContent("main");
check("page publique complete", text.includes("Second paragraphe") && text.includes("Reviseur Essai") && text.includes("RECUEIL ESSAI") && text.includes("AUTEUR ESSAI"));
check("verset affiche depuis le texte verrouille", text.includes("ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ"));
check("page publique sans debordement", (await over(pub)) <= 0);
const slug = pub.url().split("/").pop();

// Droits directement sur la base
const [a, plain, editor, checker, reviewer, admin] = [anon(), await login("plain"), await login("editor"), await login("checker"), await login("reviewer"), await login("admin")];
denied("simple utilisateur ne cree pas de contenu", await plain.rpc("create_content", { p_slug: "x-essai", p_kind: "lesson", p_section: "fiqh", p_locale: "fr", p_title: "Titre" }));
denied("reviseur ne cree pas de contenu", await reviewer.rpc("create_content", { p_slug: "x-essai", p_kind: "lesson", p_section: "fiqh", p_locale: "fr", p_title: "Titre" }));
const made = await editor.rpc("create_content", { p_slug: `essai-droits-${Date.now()}`, p_kind: "legal_opinion", p_section: "fiqh", p_locale: "fr", p_title: "Essai droits" });
const item = made.data;
const rev = (await editor.from("content_revisions").select("id").eq("item_id", item).single()).data.id;
check("brouillon invisible au public", ((await a.from("content_revisions").select("id").eq("id", rev)).data ?? []).length === 0);
check("brouillon invisible a un simple utilisateur", ((await plain.from("content_revisions").select("id").eq("id", rev)).data ?? []).length === 0);
await editor.from("content_revisions").update({ body: "Texte de plus de vingt caracteres pour cet essai." }).eq("id", rev);
denied("verset inexistant refuse", await editor.from("content_references").insert({ revision_id: rev, kind: "quran", surah: 2, ayah_from: 287, ayah_to: 287 }));
denied("hadith sans degre refuse", await editor.from("content_references").insert({ revision_id: rev, kind: "hadith", collection: "A", edition: "B", hadith_number: "1", source_title: "C" }));
denied("lien non securise refuse", await editor.from("content_references").insert({ revision_id: rev, kind: "book", author: "A", source_title: "B", locator: "C", url: "http://exemple.org" }));
denied("verification ecrite directement refusee", await editor.from("content_references").insert({ revision_id: rev, kind: "book", author: "A", source_title: "B", locator: "C", verified_name: "Faux" }));
const ins = await editor.from("content_references").insert({ revision_id: rev, kind: "quran", surah: 1, ayah_from: 1, ayah_to: 1 }).select("id").single();
const refId = ins.data.id;
denied("avis juridique sans avis refuse", await editor.rpc("content_action", { p_revision: rev, p_action: "submit" }));
await editor.from("content_opinions").insert({ revision_id: rev, holder: "Ecole essai", opinion: "Avis essai", source: "Source essai" });
check("envoi accepte", !(await editor.rpc("content_action", { p_revision: rev, p_action: "submit" })).error);
check("texte verrouille apres envoi", ((await editor.from("content_revisions").update({ body: "Modification interdite apres envoi." }).eq("id", rev).select("id")).data ?? []).length === 0);
denied("reference verrouillee apres envoi", await editor.from("content_references").insert({ revision_id: rev, kind: "book", author: "A", source_title: "B", locator: "C" }));
denied("auteur ne verifie pas sa reference", await editor.rpc("verify_content_reference", { p_reference: refId, p_verified: true }));
denied("sources non verifiees refusees", await checker.rpc("content_action", { p_revision: rev, p_action: "confirm_sources" }));
await checker.rpc("verify_content_reference", { p_reference: refId, p_verified: true });
denied("auteur ne confirme pas ses sources", await editor.rpc("content_action", { p_revision: rev, p_action: "confirm_sources" }));
check("sources confirmees", !(await checker.rpc("content_action", { p_revision: rev, p_action: "confirm_sources" })).error);
denied("editeur ne publie pas", await checker.rpc("content_action", { p_revision: rev, p_action: "publish" }));
denied("reviseur sans second facteur ne publie pas", await reviewer.rpc("content_action", { p_revision: rev, p_action: "publish" }));
denied("administrateur sans second facteur ne liste pas les comptes", await admin.rpc("admin_list_users"));
denied("simple utilisateur ne liste pas les comptes", await plain.rpc("admin_list_users"));
await strong(admin);
denied("administrateur ne publie pas", await admin.rpc("content_action", { p_revision: rev, p_action: "publish" }));
await strong(reviewer, reviewerSecret);
denied("renvoi sans motif refuse", await reviewer.rpc("content_action", { p_revision: rev, p_action: "request_changes" }));
check("renvoi pour corrections", !(await reviewer.rpc("content_action", { p_revision: rev, p_action: "request_changes", p_note: "A corriger" })).error);
check("verifications annulees au renvoi", (await editor.from("content_references").select("verified_at").eq("id", refId).single()).data.verified_at === null);
await editor.from("content_revisions").update({ body: "Texte corrige de plus de vingt caracteres." }).eq("id", rev);
await editor.rpc("content_action", { p_revision: rev, p_action: "submit" });
await checker.rpc("verify_content_reference", { p_reference: refId, p_verified: true });
await checker.rpc("content_action", { p_revision: rev, p_action: "confirm_sources" });
check("publication avec second facteur", !(await reviewer.rpc("content_action", { p_revision: rev, p_action: "publish" })).error);
const body = async () => (await a.from("content_revisions").select("body").eq("id", rev)).data?.[0]?.body;
check("public voit la version approuvee", (await body()) === "Texte corrige de plus de vingt caracteres.");
const hidden = await a.from("content_revisions").select("content_hash").eq("id", rev);
check("colonnes internes cachees au public", !!hidden.error);
check("statut non modifiable directement", !!(await editor.from("content_revisions").update({ status: "published" }).eq("id", rev)).error);
check("version publiee non modifiable", ((await editor.from("content_revisions").update({ body: "Falsification du contenu publie." }).eq("id", rev).select("id")).data ?? []).length === 0);
const next = (await editor.rpc("new_content_revision", { p_item: item })).data;
await editor.from("content_revisions").update({ body: "Nouvelle version non encore relue par personne." }).eq("id", next);
check("modification sans effet public avant relecture", (await body()) === "Texte corrige de plus de vingt caracteres.");
check("references copiees dans la nouvelle version", ((await editor.from("content_references").select("verified_at").eq("revision_id", next)).data ?? []).every((r) => r.verified_at === null));
denied("deuxieme version ouverte refusee", await editor.rpc("new_content_revision", { p_item: item }));
denied("editeur ne retire pas", await editor.rpc("content_action", { p_revision: rev, p_action: "withdraw", p_note: "x" }));
denied("retrait sans motif refuse", await reviewer.rpc("content_action", { p_revision: rev, p_action: "withdraw" }));
check("retrait par l'administrateur", !(await admin.rpc("content_action", { p_revision: rev, p_action: "withdraw", p_note: "Essai" })).error);
check("contenu retire invisible", (await body()) === undefined);
check("journal invisible a un simple utilisateur", ((await plain.from("audit_log").select("id")).data ?? []).length === 0);
denied("journal non modifiable en insertion", await editor.from("audit_log").insert({ actor_name: "Faux", action: "publish" }));
check("journal non supprimable", !!(await reviewer.from("audit_log").delete().eq("item_id", item)).error);
const trail = ((await editor.from("audit_log").select("action,actor_name").eq("item_id", item).order("id")).data ?? []).map((r) => r.action);
check("historique complet", ["created", "submit", "confirm_sources", "request_changes", "publish", "new_version", "withdraw"].every((x) => trail.includes(x)), trail.length + " entrees");
const users = await admin.rpc("admin_list_users");
check("administrateur liste les comptes", (users.data ?? []).length >= 5);
const target = users.data.find((u) => u.email === mail("plain"));
denied("reviseur ne change pas les roles", await reviewer.rpc("admin_set_role", { p_user: target.id, p_role: "admin" }));
denied("role non modifiable par soi-meme", await plain.from("profiles").update({ role: "admin" }).eq("id", target.id));
check("administrateur change un role", !(await admin.rpc("admin_set_role", { p_user: target.id, p_role: "editor" })).error);
check("role applique", (await plain.from("profiles").select("role").eq("id", target.id).single()).data.role === "editor");
await admin.rpc("admin_set_role", { p_user: target.id, p_role: "user" });

// Interface administrateur
const adminUi = await uiLogin("admin");
await adminUi.waitForURL("**/admin/securite", { timeout: 20000 });
check("administrateur doit saisir son code", (await adminUi.locator('input[name="code"]').count()) === 1);
await pub.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
check("premier contenu toujours public", pub.url().includes(slug) && (await pub.textContent("h1")).includes(title));
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
