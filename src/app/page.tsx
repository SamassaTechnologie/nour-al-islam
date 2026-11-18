import Link from "next/link";
import { Lattice, Star } from "@/components/art";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";

const arch = "M.5 150V132C.5 88 92 56 160 5c68 51 159.5 83 159.5 127v18";

export default async function HomePage() {
  const [{ t, locale }, session] = await Promise.all([getPreferences(), getSession()]);
  const h = t.home;
  return (
    <main>
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

      <section className="mx-auto max-w-xl px-6 pt-10">
        <h2 className="text-2xl">{h.pathTitle}</h2>
        <p className="mt-2 text-muted">{h.pathIntro}</p>
        <ol className="mt-6">
          {h.steps.map(([title, text], index) => (
            <li key={title} className="relative flex gap-4 pb-6 last:pb-0">
              {index < h.steps.length - 1 ? <span aria-hidden="true" className="absolute start-[0.6875rem] top-6 bottom-0 w-px bg-gold" /> : null}
              <Star className="h-6 w-6 shrink-0 text-gold" />
              <div>
                <h3 className="text-lg">{title}</h3>
                <p className="text-muted">{text}</p>
              </div>
            </li>
          ))}
        </ol>
        <p className="mt-5 text-base text-gold-ink">{h.inPreparation}</p>
      </section>

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

      <footer dir="ltr" lang="en" className="px-6 pt-8 text-center text-base text-muted" data-locale={locale}>
        NOUR AL-ISLAM {t.by}
      </footer>
    </main>
  );
}
