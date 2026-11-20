import { cache } from "react";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { supabaseEnv } from "@/lib/supabase/server";
import type { Source } from "@/lib/quran";

/** Tafsirs importés de QuranEnc.com sans modification et verrouillés dans la base. */
export const TAFSIRS = {
  fr: "quranenc-french_mokhtasar-1.0.0",
  saadi: "quranenc-arabic_saadi-1.0.0",
} as const;
export type TafsirKey = keyof typeof TAFSIRS;

export type TafsirEntry = {
  entry_id: number;
  from_ayah: number;
  to_ayah: number;
  entry_type: string | null;
  text: string;
  footnotes: string | null;
};

function content() {
  const { url, key } = supabaseEnv();
  return createSupabaseClient(url, key, {
    auth: { persistSession: false },
    global: { fetch: (input, init) => fetch(input, { ...init, next: { revalidate: 86400 } }) },
  });
}

export const getSurahTafsir = cache(async (key: TafsirKey, surah: number): Promise<TafsirEntry[]> => {
  const { data, error } = await content()
    .from("tafsir_entries")
    .select("entry_id,from_ayah,to_ayah,entry_type,text,footnotes")
    .eq("source_id", TAFSIRS[key])
    .eq("surah", surah)
    .order("entry_id");
  if (error) throw new Error(error.message);
  return data as TafsirEntry[];
});

export const getTafsirSource = cache(async (key: TafsirKey): Promise<Source | null> => {
  const { data, error } = await content()
    .from("quran_sources")
    .select("id,kind,title,author,publisher,version,license,source_url,notice")
    .eq("id", TAFSIRS[key])
    .maybeSingle();
  if (error) throw new Error(error.message);
  return data as Source | null;
});

/** Pour chaque verset, la première entrée qui l'explique (as-Saʿdī regroupe parfois plusieurs versets). */
export function firstEntryByAyah(entries: TafsirEntry[], ayahCount: number) {
  const map = new Map<number, number>();
  for (const e of entries) {
    if (e.from_ayah < 1) continue;
    for (let n = e.from_ayah; n <= Math.min(e.to_ayah, ayahCount); n++) if (!map.has(n)) map.set(n, e.entry_id);
  }
  return map;
}
