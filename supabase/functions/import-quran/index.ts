// Import controle du Coran : le texte vient uniquement des fichiers d'origine, jamais d'une saisie.
// La version deployee est desactivee une fois les sources verrouillees.
// Pour un nouvel import : definir IMPORT_TOKEN_SHA256, deployer, puis appeler les etapes meta, text et translation.
import { createClient } from "npm:@supabase/supabase-js@2.119.1";

const TEXT_ID = "tanzil-uthmani-1.1";
const TRANSLATION_ID = "quranenc-french_rashid-1.0.3";
const TANZIL = "https://tanzil.net/pub/download/index.php";
const UTHMANI = `${TANZIL}?marks=true&sajdah=true&rub=true&tatweel=true&quranType=uthmani&outType=txt-2&agree=true`;
const CLEAN = `${TANZIL}?quranType=simple-clean&outType=txt-2&agree=true`;
const META = "https://tanzil.net/res/text/metadata/quran-data.js";
const BATCH = 500;

const hex = (b: ArrayBuffer) => [...new Uint8Array(b)].map((x) => x.toString(16).padStart(2, "0")).join("");
const sha256 = async (s: string) => hex(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(s)));
const json = (body: unknown, status = 200) => Response.json(body, { status });

async function get(url: string) {
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Telechargement refuse (${res.status}) : ${url}`);
  return await res.text();
}

function verses(file: string) {
  const out: { surah: number; number: number; text: string }[] = [];
  for (const line of file.split("\n")) {
    const m = line.match(/^(\d+)\|(\d+)\|(.*)$/);
    if (m) out.push({ surah: +m[1], number: +m[2], text: m[3].replace(/\r$/, "") });
  }
  if (out.length !== 6236) throw new Error(`Nombre de versets inattendu : ${out.length}`);
  return out;
}

function block(meta: string, name: string) {
  const start = meta.indexOf(`QuranData.${name} = [`);
  if (start < 0) throw new Error(`Bloc absent : ${name}`);
  return meta.slice(start, meta.indexOf("];", start));
}

function surahRows(meta: string) {
  const re = /\[(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*'([^']*)',\s*"([^"]*)",\s*'([^']*)',\s*'(Meccan|Medinan)'\]/g;
  const rows = [...block(meta, "Sura").matchAll(re)].map((m, i) => ({
    number: i + 1, first_ayah_id: +m[1] + 1, ayah_count: +m[2], revelation_order: +m[3],
    name_ar: m[5], name_translit: m[6], name_en: m[7], revelation_place: m[8],
  }));
  if (rows.length !== 114) throw new Error(`Nombre de sourates inattendu : ${rows.length}`);
  return rows;
}

function ids(meta: string, name: string, firstId: Map<number, number>, expected: number) {
  const list = [...block(meta, name).matchAll(/\[(\d+),\s*(\d+)\]/g)]
    .map((m) => [+m[1], +m[2]]).filter(([s]) => s <= 114)
    .map(([s, a]) => firstId.get(s)! + a - 1);
  if (list.length !== expected) throw new Error(`${name} : ${list.length} au lieu de ${expected}`);
  return list;
}

const indexAt = (starts: number[], id: number) => {
  let i = 0;
  while (i + 1 < starts.length && starts[i + 1] <= id) i++;
  return i;
};

function bismillahLength(surah: number, number: number, text: string, b: string) {
  if (number !== 1 || surah === 1 || surah === 9) return 0;
  if (text.startsWith(`${b} `)) return b.length + 1;
  const variant = `${b[0]}ّ${b.slice(1)} `;
  if (text.startsWith(variant)) return variant.length;
  throw new Error(`Basmala non reconnue en ${surah}:1`);
}

Deno.serve(async (req) => {
  try {
    if (req.method !== "POST") return json({ error: "POST requis" }, 405);
    const expected = Deno.env.get("IMPORT_TOKEN_SHA256");
    if (!expected || (await sha256(req.headers.get("x-import-token") ?? "")) !== expected) return json({ error: "Refuse" }, 401);
    const db = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
    const body = await req.json();

    if (body.step === "meta" || body.step === "text") {
      const [uFile, cFile, meta] = await Promise.all([get(UTHMANI), get(CLEAN), get(META)]);
      const u = verses(uFile), c = verses(cFile), rows = surahRows(meta);
      if (body.step === "meta") {
        if (rows.reduce((n, r) => n + r.ayah_count, 0) !== 6236) throw new Error("Total des sourates incorrect");
        const { error } = await db.from("surahs").upsert(rows, { onConflict: "number", ignoreDuplicates: true });
        if (error) throw error;
        const notice = uFile.split("\n").filter((l) => l.startsWith("#")).join("\n");
        const content = u.map((v) => `${v.surah}|${v.number}|${v.text}\n`).join("");
        const up = await db.from("quran_sources").update({ notice, file_sha256: await sha256(uFile), content_sha256: await sha256(content), item_count: u.length }).eq("id", TEXT_ID);
        if (up.error) throw up.error;
        return json({ surahs: rows.length, content_sha256: await sha256(content) });
      }
      const firstId = new Map(rows.map((r) => [r.number, r.first_ayah_id]));
      const juz = ids(meta, "Juz", firstId, 30), quarters = ids(meta, "HizbQaurter", firstId, 240), pages = ids(meta, "Page", firstId, 604);
      const b = u[0].text, start = Number(body.start ?? 0), cleanB = c[0].text;
      const batch = u.slice(start, start + BATCH).map((v, k) => {
        const id = start + k + 1, q = indexAt(quarters, id), cv = c[start + k];
        if (cv.surah !== v.surah || cv.number !== v.number) throw new Error(`Decalage en ${v.surah}:${v.number}`);
        const len = bismillahLength(v.surah, v.number, v.text, b);
        if (len && !cv.text.startsWith(`${cleanB} `)) throw new Error(`Basmala simple absente en ${v.surah}:1`);
        return { id, surah: v.surah, number: v.number, text_uthmani: v.text, bismillah_length: len,
          text_clean: len ? cv.text.slice(cleanB.length + 1) : cv.text,
          juz: indexAt(juz, id) + 1, hizb: Math.floor(q / 4) + 1, rub: (q % 4) + 1, page: indexAt(pages, id) + 1 };
      });
      const { error } = await db.from("ayahs").upsert(batch, { onConflict: "id", ignoreDuplicates: true });
      if (error) throw error;
      return json({ inserted: batch.length, next: start + BATCH < 6236 ? start + BATCH : null });
    }

    if (body.step === "translation") {
      const sura = Number(body.sura);
      const s = await db.from("surahs").select("ayah_count, first_ayah_id").eq("number", sura).single();
      if (s.error) throw s.error;
      const res = JSON.parse(await get(`https://quranenc.com/api/v1/translation/sura/french_rashid/${sura}`)).result as { sura: string; aya: string; translation: string; footnotes: string | null }[];
      if (res.length !== s.data.ayah_count) throw new Error(`Sourate ${sura} : ${res.length} versets`);
      const rows = res.map((r, i) => {
        if (+r.sura !== sura || +r.aya !== i + 1 || !r.translation) throw new Error(`Traduction invalide en ${sura}:${i + 1}`);
        return { source_id: TRANSLATION_ID, ayah_id: s.data.first_ayah_id + i, text: r.translation, footnotes: r.footnotes || null };
      });
      const { error } = await db.from("translation_verses").upsert(rows, { onConflict: "source_id,ayah_id", ignoreDuplicates: true });
      if (error) throw error;
      return json({ sura, inserted: rows.length });
    }
    return json({ error: "Etape inconnue" }, 400);
  } catch (e) {
    return json({ error: e instanceof Error ? e.message : JSON.stringify(e) }, 500);
  }
});
