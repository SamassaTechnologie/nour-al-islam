import { cache } from "react";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { createClient, getSession, supabaseEnv } from "@/lib/supabase/server";

export const TRANSLATION_ID = "quranenc-french_rashid-1.0.3";

export type Surah = {
  number: number;
  name_ar: string;
  name_translit: string;
  name_en: string;
  ayah_count: number;
  first_ayah_id: number;
  revelation_place: "Meccan" | "Medinan";
};

export type Verse = {
  id: number;
  surah: number;
  number: number;
  text_uthmani: string;
  bismillah_length: number;
  juz: number;
  hizb: number;
  rub: number;
  page: number;
  translation: { text: string; footnotes: string | null } | null;
};

export type Source = {
  id: string;
  kind: "text" | "translation" | "tafsir";
  title: string;
  author: string | null;
  publisher: string;
  version: string;
  license: string;
  source_url: string;
  notice: string | null;
};

type VerseRow = Omit<Verse, "translation"> & { translation_verses: { text: string; footnotes: string | null }[] };

/** Le contenu coranique est verrouille : il peut etre mis en cache sans risque. */
function content() {
  const { url, key } = supabaseEnv();
  return createSupabaseClient(url, key, {
    auth: { persistSession: false },
    global: { fetch: (input, init) => fetch(input, { ...init, next: { revalidate: 86400 } }) },
  });
}

const VERSE_COLUMNS = "id,surah,number,text_uthmani,bismillah_length,juz,hizb,rub,page,translation_verses(text,footnotes)";

const toVerse = ({ translation_verses, ...v }: VerseRow): Verse => ({ ...v, translation: translation_verses[0] ?? null });

export const getSurahs = cache(async (): Promise<Surah[]> => {
  const { data, error } = await content()
    .from("surahs")
    .select("number,name_ar,name_translit,name_en,ayah_count,first_ayah_id,revelation_place")
    .order("number");
  if (error) throw new Error(error.message);
  return data as Surah[];
});

export const getBismillah = cache(async (): Promise<string> => {
  const { data, error } = await content().from("ayahs").select("text_uthmani").eq("id", 1).single();
  if (error) throw new Error(error.message);
  return data.text_uthmani;
});

async function verses(column: "surah" | "juz" | "hizb", value: number) {
  const { data, error } = await content()
    .from("ayahs")
    .select(VERSE_COLUMNS)
    .eq(column, value)
    .eq("translation_verses.source_id", TRANSLATION_ID)
    .order("id");
  if (error) throw new Error(error.message);
  return (data as unknown as VerseRow[]).map(toVerse);
}

export const getSurahVerses = cache((surah: number) => verses("surah", surah));
export const getJuzVerses = cache((juz: number) => verses("juz", juz));
export const getHizbVerses = cache((hizb: number) => verses("hizb", hizb));

export const getVerseRange = cache(async (firstId: number, lastId: number) => {
  const { data, error } = await content().from("ayahs").select("id,surah,number,text_uthmani,bismillah_length").gte("id", firstId).lte("id", lastId).order("id");
  if (error) throw new Error(error.message);
  return data as Pick<Verse, "id" | "surah" | "number" | "text_uthmani" | "bismillah_length">[];
});

export const getJuzStarts = cache(async () => {
  const { data, error } = await content().rpc("juz_starts");
  if (error) throw new Error(error.message);
  return data as { juz: number; surah: number; number: number; ayah_count: number }[];
});

export const getHizbStarts = cache(async () => {
  const { data, error } = await content().rpc("hizb_starts");
  if (error) throw new Error(error.message);
  return data as { hizb: number; rub: number; surah: number; number: number; ayah_count: number }[];
});

export const getSources = cache(async (): Promise<Source[]> => {
  const { data, error } = await content()
    .from("quran_sources")
    .select("id,kind,title,author,publisher,version,license,source_url,notice")
    .eq("is_default", true)
    .order("kind");
  if (error) throw new Error(error.message);
  return data as Source[];
});

/** Toutes les sources verrouillées (texte, traduction, tafsirs), pour la page des sources. */
export const getAllSources = cache(async (): Promise<Source[]> => {
  const { data, error } = await content()
    .from("quran_sources")
    .select("id,kind,title,author,publisher,version,license,source_url,notice")
    .order("kind")
    .order("id");
  if (error) throw new Error(error.message);
  return data as Source[];
});

export async function searchQuran(query: string) {
  const { data, error } = await content().rpc("search_quran", { query, max_results: 30 });
  if (error) throw new Error(error.message);
  return data as { ayah_id: number; surah: number; number: number; text_uthmani: string; bismillah_length: number; translation: string | null }[];
}

export async function getBookmarkIds(from: number, to: number) {
  const session = await getSession();
  if (!session) return null;
  const supabase = await createClient();
  const { data } = await supabase.from("quran_bookmarks").select("ayah_id").gte("ayah_id", from).lte("ayah_id", to);
  return new Set((data ?? []).map((row) => row.ayah_id as number));
}

export async function getReadingSummary() {
  const session = await getSession();
  if (!session) return null;
  const supabase = await createClient();
  const [history, bookmarks] = await Promise.all([
    supabase.from("quran_reading_history").select("surah,ayah_id,updated_at,ayahs(number)").order("updated_at", { ascending: false }).limit(5),
    supabase.from("quran_bookmarks").select("ayah_id", { count: "exact", head: true }),
  ]);
  const rows = (history.data ?? []) as unknown as { surah: number; ayah_id: number; updated_at: string; ayahs: { number: number } }[];
  return { recent: rows, bookmarkCount: bookmarks.count ?? 0 };
}

export async function getBookmarks() {
  const session = await getSession();
  if (!session) return null;
  const supabase = await createClient();
  const { data } = await supabase
    .from("quran_bookmarks")
    .select("ayah_id,created_at,ayahs(surah,number,text_uthmani,bismillah_length)")
    .order("created_at", { ascending: false })
    .limit(200);
  return (data ?? []) as unknown as { ayah_id: number; ayahs: { surah: number; number: number; text_uthmani: string; bismillah_length: number } }[];
}

/** La basmala reste dans le texte importe : seul son affichage est separe du verset 1. */
export const verseBody = (text: string, bismillahLength: number) => text.slice(bismillahLength);
