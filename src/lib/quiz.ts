import type { Question } from "@/lib/admin";
import { getSurahs, getSurahVerses, verseBody } from "@/lib/quran";

export type QuizQuestion = Omit<Question, "revision_id"> & {
  excerpt: { text: string; surah: number; ayah: number; name: string; nameAr: string } | null;
};

/** Ajoute aux questions les mots coraniques cites, lus dans le texte verrouille. */
export async function withExcerpts(questions: Question[]): Promise<QuizQuestion[]> {
  const surahs = await getSurahs();
  return Promise.all(questions.map(async ({ revision_id: _revision, ...q }) => {
    if (!q.surah || !q.ayah || !q.word_from || !q.word_to) return { ...q, excerpt: null };
    const verse = (await getSurahVerses(q.surah)).find((v) => v.number === q.ayah);
    const words = verse ? verseBody(verse.text_uthmani, verse.bismillah_length).trim().split(" ").slice(q.word_from - 1, q.word_to) : [];
    const surah = surahs[q.surah - 1];
    return { ...q, excerpt: words.length ? { text: words.join(" "), surah: q.surah, ayah: q.ayah, name: surah.name_translit, nameAr: surah.name_ar } : null };
  }));
}
