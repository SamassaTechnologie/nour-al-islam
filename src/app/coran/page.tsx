import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { ArabicVerse, place } from "@/components/quran-view";
import { getHizbStarts, getJuzStarts, getReadingSummary, getSurahs, searchQuran, verseBody } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Coran" };

const tab = "flex min-h-11 flex-1 items-center justify-center rounded-md text-base";

export default async function QuranPage({ searchParams }: { searchParams: Promise<{ q?: string; vue?: string }> }) {
  const [{ t }, params, surahs, reading] = await Promise.all([getPreferences(), searchParams, getSurahs(), getReadingSummary()]);
  const q = t.quran;
  const query = (params.q ?? "").trim().slice(0, 80);
  const reference = query.match(/^(\d{1,3})(?:\s*[:. ]\s*(\d{1,3}))?$/);
  if (reference) {
    const surah = surahs[Number(reference[1]) - 1];
    const number = Number(reference[2] ?? 1);
    if (surah && number >= 1 && number <= surah.ayah_count) redirect(`/coran/${surah.number}#v${surah.number}-${number}`);
  }
  const results = query.length >= 2 && !reference ? await searchQuran(query) : null;
  const last = reading?.recent[0];
  const juzView = params.vue === "juz";
  const hizbView = params.vue === "hizb";
  const juz = juzView ? await getJuzStarts() : [];
  const quarters = hizbView ? await getHizbStarts() : [];
  const surahView = !juzView && !hizbView;

  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{q.title}</h1>
      {last ? (
        <Link href={`/coran/${last.surah}#v${last.surah}-${last.ayahs.number}`} className="mt-4 flex min-h-12 items-center justify-between rounded-lg bg-emerald px-4 font-medium text-on-emerald">
          <span>{q.resume}</span>
          <span>{surahs[last.surah - 1].name_translit}, {last.ayahs.number}</span>
        </Link>
      ) : null}

      <Link href="/coran/mushaf" className="mt-3 flex min-h-12 items-center justify-center rounded-lg border border-line px-4 font-medium text-emerald">{q.mushaf}</Link>

      <form role="search" action="/coran" className="mt-4 flex gap-2">
        <input name="q" type="search" defaultValue={query} aria-label={q.searchLabel} placeholder={q.searchPlaceholder} className="min-h-12 min-w-0 flex-1 rounded-lg border border-line bg-page px-3 outline-none focus:border-emerald" />
        <button className="min-h-12 rounded-lg border border-line px-4 font-medium">{q.searchAction}</button>
      </form>

      {results ? (
        <section className="mt-6">
          <h2 className="text-xl">{results.length ? q.resultsTitle : q.noResults}</h2>
          <ul className="mt-2">
            {results.map((r) => (
              <li key={r.ayah_id} className="border-b border-line py-4">
                <Link href={`/coran/${r.surah}#v${r.surah}-${r.number}`} className="inline-flex min-h-11 items-center font-medium text-emerald">
                  {surahs[r.surah - 1].name_translit} {r.surah}:{r.number}
                </Link>
                <ArabicVerse text={verseBody(r.text_uthmani, r.bismillah_length)} />
                {r.translation ? <p lang="fr" dir="ltr" className="mt-2 text-muted">{r.translation}</p> : null}
              </li>
            ))}
          </ul>
        </section>
      ) : (
        <>
          <nav aria-label={q.browse} className="mt-5 flex gap-1 rounded-lg bg-tint p-1">
            <Link href="/coran" aria-current={surahView ? "page" : undefined} className={`${tab} ${surahView ? "bg-emerald font-medium text-on-emerald" : ""}`}>{q.surahs}</Link>
            <Link href="/coran?vue=juz" aria-current={juzView ? "page" : undefined} className={`${tab} ${juzView ? "bg-emerald font-medium text-on-emerald" : ""}`}>{q.juzList}</Link>
            <Link href="/coran?vue=hizb" aria-current={hizbView ? "page" : undefined} className={`${tab} ${hizbView ? "bg-emerald font-medium text-on-emerald" : ""}`}>{q.hizbList}</Link>
          </nav>
          {juzView ? (
            <ol className="mt-2">
              {juz.map((j) => (
                <li key={j.juz} className="border-b border-line">
                  <Link href={`/coran/juz/${j.juz}`} className="flex min-h-14 items-center gap-4 py-2">
                    <span className="w-8 text-center font-medium text-emerald">{j.juz}</span>
                    <span className="min-w-0 flex-1">
                      <span className="block">{q.juz} {j.juz}</span>
                      <span className="block text-base text-muted">{surahs[j.surah - 1].name_translit} {j.surah}:{j.number}, {j.ayah_count} {q.verses}</span>
                    </span>
                  </Link>
                </li>
              ))}
            </ol>
          ) : hizbView ? (
            <ol className="mt-2">
              {Array.from({ length: 60 }, (_, i) => i + 1).map((h) => {
                const parts = quarters.filter((r) => r.hizb === h);
                const first = parts[0];
                return (
                  <li key={h} className="border-b border-line py-2">
                    <Link href={`/coran/hizb/${h}`} className="flex min-h-11 items-center gap-4">
                      <span className="w-8 text-center font-medium text-emerald">{h}</span>
                      <span className="min-w-0 flex-1">{q.hizb} {h}<span className="block text-base text-muted">{surahs[first.surah - 1].name_translit} {first.surah}:{first.number}</span></span>
                    </Link>
                    <div className="mt-1 grid grid-cols-4 gap-1 ps-12">
                      {parts.map((r) => (
                        <Link key={r.rub} href={`/coran/hizb/${h}#rub-${r.rub}`} aria-label={`${q.hizb} ${h}, ${q.rub} ${r.rub}/4, ${r.surah}:${r.number}`} className="flex min-h-11 items-center justify-center rounded-md bg-tint text-base">{r.rub}/4</Link>
                      ))}
                    </div>
                  </li>
                );
              })}
            </ol>
          ) : (
            <ol className="mt-2">
              {surahs.map((s) => (
                <li key={s.number} className="border-b border-line">
                  <Link href={`/coran/${s.number}`} className="flex min-h-14 items-center gap-4 py-2">
                    <span className="w-8 text-center font-medium text-emerald">{s.number}</span>
                    <span className="min-w-0 flex-1">
                      <span className="block">{s.name_translit}</span>
                      <span className="block text-base text-muted">{place(q, s)}, {s.ayah_count} {q.verses}</span>
                    </span>
                    <span lang="ar" dir="rtl" className="surah-name">{s.name_ar}</span>
                  </Link>
                </li>
              ))}
            </ol>
          )}
        </>
      )}
      {reading ? <Link href="/coran/signets" className="mt-5 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{q.bookmarks} ({reading.bookmarkCount})</Link> : null}
    </main>
  );
}
