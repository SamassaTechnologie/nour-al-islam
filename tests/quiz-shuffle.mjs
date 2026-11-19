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
const browser = await chromium.launch({ channel: "chrome" });
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
for (const slug of ["prosternation-de-l-oubli", "tashahhud-et-priere-sur-le-prophete"]) {
  const item = (await db.from("content_items").select("published_revision_id").eq("slug", slug).single()).data;
  const questions = (await db.from("content_questions").select("id, options, answer").eq("revision_id", item.published_revision_id).order("ord")).data;
  await page.goto(`${base}/apprendre/${slug}`, { waitUntil: "networkidle" });
  const shown0 = [];
  for (const [i, q] of questions.entries()) {
    const shown = await page.$$eval("[data-option]", (b) => b.map((x) => Number(x.dataset.option)));
    shown0.push(shown.join());
    const expected = optionOrder(q.id, q.options.length, 0);
    if (i === 0) check(`${slug} : texte des propositions conservé`, (await page.$$eval("[data-option]", (b) => b.map((x) => x.textContent.trim()))).join("|") === expected.map((n) => q.options[n]).join("|"));
    check(`${slug} q${i + 1} : ordre affiché = ordre calculé`, shown.join() === expected.join(), shown.join());
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
check("la bonne réponse n'est plus presque toujours en premier", firstIsAnswer / total < 0.6, `${firstIsAnswer}/${total}`);
check("aucune erreur (dont décalage serveur/navigateur)", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
