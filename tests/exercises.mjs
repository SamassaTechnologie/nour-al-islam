// Exercices des lecons : questions relues avec la version, quiz en ligne, resultats personnels.
import crypto from "node:crypto";
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
const LETTERS = "les-28-lettres-arabes";
const NUN = "nun-sakina-et-tanwin";
// Extraits attendus, releves dans le texte verrouille (verifie a la creation des questions).
const EXPECTED = {
  "2:62": "مَنْ ءَامَنَ", "113:2": "مِن شَرِّ", "55:15": "مِّن نَّارٍ", "2:173": "غَفُورٌ رَّحِيمٌ",
  "2:33": "أَنۢبِئْهُم", "106:4": "جُوعٍ وَءَامَنَهُم", "78:14": "مَآءً ثَجَّاجًا", "87:16": "ٱلدُّنْيَا",
};
const mail = (name) => `${name}@${domain}`;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const denied = (label, r) => check(label, !!r.error, r.error?.message?.slice(0, 80) ?? "accepte a tort");
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
async function words(surah, ayah, from, to) {
  const v = rows(await a.from("ayahs").select("text_uthmani,bismillah_length").eq("surah", surah).eq("number", ayah))[0];
  return v.text_uthmani.slice(v.bismillah_length).trim().split(" ").slice(from - 1, to).join(" ");
}

const [plain, editor, reviewer, admin] = [await login("explain"), await login("exeditor"), await login("exreviewer"), await login("exadmin")];
const plainId = (await plain.auth.getUser()).data.user.id;

// 1. Questions des lecons relues par l'IA : visibles par l'equipe seulement.
const lesson = {};
for (const [slug, count] of [[LETTERS, 8], [NUN, 12]]) {
  const item = rows(await editor.from("content_items").select("id,published_revision_id").eq("slug", slug))[0];
  const questions = rows(await editor.from("content_questions").select("*").eq("revision_id", item.published_revision_id).order("ord"));
  lesson[slug] = { ...item, questions };
  check(`equipe : ${slug}, ${count} questions`, questions.length === count, String(questions.length));
  check(`public : questions de ${slug} cachees`, rows(await a.from("content_questions").select("id").eq("revision_id", item.published_revision_id)).length === 0);
  check(`utilisateur simple : questions de ${slug} cachees`, rows(await plain.from("content_questions").select("id").eq("revision_id", item.published_revision_id)).length === 0);
}
for (const q of lesson[NUN].questions.filter((x) => x.surah)) {
  const ref = `${q.surah}:${q.ayah}`;
  // Comparaison a equivalence canonique pres : l'ordre chadda/voyelle du texte source est conserve tel quel a l'affichage.
  check(`extrait ${ref} : les mots voulus`, (await words(q.surah, q.ayah, q.word_from, q.word_to)).normalize("NFC") === EXPECTED[ref].normalize("NFC"));
}
check("huit extraits coraniques dans la lecon 2", lesson[NUN].questions.filter((x) => x.surah).length === 8);
check("aucun extrait dans la lecon 1", lesson[LETTERS].questions.every((x) => !x.surah));

// 2. Resultats : seulement les siens, sur la version publiee, avec le bon total.
const nun = lesson[NUN];
const old = rows(await editor.from("content_revisions").select("id").eq("item_id", nun.id).eq("number", 1))[0].id;
const attempt = (c, extra = {}) => c.from("quiz_attempts").insert({ item_id: nun.id, revision_id: nun.published_revision_id, score: 5, total: 12, ...extra });
denied("public : resultat refuse", await attempt(a));
denied("utilisateur simple : resultat refuse sur une lecon provisoire", await attempt(plain));
denied("total faux refuse", await attempt(editor, { total: 10 }));
denied("score superieur au total refuse", await attempt(editor, { score: 13 }));
denied("ancienne version refusee", await attempt(editor, { revision_id: old }));
denied("resultat au nom d'un autre refuse", await attempt(editor, { user_id: plainId }));

// 3. Controle des questions sur un brouillon d'essai.
const slug = `essai-exercices-${Date.now()}`;
const made = await editor.rpc("create_content", { p_slug: slug, p_kind: "lesson", p_section: "tajwid", p_locale: "fr", p_title: "Essai exercices" });
const itemId = made.data;
const draft = rows(await editor.from("content_revisions").select("id").eq("item_id", itemId))[0].id;
await editor.from("content_revisions").update({ body: "Texte d'essai pour les exercices, assez long." }).eq("id", draft);
const q = { revision_id: draft, prompt: "Question d'essai ?", options: ["Oui", "Non"], answer: 0, explanation: "Explication d'essai." };
const add = (c, extra = {}) => c.from("content_questions").insert({ ...q, ...extra });
denied("verset inexistant refuse", await add(editor, { surah: 1, ayah: 8, word_from: 1, word_to: 1 }));
denied("mots hors du verset refuses", await add(editor, { surah: 1, ayah: 7, word_from: 9, word_to: 20 }));
denied("extrait incomplet refuse", await add(editor, { surah: 1, ayah: 7 }));
denied("bonne reponse hors des choix refusee", await add(editor, { answer: 2 }));
denied("choix vide refuse", await add(editor, { options: ["Oui", "  "] }));
denied("choix identiques refuses", await add(editor, { options: ["Oui", "Oui "] }));
denied("un seul choix refuse", await add(editor, { options: ["Oui"] }));
denied("utilisateur simple : ajout refuse", await add(plain));
denied("public : ajout refuse", await add(a));
check("question valide avec extrait ajoutee", !(await add(editor, { surah: 1, ayah: 7, word_from: 3, word_to: 3 })).error);

// 4. Navigateur : formulaire d'administration, puis quiz.
const browser = await chromium.launch({ channel: "chrome" });
const errors = [];
const page = async (width = 375, cookies = []) => {
  const context = await browser.newContext({ viewport: { width, height: 800 }, isMobile: width < 700, hasTouch: width < 700, locale: "fr-FR" });
  if (cookies.length) await context.addCookies(cookies);
  const p = await context.newPage();
  p.on("pageerror", (e) => errors.push(e.message));
  return p;
};
const over = (p) => p.evaluate(() => document.documentElement.scrollWidth - innerWidth);
async function signIn(p, name, next) {
  await p.goto(`${base}/connexion?suivant=${next}`, { waitUntil: "networkidle" });
  await p.fill('input[name="email"]', mail(name));
  await p.fill('input[name="password"]', password);
  await p.click('main button[type="submit"]');
  await p.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });
}

const staff = await page(375);
await signIn(staff, "exeditor", "/apprendre");
await staff.goto(`${base}/admin/contenus/${itemId}`, { waitUntil: "networkidle" });
check("fiche : une question listee", (await staff.locator("[data-question-admin]").count()) === 1);
await staff.click("summary:has-text('Ajouter une question')");
const qform = staff.locator("form").filter({ has: staff.locator('input[name="option_1"]') });
await qform.locator('input[name="prompt"]').fill("Quel mot suit le nūn dans cet extrait ?");
await qform.locator('select[name="surah"]').selectOption("1");
await qform.locator('input[name="ayah"]').fill("7");
await qform.locator('input[name="word_from"]').fill("4");
await qform.locator('input[name="word_to"]').fill("4");
await qform.locator('input[name="option_1"]').fill("Premier choix");
await qform.locator('input[name="option_2"]').fill("Deuxième choix");
await qform.locator('input[name="option_4"]').fill("Quatrième choix");
await qform.locator('select[name="answer"]').selectOption("4");
await qform.locator('textarea[name="explanation"]').fill("Explication du formulaire.");
await qform.getByRole("button", { name: "Ajouter la question" }).click();
await staff.waitForFunction(() => document.querySelectorAll("[data-question-admin]").length === 2, null, { timeout: 15000 }).catch(() => {});
const added = rows(await editor.from("content_questions").select("*").eq("revision_id", draft).order("ord"))[1];
check("formulaire : choix vides retires et bonne reponse conservee", JSON.stringify(added?.options) === JSON.stringify(["Premier choix", "Deuxième choix", "Quatrième choix"]) && added?.answer === 2);
check("formulaire : extrait lu dans le texte verrouille", (await staff.locator("[data-excerpt]").nth(1).textContent()) === (await words(1, 7, 4, 4)));
check("fiche sans debordement", (await over(staff)) <= 0);
await staff.locator("[data-question-admin]").nth(1).locator("text=Retirer").click();
await staff.waitForFunction(() => document.querySelectorAll("[data-question-admin]").length === 1, null, { timeout: 15000 }).catch(() => {});
check("formulaire : question retiree", rows(await editor.from("content_questions").select("id").eq("revision_id", draft)).length === 1);

// Quiz complet de la lecon 2, avec une erreur volontaire, sur un petit ecran.
async function runQuiz(p, questions, wrongAt = -1) {
  for (let i = 0; i < questions.length; i++) {
    const x = questions[i];
    await p.waitForSelector(`[data-question="${i}"]`);
    if (x.surah) {
      check(`quiz : extrait ${x.surah}:${x.ayah} affiche tel quel`, (await p.textContent("[data-excerpt]")) === (await words(x.surah, x.ayah, x.word_from, x.word_to)));
      check(`quiz : sourate et verset ${x.surah}:${x.ayah} indiques`, (await p.textContent("figcaption")).includes(`verset ${x.ayah}`));
    }
    if (x.display) check(`quiz : lettre ${x.display} affichee`, (await p.textContent("[data-display]")) === x.display);
    const pick = i === wrongAt ? (x.answer + 1) % x.options.length : x.answer;
    await p.click(`[data-option="${pick}"]`);
    const verdict = await p.getAttribute("[data-verdict]", "data-verdict");
    if (i === wrongAt || i === 0) check(`quiz : verdict ${i === wrongAt ? "faux" : "juste"} et explication`, verdict === (i === wrongAt ? "wrong" : "correct") && (await p.textContent("[data-explanation]")) === x.explanation);
    else if (verdict !== "correct") check(`quiz : question ${i + 1}`, false, verdict);
    if (i === 0) check("quiz : le focus passe au bouton suivant", await p.waitForFunction(() => document.activeElement?.hasAttribute("data-next"), null, { timeout: 3000 }).then(() => true, () => false));
    if ((await over(p)) > 0) check(`quiz : debordement a la question ${i + 1}`, false);
    await p.click("[data-next]");
  }
}
const small = await page(320);
await signIn(small, "exeditor", `/apprendre/${NUN}`);
await small.goto(`${base}/apprendre/${NUN}`, { waitUntil: "networkidle" });
check("lecon 2 : quiz present", (await small.locator("[data-quiz]").count()) === 1 && (await small.textContent("[data-quiz]")).includes("Question 1 sur 12"));
await runQuiz(small, nun.questions, 1);
await small.waitForSelector("[data-saved]", { timeout: 15000 }).catch(() => {});
check("lecon 2 : resultat 11 / 12 enregistre", (await small.textContent("[data-score]")).includes("11 / 12"));
await small.reload({ waitUntil: "networkidle" });
check("lecon 2 : meilleur resultat affiche", (await small.textContent("[data-best]")).includes("11 / 12"));
check("lecon 2 sans debordement a 320 px", (await over(small)) <= 0);

await staff.goto(`${base}/apprendre/${LETTERS}`, { waitUntil: "networkidle" });
await runQuiz(staff, lesson[LETTERS].questions);
await staff.waitForSelector("[data-saved]", { timeout: 15000 }).catch(() => {});
check("lecon 1 : resultat 8 / 8 enregistre", (await staff.textContent("[data-score]")).includes("8 / 8"));
const mine = rows(await editor.from("quiz_attempts").select("item_id,score,total"));
check("resultats de l'editeur enregistres", mine.length === 2 && mine.some((r) => r.score === 11 && r.total === 12) && mine.some((r) => r.score === 8 && r.total === 8));
check("chacun ne voit que ses resultats", rows(await plain.from("quiz_attempts").select("id")).length === 0);
await staff.goto(`${base}/profil`, { waitUntil: "networkidle" });
check("mon espace : deux lecons avec exercices", (await staff.textContent("[data-exercised]")).includes(": 2"));
await staff.goto(`${base}/admin/contenus/${nun.id}`, { waitUntil: "networkidle" });
check("fiche lecon 2 : 12 questions dont 8 extraits", (await staff.locator("[data-question-admin]").count()) === 12 && (await staff.locator("[data-excerpt]").count()) === 8);
check("fiche lecon 2 : version publiee non modifiable", (await staff.locator("text=Ajouter une question").count()) === 0);

const wide = await page(1280);
await signIn(wide, "exeditor", `/apprendre/${NUN}`);
await wide.goto(`${base}/apprendre/${NUN}`, { waitUntil: "networkidle" });
check("ordinateur : quiz sans debordement", (await wide.locator("[data-quiz]").count()) === 1 && (await over(wide)) <= 0);
const arabic = await page(375);
await signIn(arabic, "exeditor", `/apprendre/${NUN}`);
// La connexion reprend la langue du profil : on choisit l'arabe ensuite.
await arabic.context().addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await arabic.goto(`${base}/apprendre/${NUN}`, { waitUntil: "networkidle" });
const arText = await arabic.textContent("[data-quiz]");
check("interface arabe : quiz traduit", arText.includes("تمارين") && arText.includes("السؤال 1 من 12"), arText.slice(0, 60));

// 5. Parcours humain : publication avec questions, verrou, quiz public, nouvelle version.
const ref = (await editor.from("content_references").insert({ revision_id: draft, kind: "quran", surah: 1, ayah_from: 7, ayah_to: 7 }).select("id").single()).data.id;
const act = (c, x, n) => c.rpc("content_action", { p_revision: draft, p_action: x, p_note: n });
check("parcours humain : envoi", !(await act(editor, "submit")).error);
denied("question verrouillee apres envoi", await add(editor));
await editor.from("content_questions").delete().eq("revision_id", draft);
check("retrait impossible apres envoi", rows(await editor.from("content_questions").select("id").eq("revision_id", draft)).length === 1);
await strong(admin);
await strong(reviewer);
check("parcours humain : verification", !(await admin.rpc("verify_content_reference", { p_reference: ref, p_verified: true })).error);
check("parcours humain : sources confirmees", !(await act(admin, "confirm_sources")).error);
check("parcours humain : publication", !(await act(reviewer, "publish")).error);
check("public : questions publiees lisibles", rows(await a.from("content_questions").select("id").eq("revision_id", draft)).length === 1);
check("utilisateur : resultat enregistre", !(await plain.from("quiz_attempts").insert({ item_id: itemId, revision_id: draft, score: 1, total: 1 })).error);
check("utilisateur : voit son resultat", rows(await plain.from("quiz_attempts").select("id")).length === 1);
const pub = await page(375);
await pub.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
const pubQuestions = rows(await a.from("content_questions").select("*").eq("revision_id", draft).order("ord"));
await runQuiz(pub, pubQuestions);
check("public : resultat sans enregistrement, invitation a se connecter", (await pub.textContent("[data-score]")).includes("1 / 1") && (await pub.locator("[data-saved]").count()) === 0 && (await pub.locator('a[href*="/connexion"]').count()) >= 1);
const next = await editor.rpc("new_content_revision", { p_item: itemId });
check("nouvelle version : questions reprises", !next.error && next.data && rows(await editor.from("content_questions").select("id").eq("revision_id", next.data)).length === 1);
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ESSAI", slug, draft);
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
