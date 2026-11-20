// Tafsir (/coran/[sourate]/tafsir) : texte affiché identique à la base (importée de QuranEnc), verset arabe
// lu dans le texte verrouillé, ancres de chaque verset, liens depuis le lecteur, sources, écriture refusée, 320 px.
import { createClient } from "@supabase/supabase-js";
import { chromium } from "playwright";

const { BASE_URL: base, SUPABASE_URL: url, SUPABASE_KEY: key } = process.env;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const db = createClient(url, key, { auth: { persistSession: false } });
const FR = "quranenc-french_mokhtasar-1.0.0";
const SAADI = "quranenc-arabic_saadi-1.0.0";

const entries = async (source, surah) => {
  const { data, error } = await db.from("tafsir_entries").select("entry_id,from_ayah,to_ayah,entry_type,text").eq("source_id", source).eq("surah", surah).order("entry_id");
  if (error) throw error;
  return data;
};
const ayahs = async (surah) => (await db.from("ayahs").select("number,text_uthmani,bismillah_length").eq("surah", surah).order("id")).data;

// Base : verrouillage et totaux
const { data: sources } = await db.from("quran_sources").select("id,version,item_count,locked_at").eq("kind", "tafsir");
check("deux tafsirs verrouillés et visibles", sources?.length === 2 && sources.every((s) => s.locked_at), JSON.stringify(sources?.map((s) => s.id)));
check("al-Mukhtaṣar : 6 236 versets", sources?.find((s) => s.id === FR)?.item_count === 6236);
const { error: insertError } = await db.from("tafsir_entries").insert({ source_id: FR, entry_id: 999999, surah: 1, from_ayah: 1, to_ayah: 1, text: "x" });
check("écriture refusée à un visiteur", Boolean(insertError), insertError?.message);

const browser = await chromium.launch(process.env.PW_CHANNEL ? { channel: process.env.PW_CHANNEL } : {});
const errors = [];
const page = await (await browser.newContext({ locale: "fr-FR", viewport: { width: 390, height: 844 } })).newPage();
page.on("pageerror", (e) => errors.push(e.message));

for (const surah of [1, 112, 2]) {
  const [fr, verses] = await Promise.all([entries(FR, surah), ayahs(surah)]);
  await page.goto(`${base}/coran/${surah}/tafsir`, { waitUntil: "networkidle" });
  const shown = await page.$$eval("[data-tafsir-verse]", (lis) => lis.map((li) => ({
    n: Number(li.dataset.tafsirVerse),
    arabic: [...li.querySelectorAll("p.quran-text")].map((p) => p.textContent).at(-1),
    text: li.querySelector("[data-tafsir-text] p")?.textContent ?? null,
  })));
  check(`sourate ${surah} (français) : un tafsir par verset`, shown.length === verses.length && shown.every((s) => s.text), `${shown.length}/${verses.length}`);
  const textDiff = shown.filter((s) => s.text !== fr.find((e) => e.from_ayah === s.n)?.text).map((s) => s.n);
  check(`sourate ${surah} (français) : texte identique à la base`, textDiff.length === 0, textDiff.slice(0, 5).join(","));
  const arabicDiff = shown.filter((s) => { const v = verses[s.n - 1]; return s.arabic !== v.text_uthmani.slice(v.bismillah_length); }).map((s) => s.n);
  check(`sourate ${surah} (français) : verset arabe lu dans le texte verrouillé`, arabicDiff.length === 0, arabicDiff.slice(0, 5).join(","));
  check(`sourate ${surah} : source citée avec sa version`, (await page.textContent("[data-tafsir-source]")).includes("version 1.0.0"));

  const saadi = await entries(SAADI, surah);
  await page.goto(`${base}/coran/${surah}/tafsir?source=saadi`, { waitUntil: "networkidle" });
  const blocks = await page.$$eval("[data-tafsir='saadi'] > div", (divs) => divs.map((d) => [...d.querySelectorAll("h2, p:not([lang='fr'])")].map((p) => p.textContent).join("")));
  const saadiDiff = saadi.map((e, i) => (blocks[i] === e.text ? null : e.entry_id)).filter(Boolean);
  check(`sourate ${surah} (as-Saʿdī) : ${saadi.length} entrées, textes identiques à la base, dans l'ordre`, blocks.length === saadi.length && saadiDiff.length === 0, `${blocks.length}, écarts ${saadiDiff.slice(0, 5).join(",")}`);
  const anchors = await page.$$eval("[data-tafsir='saadi'] [id^='t']", (els) => els.map((e) => Number(e.id.slice(1))));
  check(`sourate ${surah} (as-Saʿdī) : une ancre pour chaque verset`, new Set(anchors).size === verses.length && anchors.every((n) => n >= 1 && n <= verses.length), `${new Set(anchors).size}/${verses.length}`);
  check(`sourate ${surah} (as-Saʿdī) : écrit de droite à gauche`, (await page.getAttribute("[data-tafsir='saadi']", "dir")) === "rtl");
  check(`sourate ${surah} (as-Saʿdī) : onglet actif`, (await page.getAttribute("[data-tafsir-tab='saadi']", "aria-current")) === "page");
}

// Depuis le lecteur : lien « Tafsir » sur chaque verset, qui mène au bon verset
await page.goto(`${base}/coran/112`, { waitUntil: "networkidle" });
check("lecteur : un lien Tafsir par verset", (await page.locator("[data-tafsir-link]").count()) === 4);
check("lecteur : lien vers le tafsir de la sourate", (await page.getAttribute("[data-surah-tafsir]", "href")) === "/coran/112/tafsir");
await page.click("[data-tafsir-link='112:3']");
await page.waitForURL((u) => u.pathname === "/coran/112/tafsir" && u.hash === "#t3");
check("lien du verset 3 : arrive sur son tafsir", await page.locator("#t3").isVisible());

// Page des sources
await page.goto(`${base}/coran/sources`, { waitUntil: "networkidle" });
const sourcesText = await page.textContent("main");
check("page des sources : les deux tafsirs avec leur version", sourcesText.includes("Résumé de l'Exégèse") && sourcesText.includes("as-Saʿdī") && sourcesText.includes("QuranEnc"));

// Petit écran
await page.setViewportSize({ width: 320, height: 700 });
for (const path of ["/coran/2/tafsir", "/coran/2/tafsir?source=saadi"]) {
  await page.goto(`${base}${path}`, { waitUntil: "networkidle" });
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  check(`pas de débordement à 320 px : ${path}`, overflow <= 0, String(overflow));
}
check("aucune erreur JavaScript", errors.length === 0, errors.slice(0, 3).join(" | "));
await browser.close();
console.log(failed ? `ECHECS ${failed}` : "ECHECS 0");
process.exit(failed ? 1 : 0);
