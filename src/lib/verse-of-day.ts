import { cache } from "react";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { supabaseEnv } from "@/lib/supabase/server";
import { TRANSLATION_ID, verseBody } from "@/lib/quran";
import { TAFSIRS } from "@/lib/tafsir";

// Verset du jour : un verset court et complet, choisi chaque jour dans cette liste de references
// (selection de l'equipe). Le texte arabe, la traduction et le Tafsir sont lus dans les textes verrouilles.
export const VERSES_OF_DAY: [number, number][] = [
  [2, 45], [2, 152], [2, 153], [2, 186], [2, 201], [2, 216], [2, 255], [2, 286], [3, 8], [3, 31],
  [3, 92], [3, 103], [3, 134], [3, 139], [3, 159], [3, 185], [3, 190], [3, 191], [3, 200], [6, 162],
  [6, 163], [7, 23], [7, 205], [8, 2], [9, 51], [9, 129], [10, 62], [11, 114], [12, 87], [13, 11],
  [13, 28], [14, 7], [15, 9], [16, 90], [16, 97], [16, 128], [17, 23], [17, 24], [17, 80], [18, 10],
  [18, 46], [20, 14], [20, 114], [21, 87], [23, 115], [25, 63], [28, 77], [29, 45], [29, 69], [31, 17],
  [33, 21], [33, 41], [33, 56], [35, 15], [39, 10], [39, 53], [40, 60], [41, 34], [42, 11], [47, 7],
  [49, 10], [49, 13], [50, 16], [51, 56], [55, 13], [57, 4], [59, 18], [59, 22], [64, 11], [65, 2],
  [65, 3], [67, 2], [87, 14], [93, 5], [94, 5], [94, 6], [112, 1],
];

/** Numero du jour (UTC) : le meme verset pour tout le monde le meme jour. */
export function verseIndexFor(date = new Date()) {
  const day = Math.floor(Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate()) / 86400_000);
  return ((day % VERSES_OF_DAY.length) + VERSES_OF_DAY.length) % VERSES_OF_DAY.length;
}

function content() {
  const { url, key } = supabaseEnv();
  return createSupabaseClient(url, key, {
    auth: { persistSession: false },
    global: { fetch: (input, init) => fetch(input, { ...init, next: { revalidate: 3600 } }) },
  });
}

export type VerseOfDay = { surah: number; number: number; arabic: string; translation: string | null; tafsir: string | null };

export const getVerseOfDay = cache(async (date = new Date()): Promise<VerseOfDay | null> => {
  const [surah, number] = VERSES_OF_DAY[verseIndexFor(date)];
  const db = content();
  const [{ data: verse }, { data: tafsir }] = await Promise.all([
    db.from("ayahs").select("text_uthmani,bismillah_length,translation_verses(text)").eq("surah", surah).eq("number", number).eq("translation_verses.source_id", TRANSLATION_ID).maybeSingle(),
    db.from("tafsir_entries").select("text").eq("source_id", TAFSIRS.fr).eq("surah", surah).lte("from_ayah", number).gte("to_ayah", number).limit(1).maybeSingle(),
  ]);
  if (!verse) return null;
  const v = verse as unknown as { text_uthmani: string; bismillah_length: number; translation_verses: { text: string }[] };
  return {
    surah,
    number,
    arabic: verseBody(v.text_uthmani, v.bismillah_length),
    translation: v.translation_verses[0]?.text ?? null,
    tafsir: (tafsir as { text: string } | null)?.text ?? null,
  };
});
