import { unstable_cache } from "next/cache";
import { quranApi } from "@/lib/quran-audio";

export const MUSHAF_PAGES = 604;

export type MushafWord = { verse: string; code: string; text: string; end: boolean };
export type MushafLine =
  | { number: number; kind: "words"; words: MushafWord[] }
  | { number: number; kind: "surah"; surah: number }
  | { number: number; kind: "bismillah" }
  | { number: number; kind: "empty" };
export type MushafPage = { page: number; first: string; last: string; lines: MushafLine[]; bismillah: MushafWord[] };

type ApiWord = { position: number; char_type_name: string; line_number: number; code_v1: string; text_uthmani?: string; text_qpc_hafs?: string };
type ApiVerse = { verse_key: string; words: ApiWord[] };
type ApiPage = { verses: ApiVerse[]; pagination?: { next_page: number | null } };

const glyphs = (code: string) =>
  code.replace(/&#x([0-9a-f]+);/gi, (_, hex: string) => String.fromCodePoint(parseInt(hex, 16))).replace(/&#(\d+);/g, (_, n: string) => String.fromCodePoint(Number(n))).replace(/[<>&]/g, "");

async function fetchVerses(page: number) {
  const verses: ApiVerse[] = [];
  let next: number | null = 1;
  while (next) {
    const data: ApiPage = await quranApi<ApiPage>(`/verses/by_page/${page}?mushaf=2&words=true&word_fields=code_v1,text_uthmani,text_qpc_hafs,line_number,page_number&per_page=50&page=${next}`);
    verses.push(...data.verses);
    next = data.pagination?.next_page ?? null;
  }
  return verses;
}

const toWord = (verse: string, word: ApiWord): MushafWord => ({
  verse,
  code: glyphs(word.code_v1),
  text: word.text_uthmani ?? word.text_qpc_hafs ?? "",
  end: word.char_type_name === "end",
});

export const getMushafPage = unstable_cache(
  async (page: number): Promise<MushafPage> => {
    const verses = await fetchVerses(page);
    const count = page <= 2 ? 8 : 15;
    const words = new Map<number, MushafWord[]>();
    const slots = new Map<number, MushafLine>();
    for (const verse of verses) {
      const [surah, number] = verse.verse_key.split(":").map(Number);
      verse.words.forEach((word, index) => {
        words.set(word.line_number, [...(words.get(word.line_number) ?? []), toWord(verse.verse_key, word)]);
        if (number !== 1 || index !== 0) return;
        let line = word.line_number - 1;
        if (surah !== 1 && surah !== 9) slots.set(line, { number: line--, kind: "bismillah" });
        if (line >= 1) slots.set(line, { number: line, kind: "surah", surah });
      });
    }
    // Dans cette edition, le titre de certaines sourates occupe la derniere ligne de la page precedente.
    const lastSurah = Number(verses[verses.length - 1].verse_key.split(":")[0]);
    if (!words.has(count) && !slots.has(count) && lastSurah < 114) slots.set(count, { number: count, kind: "surah", surah: lastSurah + 1 });
    const opening = page === 1 ? [] : (await fetchVerses(1))[0].words.filter((word) => word.char_type_name !== "end").map((word) => toWord("1:1", word));
    return {
      page,
      first: verses[0].verse_key,
      last: verses[verses.length - 1].verse_key,
      bismillah: opening,
      lines: Array.from({ length: count }, (_, index): MushafLine => {
        const number = index + 1;
        const line = words.get(number);
        return line ? { number, kind: "words", words: line } : slots.get(number) ?? { number, kind: "empty" };
      }),
    };
  },
  ["qf-mushaf-v1-page-2"],
  { revalidate: 86400 },
);
