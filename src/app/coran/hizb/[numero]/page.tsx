import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { SourceNote, VerseList } from "@/components/quran-view";
import { getHizbVerses, getSurahs } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

type Props = { params: Promise<{ numero: string }> };

async function hizbNumber(params: Props["params"]) {
  const { numero } = await params;
  const value = Number(numero);
  if (!/^\d{1,2}$/.test(numero) || value < 1 || value > 60) notFound();
  return value;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return { title: `Hizb ${await hizbNumber(params)}` };
}

export default async function HizbPage({ params }: Props) {
  const hizb = await hizbNumber(params);
  const [{ t }, verses, surahs] = await Promise.all([getPreferences(), getHizbVerses(hizb), getSurahs()]);
  const q = t.quran;
  return (
    <main className="mx-auto max-w-xl px-5 pt-5">
      <Link href="/coran?vue=hizb" className="reader-chrome inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{q.hizbList}</Link>
      <h1 className="py-3 text-center text-2xl">{q.hizb} {hizb}</h1>
      <VerseList verses={verses} surahs={surahs} t={q} showHeadings showRub />
      <nav aria-label={q.browse} className="reader-chrome mt-6 flex justify-between">
        {hizb > 1 ? <Link href={`/coran/hizb/${hizb - 1}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.previous} : {q.hizb} {hizb - 1}</Link> : <span />}
        {hizb < 60 ? <Link href={`/coran/hizb/${hizb + 1}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.next} : {q.hizb} {hizb + 1}</Link> : null}
      </nav>
      <SourceNote t={q} />
    </main>
  );
}
