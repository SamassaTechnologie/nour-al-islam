"use client";

import { useEffect, useState } from "react";

type Props = { locale: "fr" | "ar"; label: string; note: string };

function format(locale: string, calendar: string | null, d: Date) {
  const tag = calendar ? `${locale}-u-ca-${calendar}` : locale;
  return new Intl.DateTimeFormat(tag, { weekday: "long", day: "numeric", month: "long", year: "numeric" }).format(d);
}

export function HijriDate({ locale, label, note }: Props) {
  const [dates, setDates] = useState<{ hijri: string; greg: string } | null>(null);

  useEffect(() => {
    const update = () => {
      const now = new Date();
      try {
        const hijri = format(locale, "islamic-umalqura", now);
        if (!/1[34]\d\d/.test(hijri.replace(/[٠-٩]/g, (c) => String(c.charCodeAt(0) - 0x660)))) throw new Error("calendrier absent");
        setDates({ hijri, greg: format(locale, null, now) });
      } catch {
        setDates(null);
      }
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
