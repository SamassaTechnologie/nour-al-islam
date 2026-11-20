import type { Metadata } from "next";
import Link from "next/link";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Hors connexion" };

export default async function Offline() {
  const { t } = await getPreferences();
  const o = t.offline;
  return (
    <main className="mx-auto max-w-xl px-5 pt-8" data-offline-page>
      <h1 className="text-3xl">{o.title}</h1>
      <p className="mt-3">{o.intro}</p>
      <ul className="mt-4 space-y-2">
        <li><Link href="/coran" className="flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{o.quran}</Link></li>
        <li><Link href="/priere/horaires" className="flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{o.times}</Link></li>
        <li><Link href="/priere/invocations" className="flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{o.adhkar}</Link></li>
      </ul>
    </main>
  );
}
