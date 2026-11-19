import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { HifdhTrainer } from "@/components/hifdh-trainer";
import { versesByIds } from "@/lib/hifdh";
import { getPreferences } from "@/lib/preferences";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Révision" };

export default async function HifdhReview() {
  if (!(await getSession())) redirect("/connexion?suivant=/apprendre/memorisation/revision");
  const supabase = await createClient();
  const today = new Date().toISOString().slice(0, 10);
  const [{ t }, { data, error }] = await Promise.all([getPreferences(), supabase.from("hifdh_progress").select("ayah_id,surah").lte("next_review", today).order("next_review").order("ayah_id").limit(30)]);
  if (error) throw new Error(error.message);
  return (
    <main className="mx-auto max-w-xl px-5 pt-5">
      <Link href="/apprendre/memorisation" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.hifdh.back}</Link>
      <h1 className="text-3xl">{t.hifdh.review}</h1>
      <HifdhTrainer verses={await versesByIds(data)} start={0} backHref="/apprendre/memorisation" t={t.hifdh} />
    </main>
  );
}
