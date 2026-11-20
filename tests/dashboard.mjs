// Tableau de bord personnel (/profil) : serie de jours, journee, prochaine lecon, memorisation, rubriques.
// Utilise un compte de test neuf (aucune activite). Lancer avec node --experimental-strip-types.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key, TEST_PASSWORD: password, MAIL_DOMAIN: domain } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const db = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
const { data: auth } = await db.auth.signInWithPassword({ email: `exeditor@${domain}`, password });
const userId = auth.user.id;
const today = new Date().toISOString().slice(0, 10);

const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const page = await (await browser.newContext({ viewport: { width: 375, height: 800 }, locale: "fr-FR" })).newPage();
page.on("pageerror", (e) => errors.push(e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });

// Visiteur : redirige vers la connexion.
await page.goto(`${base}/profil`, { waitUntil: "networkidle" });
check("visiteur redirigé vers la connexion", page.url().includes("/connexion"));

await page.goto(`${base}/connexion?suivant=/profil`, { waitUntil: "networkidle" });
await page.fill('input[name="email"]', `exeditor@${domain}`);
await page.fill('input[name="password"]', password);
await page.click('main button[type="submit"]');
await page.waitForURL((u) => u.pathname === "/profil", { timeout: 20000 });
await page.waitForSelector("[data-dashboard]");

const read = () => page.evaluate(() => ({
  streak: Number(document.querySelector("[data-streak]").dataset.streak),
  week: [...document.querySelectorAll("[data-week] [data-day]")].map((e) => [e.dataset.day, e.dataset.active]),
  exercises: document.querySelector("[data-today-exercises]").textContent.trim(),
  reviews: document.querySelector("[data-today-reviews]").textContent.trim(),
  reading: document.querySelector("[data-today-reading]").textContent.trim(),
  next: document.querySelector("[data-next]").dataset.next,
  memorised: Number(document.querySelector("[data-memorised]").dataset.memorised),
  sections: Object.fromEntries([...document.querySelectorAll("[data-progress-section]")].map((e) => [e.dataset.progressSection, [Number(e.dataset.done), Number(e.dataset.total)]])),
}));

const before = await read();
check("compte neuf : série à 0", before.streak === 0, String(before.streak));
check("sept jours affichés, le dernier est aujourd'hui", before.week.length === 7 && before.week[6][0] === today, before.week.map((w) => w[0]).join());
check("compte neuf : aucun jour actif", before.week.every((w) => w[1] === "0"));
check("compte neuf : 0 exercice, 0 révision, pas de lecture", before.exercises === "0" && before.reviews === "0" && before.reading === "pas encore");
check("prochaine étape proposée", Boolean(before.next), before.next);
check("rubriques affichées, rien de fait", Object.keys(before.sections).length > 0 && Object.values(before.sections).every(([d]) => d === 0), JSON.stringify(before.sections));

// Le navigateur ne peut pas écrire lui-même son activité.
const forged = await db.from("user_activity_days").insert({ user_id: userId, day: today, exercises: 50 });
check("écriture directe de l'activité refusée", Boolean(forged.error), forged.error?.message ?? "acceptée !");

// Activité réelle : exercices de la prochaine leçon, révision d'un verset, lecture du Coran.
const item = (await db.from("content_items").select("id,section,published_revision_id").eq("slug", before.next).single()).data;
const { count } = await db.from("content_questions").select("id", { count: "exact", head: true }).eq("revision_id", item.published_revision_id);
const attempt = await db.from("quiz_attempts").insert({ item_id: item.id, revision_id: item.published_revision_id, score: count, total: count });
check("exercices enregistrés", !attempt.error, attempt.error?.message);
const rate = await db.rpc("hifdh_rate", { p_ayah: 1, p_known: true });
check("verset révisé", !rate.error, rate.error?.message);
const reading = await db.from("quran_reading_history").upsert({ user_id: userId, surah: 1, ayah_id: 1, updated_at: new Date().toISOString() }, { onConflict: "user_id,surah" });
check("lecture enregistrée", !reading.error, reading.error?.message);

const row = (await db.from("user_activity_days").select("exercises,reviews,readings").eq("day", today).single()).data;
check("compteurs du jour tenus par la base : 1 exercice, 1 révision, 1 lecture", row?.exercises === 1 && row?.reviews === 1 && row?.readings === 1, JSON.stringify(row));

await page.reload({ waitUntil: "networkidle" });
const after = await read();
check("série à 1 jour", after.streak === 1, String(after.streak));
check("aujourd'hui marqué actif", after.week[6][1] === "1");
check("journée : 1 exercice, 1 révision, lecture faite", after.exercises === "1" && after.reviews === "1" && after.reading === "oui", JSON.stringify([after.exercises, after.reviews, after.reading]));
check("prochaine étape passée à la leçon suivante", after.next && after.next !== before.next, `${before.next} -> ${after.next}`);
check("progression de la rubrique : 1 leçon faite", after.sections[item.section]?.[0] === 1 && after.sections[item.section][1] === before.sections[item.section][1], JSON.stringify(after.sections[item.section]));
check("mémorisation : 1 verset", after.memorised === 1, String(after.memorised));
check("lien vers la leçon proposée", await page.locator(`a[data-next="${after.next}"]`).getAttribute("href") === `/apprendre/${after.next}`);

for (const width of [320, 1280]) {
  await page.setViewportSize({ width, height: 800 });
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  check(`pas de débordement à ${width} px`, overflow <= 0, String(overflow));
}

// Arabe : la page s'affiche de droite a gauche avec le tableau de bord.
await page.context().addCookies([{ name: "nour_locale", value: "ar", url: base }]);
await page.reload({ waitUntil: "networkidle" });
check("version arabe : tableau de bord affiché", (await page.locator("[data-dashboard] h2").textContent()).includes("لوحة"));

check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 2).join(" | "));
await browser.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
