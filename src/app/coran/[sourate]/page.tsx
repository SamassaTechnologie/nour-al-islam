import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { SourceNote, VerseList, place } from "@/components/quran-view";
import { getSurahs, getSurahVerses } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

type Props = { params: Promise<{ sourate: string }> };

async function load(params: Props["params"]) {
  const { sourate } = await params;
  if (!/^\d{1,3}$/.test(sourate)) notFound();
  const surahs = await getSurahs();
  const surah = surahs[Number(sourate) - 1];
  if (!surah) notFound();
  return { surah, surahs };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { surah } = await load(params);
  return { title: `Sourate ${surah.name_translit}` };
}

export default async function SurahPage({ params }: Props) {
  const { surah, surahs } = await load(params);
  const [{ t }, verses] = await Promise.all([getPreferences(), getSurahVerses(surah.number)]);
  const q = t.quran;
  const previous = surahs[surah.number - 2];
  const next = surahs[surah.number];
  return (
    <main className="mx-auto max-w-xl px-5 pt-5">
      <Link href="/coran" className="reader-chrome inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{q.allSurahs}</Link>
      <header className="py-3 text-center">
        <p lang="ar" dir="rtl" className="wordmark text-4xl leading-normal text-emerald">{surah.name_ar}</p>
        <h1 lang="en" dir="ltr" className="text-2xl">{surah.number}. {surah.name_translit}</h1>
        <p className="text-base text-muted">{place(q, surah)}, {surah.ayah_count} {q.verses}</p>
      </header>
      <VerseList verses={verses} surahs={surahs} t={q} trackSurah={surah.number} />
      <nav aria-label={q.browse} className="reader-chrome mt-6 flex justify-between gap-3">
        {previous ? <Link href={`/coran/${previous.number}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.previous} : {previous.name_translit}</Link> : <span />}
        {next ? <Link href={`/coran/${next.number}`} className="inline-flex min-h-11 items-center text-end font-medium text-emerald">{q.next} : {next.name_translit}</Link> : null}
      </nav>
      <SourceNote t={q} />
    </main>
  );
}
