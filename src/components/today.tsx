import Link from "next/link";
import type { ReactNode } from "react";
import { Icon, Lattice, Star, type IconName } from "@/components/art";
import { HijriDate } from "@/components/hijri-date";
import { NextPrayer } from "@/components/next-prayer";
import type { getDashboard } from "@/lib/dashboard";
import type { Dictionary, Locale } from "@/lib/dictionaries";
import type { getReadingSummary, getSurahs } from "@/lib/quran";

type Dashboard = Awaited<ReturnType<typeof getDashboard>>;
type Reading = Awaited<ReturnType<typeof getReadingSummary>>;
type Surahs = Awaited<ReturnType<typeof getSurahs>>;

function Action({ href, icon, title, note, data, strong }: { href: string; icon: IconName; title: string; note: ReactNode; data: string; strong?: boolean }) {
  return (
    <li>
      <Link href={href} className={`flex min-h-16 items-center gap-3 rounded-lg px-4 py-3 ${strong ? "bg-emerald text-on-emerald" : "border border-line hover:border-gold"}`} data-today-action={data}>
        <span aria-hidden className={`grid size-10 shrink-0 place-items-center rounded-full ${strong ? "bg-white/15" : "bg-tint text-emerald"}`}>
          <Icon name={icon} className="h-5 w-5" />
        </span>
        <span className="min-w-0 flex-1">
          <span className="block font-medium">{title}</span>
          <span className={`block text-base ${strong ? "text-on-emerald/90" : "text-muted"}`}>{note}</span>
        </span>
        <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 opacity-70 rtl:-scale-x-100"><path d="m9 5 7 7-7 7" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
      </Link>
    </li>
  );
}

/** Ecran « Aujourd'hui » : ce que la personne connectee peut faire maintenant, en un coup d'oeil. */
export function Today({ t, locale, name, data, reading, surahs }: { t: Dictionary; locale: Locale; name: string; data: Dashboard; reading: Reading; surahs: Surahs }) {
  const d = t.today;
  const sections = t.content.sections as Record<string, string>;
  const lang = locale === "ar" ? "ar" : "fr-FR";
  const weekday = new Intl.DateTimeFormat(lang, { weekday: "narrow", timeZone: "UTC" });
  const longDay = new Intl.DateTimeFormat(lang, { weekday: "long", day: "numeric", month: "long", timeZone: "UTC" });
  const date = (day: string) => new Date(`${day}T00:00:00Z`);
  const last = reading?.recent[0];

  // Une seule action principale : la plus utile du moment (versets a reviser, puis exercices a revoir, puis lecon suivante, sinon lecture).
  const main = data.due > 0 ? "hifdh" : data.reviewDue > 0 ? "review" : data.next ? "lesson" : "read";

  return (
    <>
      <section className="relative overflow-hidden bg-night px-5 pt-6 pb-6 text-on-night" data-today>
        <Lattice id="today-lattice" className="opacity-20" />
        <div className="relative mx-auto max-w-xl">
          <p className="flex items-center gap-2 text-base text-on-night/80"><Star className="h-4 w-4 text-gold" />{d.greeting}</p>
          <h1 className="mt-1 text-3xl break-words">{name}</h1>
          <HijriDate locale={locale === "ar" ? "ar" : "fr"} label={t.home.hijriLabel} note={t.home.hijriNote} onNight />
          <div className="mt-4">
            <NextPrayer t={d} names={t.prayerTimes.names} inText={t.prayerTimes.in} locale={locale} />
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-xl px-5 pt-7" aria-labelledby="a-faire">
        <h2 id="a-faire" className="text-2xl">{d.continueTitle}</h2>
        <ul className="mt-4 space-y-3">
          {last ? (
            <Action href={`/coran/${last.surah}#v${last.surah}-${last.ayahs.number}`} icon="quran" title={d.readLast} strong={main === "read"} data="read"
              note={d.readLastNote.replace("{surah}", locale === "ar" ? surahs[last.surah - 1].name_ar : surahs[last.surah - 1].name_translit).replace("{n}", String(last.ayahs.number))} />
          ) : (
            <Action href="/coran/1" icon="quran" title={d.readStart} note={d.readStartNote} strong={main === "read"} data="read" />
          )}
          {data.next ? (
            <Action href={`/apprendre/${data.next.slug}`} icon="learn" title={d.lessonNext} strong={main === "lesson"} data="lesson"
              note={`${sections[data.next.section] ?? data.next.section} · ${data.next.title}`} />
          ) : (
            <Action href="/apprendre" icon="learn" title={d.lessonNone} note={d.lessonNoneNote} data="lesson" />
          )}
          {data.reviewDue > 0 ? (
            <Action href="/apprendre/revision" icon="learn" title={t.review.open} strong={main === "review"} data="review"
              note={t.review.due.replace("{n}", String(data.reviewDue))} />
          ) : null}
          <Action href={data.due > 0 ? "/apprendre/memorisation/revision" : "/apprendre/memorisation"} icon="learn" title={d.hifdh} strong={main === "hifdh"} data="hifdh"
            note={data.due > 0 ? d.hifdhDue.replace("{n}", String(data.due)) : data.memorised > 0 ? d.hifdhNone : d.hifdhStart} />
        </ul>
      </section>

      <section className="mx-auto max-w-xl px-5 pt-7" aria-labelledby="ma-serie">
        <div className="rounded-lg bg-tint p-4">
          <div className="flex items-baseline justify-between gap-3">
            <h2 id="ma-serie" className="text-lg">{d.streakTitle}</h2>
            <p className="font-medium" data-streak={data.streak}>
              {data.streak > 0 ? t.profile.dash.streak.replace("{n}", String(data.streak)) : null}
            </p>
          </div>
          {data.streak === 0 ? <p className="mt-1 text-base text-muted">{t.profile.dash.streakNone}</p> : null}
          <ol className="mt-3 grid grid-cols-7 gap-1" data-week>
            {data.week.map(({ day, active }) => (
              <li key={day} className="flex flex-col items-center gap-1" data-day={day} data-active={active ? "1" : "0"}>
                <span aria-hidden className="text-base text-muted">{weekday.format(date(day))}</span>
                <span aria-hidden className={`size-7 rounded-full border-2 ${active ? "border-emerald bg-emerald" : "border-line"} ${day === data.today ? "ring-2 ring-gold ring-offset-2 ring-offset-tint" : ""}`} />
                <span className="sr-only">{longDay.format(date(day))} : {active ? t.profile.dash.active : t.profile.dash.inactive}</span>
              </li>
            ))}
          </ol>
          <Link href="/profil" className="mt-3 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{d.profile}</Link>
        </div>
      </section>
    </>
  );
}
