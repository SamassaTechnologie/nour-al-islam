import type { Metadata } from "next";
import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { HifdhTrainer } from "@/components/hifdh-trainer";
import { toHifdhVerse } from "@/lib/hifdh";
import { getPreferences } from "@/lib/preferences";
import { getSurahs, getSurahVerses } from "@/lib/quran";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Mémorisation" };

export default async function HifdhSurah({ params }: { params: Promise<{ sourate: string }> }) {
  const { sourate } = await params;
  const surah = /^\d{1,3}$/.test(sourate) ? (await getSurahs())[Number(sourate) - 1] : undefined;
  if (!surah) notFound();
  const session = await getSession();
  if (!session) redirect(`/connexion?suivant=/apprendre/memorisation/${surah.number}`);
  const supabase = await createClient();
  const [{ t }, verses, { data }] = await Promise.all([getPreferences(), getSurahVerses(surah.number), supabase.from("hifdh_progress").select("ayah_id").eq("surah", surah.number)]);
  const worked = new Set((data ?? []).map((row) => row.ayah_id));
  const first = verses.findIndex((verse) => !worked.has(verse.id));
  return (
    <main className="mx-auto max-w-xl px-5 pt-5">
      <Link href="/apprendre/memorisation" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.hifdh.back}</Link>
      <h1 className="text-3xl">{surah.name_translit}</h1>
      <HifdhTrainer verses={verses.map((verse) => toHifdhVerse(verse, surah))} start={first < 0 ? 0 : first} backHref="/apprendre/memorisation" t={t.hifdh} />
    </main>
  );
}
