import type { Metadata } from "next";
import Link from "next/link";
import { ArabicVerse } from "@/components/quran-view";
import { ADHKAR_SECTION } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { getSurahs, searchQuran, verseBody } from "@/lib/quran";
import { searchContent, snippet, type Snippet } from "@/lib/search";

export const metadata: Metadata = { title: "Rechercher" };

const QURAN_SHOWN = 10;

function Excerpt({ s }: { s: Snippet }) {
  if (!s) return null;
  return <p className="mt-1 text-base text-muted" data-snippet>{s.before}<mark className="rounded bg-gold/30 px-0.5 text-ink">{s.match}</mark>{s.after}</p>;
}

export default async function SearchPage({ searchParams }: { searchParams: Promise<{ q?: string }> }) {
  const [{ t }, params, surahs] = await Promise.all([getPreferences(), searchParams, getSurahs()]);
  const r = t.search;
  const sections = t.content.sections as Record<string, string>;
  const query = (params.q ?? "").trim().slice(0, 80);
  const run = query.length >= 2;
  const [content, verses] = run ? await Promise.all([searchContent(query), searchQuran(query)]) : [[], []];
  const lessons = content.filter((h) => h.section !== ADHKAR_SECTION);
  const adhkar = content.filter((h) => h.section === ADHKAR_SECTION);
  const total = content.length + verses.length;

  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{r.title}</h1>
      <p className="mt-2 text-muted">{r.intro}</p>
      <form role="search" action="/recherche" className="mt-4 flex gap-2">
        <input name="q" type="search" defaultValue={query} aria-label={r.label} placeholder={r.placeholder} minLength={2} maxLength={80} className="min-h-12 min-w-0 flex-1 rounded-lg border border-line bg-page px-3 outline-none focus:border-emerald" />
        <button className="min-h-12 rounded-lg bg-emerald px-4 font-medium text-on-emerald">{r.action}</button>
      </form>
      {query && !run ? <p className="mt-4" role="status">{r.short}</p> : null}
      {run ? (
        <p className="mt-5 font-medium" role="status" data-search-total={total}>
          {total ? r.total.replace("{n}", String(total)).replace("{q}", query) : r.none.replace("{q}", query)}
        </p>
      ) : null}
      {run && !total ? <p className="mt-1 text-muted">{r.noneHint}</p> : null}

      {lessons.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{r.lessons}</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line" data-results="lessons">
            {lessons.map((h) => (
              <li key={h.slug} data-result={h.slug}>
                <Link href={`/apprendre/${h.slug}`} className="block py-3">
                  <span className="block text-base text-muted">{sections[h.section] ?? h.section}</span>
                  <span className="block font-medium text-emerald">{h.title}</span>
                  <Excerpt s={snippet(h.title, query) ? null : snippet(h.body, query) ?? snippet(h.summary, query)} />
                </Link>
              </li>
            ))}
          </ul>
        </section>
      ) : null}

      {adhkar.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{r.adhkar}</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line" data-results="adhkar">
            {adhkar.map((h) => (
              <li key={h.slug} data-result={h.slug}>
                <Link href={`/priere/invocations/${h.slug}`} className="block py-3">
                  <span className="block font-medium text-emerald">{h.title}</span>
                  {h.dhikr ? <span className="mt-1 block text-base text-muted" data-dhikr-hit>{r.inDhikr.replace("{title}", h.dhikr)}</span> : <Excerpt s={snippet(h.body, query) ?? snippet(h.summary, query)} />}
                </Link>
              </li>
            ))}
          </ul>
        </section>
      ) : null}

      {verses.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{r.quran}</h2>
          <ul className="mt-2" data-results="quran">
            {verses.slice(0, QURAN_SHOWN).map((v) => (
              <li key={v.ayah_id} className="border-b border-line py-4" data-result={`${v.surah}:${v.number}`}>
                <Link href={`/coran/${v.surah}#v${v.surah}-${v.number}`} className="inline-flex min-h-11 items-center font-medium text-emerald">
                  {surahs[v.surah - 1].name_translit} {v.surah}:{v.number}
                </Link>
                <ArabicVerse text={verseBody(v.text_uthmani, v.bismillah_length)} />
                {v.translation ? <p lang="fr" dir="ltr" className="mt-2 text-muted">{v.translation}</p> : null}
              </li>
            ))}
          </ul>
          {verses.length > QURAN_SHOWN ? (
            <Link href={`/coran?q=${encodeURIComponent(query)}`} className="mt-3 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4" data-quran-more>{r.quranMore}</Link>
          ) : null}
        </section>
      ) : null}
    </main>
  );
}
