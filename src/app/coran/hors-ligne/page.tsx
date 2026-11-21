import type { Metadata } from "next";
import Link from "next/link";
import { AudioDownloads } from "@/components/audio-downloads";
import { SaveQuran } from "@/components/save-quran";
import { getPreferences } from "@/lib/preferences";
import { getSurahs } from "@/lib/quran";

export const metadata: Metadata = { title: "Sans internet" };

// Ce que l'utilisateur garde sur son telephone : texte du Coran et recitations telechargees.
export default async function OfflinePage() {
  const [{ t }, surahs] = await Promise.all([getPreferences(), getSurahs()]);
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/coran" className="inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{t.quran.allSurahs}</Link>
      <h1 className="mt-1 text-3xl">{t.offline.hub}</h1>
      <p className="mt-2 mb-5 text-muted">{t.offline.hubIntro}</p>
      <SaveQuran t={t.offline} />
      <AudioDownloads t={t.quran} o={t.offline} names={surahs.map((s) => s.name_translit)} />
    </main>
  );
}
