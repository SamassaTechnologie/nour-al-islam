import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { getPreferences } from "@/lib/preferences";
import { getSurahs } from "@/lib/quran";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Mémorisation" };

export default async function HifdhHome() {
  if (!(await getSession())) redirect("/connexion?suivant=/apprendre/memorisation");
  const supabase = await createClient();
  const [{ t }, surahs, { data, error }] = await Promise.all([getPreferences(), getSurahs(), supabase.rpc("hifdh_summary")]);
  if (error) throw new Error(error.message);
  const h = t.hifdh;
  const rows = new Map((data as { surah: number; worked: number; due: number }[]).map((row) => [row.surah, row]));
  const due = [...rows.values()].reduce((sum, row) => sum + row.due, 0);
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{h.title}</h1>
      <p className="mt-2 text-muted">{h.intro}</p>
      {due ? <Link href="/apprendre/memorisation/revision" className="mt-4 flex min-h-12 items-center justify-between rounded-lg bg-emerald px-4 font-medium text-on-emerald"><span>{h.review}</span><span data-due>{due}</span></Link> : <p className="mt-4 border-s-2 border-gold ps-3" data-due="0">{h.nothingDue}</p>}
      <ul className="mt-5 divide-y divide-line border-y border-line">
        {surahs.map((surah) => {
          const row = rows.get(surah.number);
          return (
            <li key={surah.number}><Link href={`/apprendre/memorisation/${surah.number}`} className="flex min-h-14 items-center justify-between gap-3 py-2">
              <span><span lang="en" dir="ltr">{surah.number}. {surah.name_translit}</span><span className="block text-base text-muted" data-progress={surah.number}>{row?.worked ?? 0} / {surah.ayah_count} {h.worked}</span></span>
              <span lang="ar" dir="rtl" className="surah-name">{surah.name_ar}</span>
            </Link></li>
          );
        })}
      </ul>
    </main>
  );
}
