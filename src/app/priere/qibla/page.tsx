import type { Metadata } from "next";
import Link from "next/link";
import { QiblaCompass } from "@/components/qibla-compass";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Direction de la Qibla" };

export default async function Page() {
  const { t, locale } = await getPreferences();
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/priere" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.adhkar.backPrayer}</Link>
      <h1 className="text-3xl">{t.qibla.title}</h1>
      <p className="mt-2 text-muted">{t.qibla.intro}</p>
      <QiblaCompass t={t.qibla} myPositionLabel={t.prayerTimes.myPosition} lang={locale === "ar" ? "ar" : "fr"} />
    </main>
  );
}
