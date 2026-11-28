import Link from "next/link";
import { Lattice, Star } from "@/components/art";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";
import { ArabicVerse } from "@/components/quran-view";
import { getSurahs } from "@/lib/quran";
import { getVerseOfDay } from "@/lib/verse-of-day";
import { HijriDate } from "@/components/hijri-date";
import { Today } from "@/components/today";
import { getDashboard } from "@/lib/dashboard";
import { getReadingSummary } from "@/lib/quran";

const STEP_LINKS = ["/apprendre#rubrique-arabe", "/apprendre#rubrique-tajwid", "/apprendre/memorisation", "/coran/1/tafsir", "/priere"];
const QUICK_LINKS = ["/coran", "/coran/mushaf", "/coran/1/tafsir", "/priere/horaires", "/priere/invocations", "/apprendre/memorisation", "/assistant", "/priere/qibla"];

const arch = "M.5 150V132C.5 88 92 56 160 5c68 51 159.5 83 159.5 127v18";

export default async function HomePage() {
  const [{ t, locale }, session, verse, surahs] = await Promise.all([getPreferences(), getSession(), getVerseOfDay().catch(() => null), getSurahs()]);
  const h = t.home;
  // Personne connectee : l'ecran « Aujourd'hui » remplace la porte d'entree, le parcours et les engagements.
  const today = session ? await Promise.all([getDashboard(), getReadingSummary()]) : null;
  return (
    <main>
      {session && today ? (
        <Today t={t} locale={locale} name={session.profile?.display_name ?? ""} data={today[0]} reading={today[1]} surahs={surahs} />
      ) : (
      <section className="relative overflow-hidden bg-night px-6 pt-6">
        <Lattice id="hero-lattice" className="opacity-25" />
        <div className="relative mx-auto max-w-[27rem]">
          <svg viewBox="0 0 320 150" aria-hidden="true" className="-mb-px block w-full">
            <path className="door-light" d={`${arch}Z`} fill="var(--page)" />
            <path className="door-line" d={arch} pathLength={1} fill="none" stroke="var(--gold)" strokeWidth="1.25" vectorEffect="non-scaling-stroke" />
          </svg>
          <div className="door-light border-x border-gold bg-page px-6 pb-8 text-center">
            <p lang="ar" dir="rtl" className="wordmark -mt-6 text-[3.25rem] leading-[1.35] font-semibold text-emerald">نور الإسلام</p>
            <h1 lang="en" dir="ltr" className="mt-2 text-xl tracking-wide">
              {t.brandFull}
              <span className="mt-0.5 block font-body text-base tracking-normal text-muted">{t.by}</span>
            </h1>
            <p className="mt-5 text-lg leading-snug">{t.slogan}</p>
            <HijriDate locale={locale === "ar" ? "ar" : "fr"} label={h.hijriLabel} note={h.hijriNote} />
            <div className="mt-6 space-y-2">
              <Link href="/coran" className="flex min-h-12 items-center justify-center rounded-lg bg-night px-5 font-medium text-on-night">{t.quran.title}</Link>
              {session ? (
                <Link href="/profil" className="flex min-h-12 items-center justify-center rounded-lg bg-emerald px-5 font-medium text-on-emerald">{h.open}</Link>
              ) : (
                <>
                  <Link href="/inscription" className="flex min-h-12 items-center justify-center rounded-lg bg-emerald px-5 font-medium text-on-emerald">{h.start}</Link>
                  <Link href="/connexion" className="flex min-h-12 items-center justify-center rounded-lg border border-line px-5 font-medium">{h.signIn}</Link>
                </>
              )}
            </div>
          </div>
        </div>
      </section>
      )}

      {verse ? (
        <section className="mx-auto max-w-xl px-6 pt-10" aria-labelledby="verset-du-jour" data-verse-of-day={`${verse.surah}:${verse.number}`}>
          <h2 id="verset-du-jour" className="text-2xl">{h.verseOfDay}</h2>
          <div className="mt-4 rounded-lg border border-line px-4 py-4">
            <ArabicVerse text={verse.arabic} />
            {verse.translation ? <p lang="fr" dir="ltr" className="mt-3">{verse.translation}</p> : null}
            <p className="mt-2 text-base font-medium text-emerald">
              <span lang="en" dir="ltr">{surahs[verse.surah - 1].name_translit}</span> {verse.surah}:{verse.number}
            </p>
            {verse.tafsir ? (
              <details className="mt-3 border-t border-line pt-2" data-verse-tafsir>
                <summary className="flex min-h-11 cursor-pointer items-center font-medium">{h.verseExplain}</summary>
                <p lang="fr" dir="ltr" className="text-muted">{verse.tafsir}</p>
              </details>
            ) : null}
            <div className="mt-3 grid grid-cols-2 gap-2">
              <Link href={`/coran/${verse.surah}#v${verse.surah}-${verse.number}`} className="flex min-h-11 items-center justify-center rounded-lg bg-emerald px-3 text-center font-medium text-on-emerald">{h.verseRead}</Link>
              <Link href={`/coran/${verse.surah}/tafsir#t${verse.number}`} className="flex min-h-11 items-center justify-center rounded-lg border border-line px-3 text-center font-medium">{h.verseTafsir}</Link>
            </div>
          </div>
          <p className="mt-2 text-sm text-muted">{h.verseSources}</p>
        </section>
      ) : null}

      {!session ? (
      <section className="mx-auto max-w-xl px-6 pt-10">
        <h2 className="text-2xl">{h.pathTitle}</h2>
        <p className="mt-2 text-muted">{h.pathIntro}</p>
        <ol className="mt-6">
          {h.steps.map(([title, text], index) => (
            <li key={title} className="relative pb-2 last:pb-0" data-step={index + 1}>
              {index < h.steps.length - 1 ? <span aria-hidden="true" className="absolute start-[1.4375rem] top-9 bottom-0 w-px bg-gold" /> : null}
              <Link href={STEP_LINKS[index]} className="relative flex items-center gap-4 rounded-lg px-2 py-2 hover:bg-tint">
                <Star className="h-6 w-6 shrink-0 text-gold" />
                <span className="min-w-0 flex-1">
                  <span className="block text-lg font-display">{title}</span>
                  <span className="block text-muted">{text}</span>
                </span>
                <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-muted rtl:-scale-x-100"><path d="m9 5 7 7-7 7" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
              </Link>
            </li>
          ))}
        </ol>
      </section>
      ) : null}

      <section className="mx-auto max-w-xl px-6 pt-10" aria-labelledby="acces-rapide">
        <h2 id="acces-rapide" className="text-2xl">{h.quickTitle}</h2>
        <ul className="mt-4 grid grid-cols-2 gap-3 min-[520px]:grid-cols-4">
          {h.quick.map(([title, text], index) => (
            <li key={title}>
              <Link href={QUICK_LINKS[index]} className="flex h-full min-h-20 flex-col justify-center rounded-lg border border-line px-3 py-3 hover:border-gold" data-quick={QUICK_LINKS[index]}>
                <span className="font-medium text-emerald">{title}</span>
                <span className="text-base leading-snug text-muted">{text}</span>
              </Link>
            </li>
          ))}
        </ul>
      </section>

      {!session ? (
      <section className="mt-10 bg-tint">
        <div className="mx-auto max-w-xl px-6 py-9">
          <h2 className="text-2xl">{h.trustTitle}</h2>
          <dl className="mt-5 space-y-4">
            {h.trust.map(([title, text]) => (
              <div key={title}>
                <dt className="font-bold">{title}</dt>
                <dd className="text-muted">{text}</dd>
              </div>
            ))}
          </dl>
        </div>
      </section>
      ) : null}

      <footer dir="ltr" lang="en" className="px-6 pt-8 text-center text-base text-muted" data-locale={locale}>
        NOUR AL-ISLAM {t.by}
      </footer>
    </main>
  );
}
