import type { Metadata } from "next";
import Link from "next/link";
import { KhatmPlan } from "@/components/khatm-plan";
import { getPreferences } from "@/lib/preferences";
import { getPageStarts, getSurahs } from "@/lib/quran";

export const metadata: Metadata = { title: "Plan de lecture du Coran" };

export default async function Page() {
  const [{ t, locale }, starts, surahs] = await Promise.all([getPreferences(), getPageStarts(), getSurahs()]);
  const refs = {
    starts: starts.map(({ surah, number, juz }) => ({ surah, number, juz })),
    names: surahs.map((s) => (locale === "ar" ? s.name_ar : s.name_translit)),
    counts: surahs.map((s) => s.ayah_count),
  };
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/coran" className="inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{t.quran.allSurahs}</Link>
      <h1 className="mt-1 text-3xl">{t.khatm.title}</h1>
      <p className="mt-2 text-muted">{t.khatm.intro}</p>
      <KhatmPlan t={t.khatm} refs={refs} lang={locale === "ar" ? "ar" : "fr"} />
    </main>
  );
}
