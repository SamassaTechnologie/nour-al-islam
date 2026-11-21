import { unstable_cache } from "next/cache";
import { quranApi } from "@/lib/quran-audio";

// Mot a mot en francais de Quran Foundation (auteur non indique par l'API) : garde au plus un jour sur le serveur,
// jamais modifie. Reserve a l'equipe en attendant la relecture des savants.
export type WordGloss = { ar: string; fr: string };
export type VerseWords = { number: number; words: WordGloss[] };

type RawVerse = { verse_number: number; words: { char_type_name: string; text_uthmani?: string; translation?: { text?: string | null } | null }[] };

export const getSurahWords = unstable_cache(
  async (surah: number): Promise<VerseWords[]> => {
    const out: VerseWords[] = [];
    for (let page = 1; page <= 10; page++) {
      const data = await quranApi<{ verses: RawVerse[]; pagination: { next_page: number | null } }>(
        `/verses/by_chapter/${surah}?words=true&word_fields=text_uthmani&language=fr&per_page=50&page=${page}`,
      );
      for (const v of data.verses) {
        out.push({
          number: v.verse_number,
          words: v.words.filter((w) => w.char_type_name === "word").map((w) => ({ ar: w.text_uthmani ?? "", fr: w.translation?.text ?? "" })),
        });
      }
      if (!data.pagination?.next_page) break;
    }
    return out;
  },
  ["qf-words-fr-v1"],
  { revalidate: 86400 },
);
