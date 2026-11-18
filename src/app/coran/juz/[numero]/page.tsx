import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { SourceNote, VerseList } from "@/components/quran-view";
import { getJuzVerses, getSurahs } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

type Props = { params: Promise<{ numero: string }> };

async function juzNumber(params: Props["params"]) {
  const { numero } = await params;
  const value = Number(numero);
  if (!/^\d{1,2}$/.test(numero) || value < 1 || value > 30) notFound();
  return value;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return { title: `Juz ${await juzNumber(params)}` };
}

export default async function JuzPage({ params }: Props) {
  const juz = await juzNumber(params);
  const [{ t }, verses, surahs] = await Promise.all([getPreferences(), getJuzVerses(juz), getSurahs()]);
  const q = t.quran;
  return (
    <main className="mx-auto max-w-xl px-5 pt-5">
      <Link href="/coran?vue=juz" className="reader-chrome inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{q.juzList}</Link>
      <h1 className="py-3 text-center text-2xl">{q.juz} {juz}</h1>
      <VerseList verses={verses} surahs={surahs} t={q} showHeadings />
      <nav aria-label={q.browse} className="reader-chrome mt-6 flex justify-between">
        {juz > 1 ? <Link href={`/coran/juz/${juz - 1}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.previous} : {q.juz} {juz - 1}</Link> : <span />}
        {juz < 30 ? <Link href={`/coran/juz/${juz + 1}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.next} : {q.juz} {juz + 1}</Link> : null}
      </nav>
      <SourceNote t={q} />
    </main>
  );
}
