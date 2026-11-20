import { createClient } from "@/lib/supabase/server";

export type ContentHit = { slug: string; section: string; kind: string; title: string; summary: string; body: string; dhikr: string | null; rank: number };

/** Lecons et invocations visibles par la personne (RLS : un visiteur ne voit que le contenu valide). */
export async function searchContent(query: string): Promise<ContentHit[]> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("search_content", { query, max_results: 30 });
  if (error) throw new Error(error.message);
  return (data ?? []) as ContentHit[];
}

const ARABIC = /[؀-ۿ]/;
const ARABIC_MARKS = /[ً-ٰٟۖ-ۭـ]/;
const LATIN_DROP = /[ʿʾ’'`‘]/;

/** Normalise caractere par caractere en gardant la position d'origine de chaque caractere garde. */
function normalise(text: string, arabic: boolean) {
  let out = "";
  const pos: number[] = [];
  for (let i = 0; i < text.length; i++) {
    const ch = text[i];
    if (arabic) {
      if (ARABIC_MARKS.test(ch)) continue;
      const mapped = "أإآٱ".includes(ch) ? "ا" : ch === "ة" ? "ه" : ch;
      out += mapped;
      pos.push(i);
    } else {
      if (LATIN_DROP.test(ch)) continue;
      const base = ch.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase();
      for (const b of base) { out += b; pos.push(i); }
    }
  }
  return { out, pos };
}

export type Snippet = { before: string; match: string; after: string } | null;

/** Extrait autour de la premiere occurrence de la recherche (sans tenir compte des accents ni des voyelles arabes). */
export function snippet(text: string, query: string, radius = 70): Snippet {
  const arabic = ARABIC.test(query);
  const q = normalise(query.trim(), arabic).out;
  if (!q) return null;
  const { out, pos } = normalise(text, arabic);
  const at = out.indexOf(q);
  if (at < 0) return null;
  const start = pos[at];
  let end = pos[at + q.length - 1] + 1;
  while (end < text.length && (arabic ? ARABIC_MARKS : /[\u0300-\u036f]/).test(text[end])) end++; // voyelles et signes du dernier mot
  const from = Math.max(0, text.lastIndexOf(" ", Math.max(0, start - radius)) + 1);
  let to = text.indexOf(" ", Math.min(text.length, end + radius));
  if (to < 0) to = text.length;
  const clean = (s: string) => s.replace(/\s+/g, " ");
  return { before: (from > 0 ? "… " : "") + clean(text.slice(from, start)), match: text.slice(start, end), after: clean(text.slice(end, to)) + (to < text.length ? " …" : "") };
}
