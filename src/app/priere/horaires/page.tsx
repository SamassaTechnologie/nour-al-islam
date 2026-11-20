import type { Metadata } from "next";
import Link from "next/link";
import { PrayerTimesView } from "@/components/prayer-times";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Horaires de prière" };

export default async function Page() {
  const { t, locale } = await getPreferences();
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/priere" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.adhkar.backPrayer}</Link>
      <h1 className="text-3xl">{t.prayerTimes.title}</h1>
      <p className="mt-2 text-muted">{t.prayerTimes.intro}</p>
      <PrayerTimesView t={t.prayerTimes} tr={t.reminders} locale={locale} />
    </main>
  );
}
