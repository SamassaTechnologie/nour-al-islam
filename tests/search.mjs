// Recherche dans toute l'application (/recherche) : lecons, invocations et Coran.
// Utilise le compte de test (editeur : voit aussi les contenus relus par l'IA). Lancer avec node.
import { chromium } from "playwright";

const { BASE_URL: base, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const context = await browser.newContext({ viewport: { width: 375, height: 800 }, locale: "fr-FR" });
const page = await context.newPage();
page.on("pageerror", (e) => errors.push(e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });

const search = async (q) => {
  await page.goto(`${base}/recherche?q=${encodeURIComponent(q)}`, { waitUntil: "networkidle" });
  return page.evaluate(() => ({
    total: document.querySelector("[data-search-total]")?.dataset.searchTotal ?? null,
    lessons: [...document.querySelectorAll('[data-results="lessons"] [data-result]')].map((e) => e.dataset.result),
    adhkar: [...document.querySelectorAll('[data-results="adhkar"] [data-result]')].map((e) => e.dataset.result),
    dhikrHits: [...document.querySelectorAll("[data-dhikr-hit]")].map((e) => e.textContent),
    quran: [...document.querySelectorAll('[data-results="quran"] [data-result]')].map((e) => e.dataset.result),
    marks: [...document.querySelectorAll("[data-snippet] mark")].map((e) => e.textContent),
    more: Boolean(document.querySelector("[data-quran-more]")),
    status: document.querySelector('[role="status"]')?.textContent ?? "",
  }));
};

// Visiteur : le lien de recherche est dans l'en-tete ; les lecons non validees n'apparaissent pas.
await page.goto(base, { waitUntil: "networkidle" });
await page.click("[data-search-link]");
await page.waitForURL((u) => u.pathname === "/recherche");
check("en-tête : le lien ouvre la recherche", true);
const visitor = await search("ablutions");
check("visiteur : aucune leçon en attente des savants dans les résultats", visitor.lessons.length === 0, visitor.lessons.join());
const vq = await search("الرحمن");
check("visiteur : versets du Coran trouvés (arabe)", vq.quran.length === 10 && vq.more, `${vq.quran.length} affichés, lien « tous » : ${vq.more}`);

await page.goto(`${base}/connexion?suivant=/recherche`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => u.pathname === "/recherche", { timeout: 20000 });

const abl = await search("ablution");
check("« ablution » : les leçons sur les ablutions", ["ablutions", "ce-qui-annule-les-ablutions", "ablutions-obligations-et-avis"].every((s) => abl.lessons.includes(s)), abl.lessons.join());
const bil = await search("Bilal");
check("« Bilal » sans accent trouve « Bilāl » (persécutions, premiers musulmans)", bil.lessons.includes("persecutions-a-la-mecque") && bil.lessons.includes("premiers-musulmans-predication-secrete"), bil.lessons.join());
check("extrait surligné : « Bilāl »", bil.marks.length > 0 && bil.marks.every((m) => m.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase() === "bilal"), bil.marks.join());
const tro = await search("Trône");
check("« Trône » : la catégorie d'invocations, avec l'invocation trouvée", tro.adhkar.includes("adhkar-sommeil-et-reveil") && tro.dhikrHits.some((h) => h.includes("Trône")), tro.dhikrHits.join(" | "));
const ar = await search("ما انا بقارئ");
check("arabe sans voyelles : « ما أنا بقارئ » dans la leçon sur la révélation", ar.lessons.includes("debut-de-la-revelation"), ar.lessons.join());
check("arabe : extrait surligné vocalisé", ar.marks.some((m) => m.startsWith("مَا")), ar.marks.join());
const one = await search("a");
check("1 caractère : message « au moins 2 »", one.total === null && one.status.includes("2 caractères"), one.status);
const none = await search("zzqqxxw");
check("aucun résultat : message clair", none.total === "0" && none.status.includes("Aucun résultat"), none.status);
const pct = await search("%%");
check("caractères spéciaux (%%) : pas d'erreur, aucun résultat", pct.total === "0");

await search("tawhid");
await page.click('[data-results="lessons"] [data-result="le-tawhid"] a');
await page.waitForURL((u) => u.pathname === "/apprendre/le-tawhid");
check("clic sur un résultat : ouvre la leçon", true);

await search("Bilal");
for (const width of [320, 1280]) {
  await page.setViewportSize({ width, height: 800 });
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  check(`pas de débordement à ${width} px (en-tête compris)`, overflow <= 0, String(overflow));
}
await context.addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await page.reload({ waitUntil: "networkidle" });
check("version arabe : titre « البحث »", (await page.textContent("h1")).includes("البحث"));
await page.setViewportSize({ width: 320, height: 800 });
const overflowAr = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
check("version arabe : pas de débordement à 320 px", overflowAr <= 0, String(overflowAr));

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
