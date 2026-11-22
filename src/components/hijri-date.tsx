"use client";

import { useEffect, useState } from "react";

type Props = { locale: "fr" | "ar"; label: string; note: string };

// Noms des mois écrits par l'application : certains navigateurs calculent bien le
// calendrier hégirien mais affichent les noms des mois grégoriens (« juin »).
const MONTHS = {
  fr: ["Mouharram", "Safar", "Rabīʿ al-awwal", "Rabīʿ ath-thānī", "Joumādā al-oūlā", "Joumādā ath-thāniya", "Rajab", "Chaʿbān", "Ramadan", "Chawwāl", "Dhou al-qiʿda", "Dhou al-hijja"],
  ar: ["المحرم", "صفر", "ربيع الأول", "ربيع الآخر", "جمادى الأولى", "جمادى الآخرة", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة"],
};

export function hijriParts(d: Date): { day: number; month: number; year: number } | null {
  try {
    const parts = new Intl.DateTimeFormat("en-u-ca-islamic-umalqura-nu-latn", { day: "numeric", month: "numeric", year: "numeric" }).formatToParts(d);
    const get = (type: string) => Number(parts.find((p) => p.type === type)?.value);
    const day = get("day"), month = get("month"), year = get("year");
    if (!(day >= 1 && day <= 30 && month >= 1 && month <= 12 && year >= 1400 && year <= 1600)) return null;
    return { day, month, year };
  } catch {
    return null;
  }
}

export function formatHijri(locale: "fr" | "ar", d: Date): string | null {
  const h = hijriParts(d);
  if (!h) return null;
  const weekday = new Intl.DateTimeFormat(locale, { weekday: "long" }).format(d);
  const month = MONTHS[locale][h.month - 1];
  return locale === "ar" ? `${weekday} ${h.day} ${month} ${h.year} هـ` : `${weekday} ${h.day} ${month} ${h.year} H`;
}

export function HijriDate({ locale, label, note }: Props) {
  const [dates, setDates] = useState<{ hijri: string; greg: string } | null>(null);

  useEffect(() => {
    const update = () => {
      const now = new Date();
      const hijri = formatHijri(locale, now);
      setDates(hijri ? { hijri, greg: new Intl.DateTimeFormat(locale, { weekday: "long", day: "numeric", month: "long", year: "numeric" }).format(now) } : null);
    };
    update();
    const id = window.setInterval(update, 60_000);
    return () => window.clearInterval(id);
  }, [locale]);

  if (!dates) return <div className="mt-4 min-h-[4.5rem]" aria-hidden="true" />;
  return (
    <div className="mt-4 min-h-[4.5rem]" data-hijri-date>
      <p className="sr-only">{label}</p>
      <p lang={locale} dir={locale === "ar" ? "rtl" : "ltr"} className="text-lg font-semibold text-emerald" data-hijri>{dates.hijri}</p>
      <p lang={locale} dir={locale === "ar" ? "rtl" : "ltr"} className="text-base text-muted" data-gregorian>{dates.greg}</p>
      <p className="mt-1 text-sm text-muted">{note}</p>
    </div>
  );
}
