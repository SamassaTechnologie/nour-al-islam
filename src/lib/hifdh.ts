import type { HifdhVerse } from "@/components/hifdh-trainer";
import { getSurahs, getSurahVerses, verseBody, type Surah, type Verse } from "@/lib/quran";

export const toHifdhVerse = (verse: Verse, surah: Surah): HifdhVerse => ({
  id: verse.id, surah: verse.surah, number: verse.number, text: verseBody(verse.text_uthmani, verse.bismillah_length).trim(),
  translation: verse.translation?.text ?? null, surahName: surah.name_translit,
});

export async function versesByIds(rows: { ayah_id: number; surah: number }[]) {
  const surahs = await getSurahs();
  const lists = new Map(await Promise.all([...new Set(rows.map((row) => row.surah))].map(async (surah) => [surah, await getSurahVerses(surah)] as const)));
  return rows.flatMap((row) => {
    const verse = lists.get(row.surah)?.find((item) => item.id === row.ayah_id);
    return verse ? [toHifdhVerse(verse, surahs[row.surah - 1])] : [];
  });
}
