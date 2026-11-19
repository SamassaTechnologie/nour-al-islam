// Relecture par l'IA : contenus visibles par l'equipe seulement, puis valides par un reviseur humain.
import crypto from "node:crypto";
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain, AI_SLUG: slug } = process.env;
const REAL = ["les-28-lettres-arabes", "nun-sakina-et-tanwin"];
const mail = (name) => `${name}@${domain}`;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const denied = (label, r) => check(label, !!r.error, r.error?.message?.slice(0, 70) ?? "accepte a tort");
const rows = (r) => r.data ?? [];
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
async function strong(c) {
  const e = await c.auth.mfa.enroll({ factorType: "totp", friendlyName: "essai" });
  if (e.error) throw new Error(e.error.message);
  const r = await c.auth.mfa.challengeAndVerify({ factorId: e.data.id, code: totp(e.data.totp.secret) });
  if (r.error) throw new Error(r.error.message);
}

const a = anon();
const [plain, editor, reviewer, admin] = [await login("aiplain"), await login("aieditor"), await login("aireviewer"), await login("aiadmin")];
for (const s of [...REAL, slug]) {
  check(`public : ${s} invisible`, rows(await a.from("content_items").select("id").eq("slug", s)).length === 0);
  check(`utilisateur simple : ${s} invisible`, rows(await plain.from("content_items").select("id").eq("slug", s)).length === 0);
  const item = rows(await editor.from("content_items").select("published_revision_id").eq("slug", s))[0];
  const rev = item && rows(await editor.from("content_revisions").select("review_kind,status").eq("id", item.published_revision_id))[0];
  check(`equipe : ${s} visible et marque IA`, rev?.review_kind === "ai" && rev?.status === "published");
}
const test = rows(await editor.from("content_items").select("id,published_revision_id").eq("slug", slug))[0];
const rev = test.published_revision_id;
check("revision IA cachee au public", rows(await a.from("content_revisions").select("id").eq("id", rev)).length === 0);
check("references IA cachees au public", rows(await a.from("content_references").select("id").eq("revision_id", rev)).length === 0);
denied("relecture IA impossible depuis l'application", await admin.rpc("ai_review", { p_revision: rev, p_note: "x" }));

const browser = await chromium.launch({ channel: "chrome" });
const page = async () => {
  const p = await (await browser.newContext({ viewport: { width: 375, height: 812 }, isMobile: true, hasTouch: true, locale: "fr-FR" })).newPage();
  p.on("pageerror", (e) => errors.push(e.message));
  return p;
};
const errors = [];
const over = (p) => p.evaluate(() => document.documentElement.scrollWidth - innerWidth);
const pub = await page();
check("public : page provisoire introuvable", (await pub.goto(`${base}/apprendre/${slug}`)).status() === 404);
check("public : lecon relue par l'IA introuvable", (await pub.goto(`${base}/apprendre/${REAL[1]}`)).status() === 404);
await pub.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
check("public : aucune lecon provisoire listee", (await pub.locator("[data-provisional]").count()) === 0);

const staff = await page();
await staff.goto(`${base}/connexion?suivant=/apprendre`, { waitUntil: "networkidle" });
await staff.fill('input[name="email"]', mail("aieditor"));
await staff.fill('input[name="password"]', password);
await staff.tap('main button[type="submit"]');
await staff.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });
check("equipe : lecons provisoires listees", (await staff.locator("[data-provisional]").count()) >= 3);
for (const s of REAL) {
  await staff.goto(`${base}/apprendre/${s}`, { waitUntil: "networkidle" });
  const text = await staff.textContent("main");
  check(`equipe : ${s} avec avertissement`, (await staff.locator('[role="note"][data-provisional]').count()) === 1 && text.includes("en attente de validation par des savants"));
  check(`${s} sans debordement`, (await over(staff)) <= 0);
  if (s === REAL[1]) check("exemples, versets et sources affiches", text.includes("أَنْعَمْتَ") && text.includes("مِثْقَالَ") && text.includes("Tuḥfat al-Aṭfāl") && text.includes("Ibn ʿAbd al-Wahhāb"));
  if (s === REAL[0]) check("correction du ʿayn en ligne", text.includes("ʿayn : son du milieu de la gorge") && text.includes("Ibn al-Jazarī"));
}
await staff.goto(`${base}/admin`, { waitUntil: "networkidle" });
check("tableau de bord : contenus relus par l'IA comptes", Number(await staff.textContent('[data-count="ai"]')) >= 3);
const lessonId = rows(await editor.from("content_items").select("id").eq("slug", REAL[1]))[0].id;
await staff.goto(`${base}/admin/contenus/${lessonId}`, { waitUntil: "networkidle" });
const detail = await staff.textContent("main");
check("fiche : statut et attente des savants", detail.includes("Relu par l’IA, en attente des savants") && detail.includes("En attente de la validation d’un réviseur religieux") && detail.includes("Voir la version provisoire"));
check("fiche : historique de la relecture IA", detail.includes("Relecture par l’assistant IA") && detail.includes("Corrections par l’assistant IA"));
check("fiche sans debordement", (await over(staff)) <= 0);

const act = (c, action, note) => c.rpc("content_action", { p_revision: rev, p_action: action, p_note: note });
denied("editeur ne valide pas", await act(editor, "validate"));
denied("reviseur sans second facteur ne valide pas", await act(reviewer, "validate"));
await strong(admin);
denied("administrateur ne valide pas", await act(admin, "validate"));
await strong(reviewer);
check("validation par le reviseur", !(await act(reviewer, "validate", "Relu")).error);
const pubRev = rows(await a.from("content_revisions").select("review_kind,reviewer_name").eq("id", rev))[0];
check("contenu valide visible par le public", pubRev?.review_kind === "scholar" && pubRev?.reviewer_name === "Savant Essai");
denied("double validation refusee", await act(reviewer, "validate"));
await pub.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
check("page publique avec le nom du reviseur", (await pub.textContent("main")).includes("Contenu relu et validé par Savant Essai") && (await pub.locator("[data-provisional]").count()) === 0);
const trail = rows(await editor.from("audit_log").select("action").eq("revision_id", rev).order("id")).map((r) => r.action);
check("historique : relecture IA puis validation", trail.includes("ai_review") && trail.includes("validate"), trail.join(","));

const made = await editor.rpc("create_content", { p_slug: `essai-humain-${Date.now()}`, p_kind: "lesson", p_section: "tajwid", p_locale: "fr", p_title: "Essai humain" });
const hrev = rows(await editor.from("content_revisions").select("id").eq("item_id", made.data))[0].id;
await editor.from("content_revisions").update({ body: "Texte d'essai humain de plus de vingt caracteres." }).eq("id", hrev);
const href = (await editor.from("content_references").insert({ revision_id: hrev, kind: "quran", surah: 1, ayah_from: 2, ayah_to: 2 }).select("id").single()).data.id;
const hact = (c, x, n) => c.rpc("content_action", { p_revision: hrev, p_action: x, p_note: n });
check("parcours humain : envoi", !(await hact(editor, "submit")).error);
check("parcours humain : verification", !(await admin.rpc("verify_content_reference", { p_reference: href, p_verified: true })).error);
check("parcours humain : sources confirmees", !(await hact(admin, "confirm_sources")).error);
check("parcours humain : publication", !(await hact(reviewer, "publish")).error);
check("parcours humain : public et valide", rows(await a.from("content_revisions").select("review_kind").eq("id", hrev))[0]?.review_kind === "scholar");
denied("parcours humain : validation inutile refusee", await hact(reviewer, "validate"));
check("parcours humain : retrait", !(await hact(admin, "withdraw", "Essai")).error);
check("parcours humain : retire invisible", rows(await a.from("content_revisions").select("id").eq("id", hrev)).length === 0);
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
