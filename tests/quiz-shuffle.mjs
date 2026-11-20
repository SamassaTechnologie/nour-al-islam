// Melange des propositions en ligne : ordre affiche = ordre calcule, pas de decalage serveur/navigateur,
// bonne reponse reconnue, nouvel ordre apres « Recommencer ».
// Placer quiz-order.ts a cote (copie de src/lib/quiz-order.ts) ; lancer avec node --experimental-strip-types.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";
import { optionOrder } from "./quiz-order.ts";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const db = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
await db.auth.signInWithPassword({ email: `exeditor@${domain}`, password });
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const page = await (await browser.newContext({ viewport: { width: 375, height: 800 }, locale: "fr-FR" })).newPage();
page.on("pageerror", (e) => errors.push(e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });
await page.goto(`${base}/connexion?suivant=/apprendre`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => !u.href.includes("/connexion"), { timeout: 20000 });

let firstIsAnswer = 0, total = 0;
for (const slug of ["prosternation-de-l-oubli", "tashahhud-et-priere-sur-le-prophete", "horaires-des-prieres", "moments-interdits-pour-prier", "reunion-de-deux-prieres", "raccourcir-la-priere-en-voyage", "priere-en-groupe", "priere-du-vendredi", "islam-iman-ihsan", "six-piliers-de-la-foi", "le-tawhid", "sommeil-conscience-et-toucher", "la-qalqala", "naissance-et-enfance", "jeunesse-khadija-kaaba", "debut-de-la-revelation", "premiers-musulmans-predication-secrete", "debut-predication-publique", "persecutions-a-la-mecque", "emigration-en-abyssinie", "nawawi-01-les-intentions", "nawawi-02-hadith-de-jibril", "nawawi-03-les-cinq-piliers", "nawawi-04-creation-et-destin", "nawawi-05-innovations-rejetees", "nawawi-06-licite-illicite-et-douteux", "nawawi-07-la-religion-est-le-bon-conseil", "nawawi-08-le-sang-et-les-biens-proteges", "nawawi-09-eviter-l-interdit-faire-ce-que-l-on-peut", "nawawi-10-allah-n-accepte-que-ce-qui-est-bon", "nawawi-11-laisser-ce-qui-fait-douter", "nawawi-12-delaisser-ce-qui-ne-nous-regarde-pas", "nawawi-13-aimer-pour-son-frere", "nawawi-14-le-sang-du-musulman-est-sacre", "nawawi-15-dire-du-bien-ou-se-taire", "nawawi-16-ne-te-mets-pas-en-colere", "nawawi-17-l-excellence-en-toute-chose", "nawawi-18-crains-allah-ou-que-tu-sois", "nawawi-19-preserve-allah-il-te-preservera", "nawawi-20-la-pudeur", "nawawi-21-je-crois-en-allah-puis-sois-droit", "nawawi-22-les-obligations-menent-au-paradis", "nawawi-23-la-purification-moitie-de-la-foi", "nawawi-24-l-injustice-est-interdite", "nawawi-25-chaque-glorification-est-une-aumone", "nawawi-26-une-aumone-pour-chaque-articulation", "nawawi-27-la-bonte-et-le-peche", "nawawi-28-attachez-vous-a-ma-sunna", "nawawi-29-l-oeuvre-qui-mene-au-paradis", "nawawi-30-obligations-limites-interdits", "nawawi-31-le-detachement-du-bas-monde", "nawawi-32-pas-de-prejudice", "nawawi-33-la-preuve-incombe-au-demandeur", "nawawi-34-changer-le-mal", "nawawi-35-le-musulman-est-le-frere-du-musulman", "nawawi-36-soulager-son-frere", "nawawi-37-la-generosite-d-allah-envers-les-intentions", "nawawi-38-les-allies-d-allah", "nawawi-39-l-erreur-l-oubli-et-la-contrainte", "nawawi-40-sois-comme-un-etranger", "nawawi-41-que-ses-penchants-suivent-la-revelation", "nawawi-42-o-fils-d-adam-tant-que-tu-m-invoques"]) {
  const item = (await db.from("content_items").select("published_revision_id").eq("slug", slug).single()).data;
  const questions = (await db.from("content_questions").select("id, options, answer, surah, ayah, word_from, word_to").eq("revision_id", item.published_revision_id).order("ord")).data;
  await page.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
  const shown0 = [];
  for (const [i, q] of questions.entries()) {
    const shown = await page.$$eval("[data-option]", (b) => b.map((x) => Number(x.dataset.option)));
    shown0.push(shown.join());
    const expected = optionOrder(q.id, q.options.length, 0);
    if (i === 0) check(`${slug} : texte des propositions conservé`, (await page.$$eval("[data-option]", (b) => b.map((x) => x.textContent.trim()))).join("|") === expected.map((n) => q.options[n]).join("|"));
    check(`${slug} q${i + 1} : ordre affiché = ordre calculé`, shown.join() === expected.join(), shown.join());
    if (q.surah) {
      const verse = (await db.from("ayahs").select("text_uthmani, bismillah_length").eq("surah", q.surah).eq("number", q.ayah).single()).data;
      const expectedWords = verse.text_uthmani.slice(verse.bismillah_length).trim().split(" ").slice(q.word_from - 1, q.word_to).join(" ");
      check(`${slug} q${i + 1} : extrait coranique lu dans le texte verrouillé`, (await page.textContent("[data-excerpt]")).trim() === expectedWords);
    }
    if (shown[0] === q.answer) firstIsAnswer++;
    total++;
    await page.click(`[data-option="${q.answer}"]`);
    check(`${slug} q${i + 1} : bonne réponse reconnue après mélange`, (await page.getAttribute("[data-verdict]", "data-verdict")) === "correct");
    await page.click("[data-next]");
  }
  check(`${slug} : score complet`, (await page.textContent("[data-score]")).includes(`${questions.length} / ${questions.length}`));
  await page.getByRole("button", { name: /recommencer/i }).click();
  const after = optionOrder(questions[0].id, questions[0].options.length, 1).join();
  check(`${slug} : après « Recommencer », ordre de la tentative suivante`, (await page.$$eval("[data-option]", (b) => b.map((x) => x.dataset.option))).join() === after);
  const changed = questions.filter((q, i) => optionOrder(q.id, q.options.length, 1).join() !== shown0[i]).length;
  check(`${slug} : l'ordre change pour la plupart des questions`, changed >= questions.length / 2, `${changed}/${questions.length}`);
}
await page.goto(`${base}/apprendre`, { waitUntil: "networkidle" });
const priere = await page.$$eval('[data-section="priere"] [data-lesson]', (els) => els.map((e) => e.getAttribute("data-lesson")));
check("ordre de la rubrique Prière : horaires en 2e, réunion en 9e, raccourcissement en 10e, prière en groupe en 11e, vendredi en 12e", priere.length === 12 && priere[1] === "horaires-des-prieres" && priere[8] === "reunion-de-deux-prieres" && priere[9] === "raccourcir-la-priere-en-voyage" && priere[10] === "priere-en-groupe" && priere[11] === "priere-du-vendredi", priere.join(", "));
check("la bonne réponse n'est plus presque toujours en premier", firstIsAnswer / total < 0.6, `${firstIsAnswer}/${total}`);
check("aucune erreur (dont décalage serveur/navigateur)", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
