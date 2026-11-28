"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { loadPrayerSettings, type Settings } from "@/components/prayer-times";
import { computeTimes, localDate, nextPrayer } from "@/lib/prayer-times";
import type { Dictionary, Locale } from "@/lib/dictionaries";

/**
 * Prochaine priere pour l'ecran « Aujourd'hui ».
 * Memes reglages et meme calcul que la page des horaires (gardes sur l'appareil, rien n'est envoye au serveur).
 */
export function NextPrayer({ t, names, inText, locale }: { t: Dictionary["today"]; names: Dictionary["prayerTimes"]["names"]; inText: string; locale: Locale }) {
  const [settings, setSettings] = useState<Settings | null>(null);
  const [now, setNow] = useState<Date | null>(null);

  useEffect(() => {
    setSettings(loadPrayerSettings());
    setNow(new Date());
    const id = setInterval(() => setNow(new Date()), 30_000);
    return () => clearInterval(id);
  }, []);

  const data = useMemo(() => {
    if (!settings || !now) return null;
    const times = computeTimes(settings.place, localDate(now, settings.place.tz), settings.method, settings.asr);
    const next = nextPrayer(times, now);
    if (next) return { key: next, at: times[next] };
    // Apres le ʿishāʾ : le fajr du lendemain.
    const tomorrow = localDate(new Date(now.getTime() + 24 * 3600_000), settings.place.tz);
    return { key: "fajr" as const, at: computeTimes(settings.place, tomorrow, settings.method, settings.asr).fajr };
  }, [settings, now]);

  const lang = locale === "ar" ? "ar" : "fr-FR";
  return (
    <Link href="/priere/horaires" className="block rounded-lg border border-gold/60 bg-white/5 px-4 py-3 text-on-night hover:bg-white/10" data-next-prayer={data?.key ?? ""}>
      <span className="block text-base text-on-night/80">{t.nextPrayer}</span>
      {data && settings && now ? (
        <>
          <span className="mt-0.5 flex flex-wrap items-baseline gap-x-3">
            <span className="font-display text-2xl">{names[data.key]}</span>
            <span className="text-lg" dir="ltr">{new Intl.DateTimeFormat(lang, { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: settings.place.tz }).format(data.at)}</span>
          </span>
          <span className="block text-base" data-next-prayer-in>
            {(() => {
              const minutes = Math.max(0, Math.round((data.at.getTime() - now.getTime()) / 60_000));
              return inText.replace("{h}", String(Math.floor(minutes / 60))).replace("{m}", String(minutes % 60));
            })()}
          </span>
          <span className="mt-1 flex items-center justify-between gap-2 text-base text-on-night/80">
            <span>{t.placeNote.replace("{city}", settings.place.label)}</span>
            <span className="font-medium text-gold">{t.allTimes}</span>
          </span>
        </>
      ) : <span className="block h-[4.75rem]" aria-hidden />}
    </Link>
  );
}
