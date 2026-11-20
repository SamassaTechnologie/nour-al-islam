import Link from "next/link";
import type { getDashboard } from "@/lib/dashboard";
import type { Dictionary, Locale } from "@/lib/dictionaries";

type Data = Awaited<ReturnType<typeof getDashboard>>;

/** Tableau de bord personnel : serie de jours, journee, prochaine lecon, memorisation, rubriques. */
export function Dashboard({ data, t, locale }: { data: Data; t: Dictionary; locale: Locale }) {
  const d = t.profile.dash;
  const sections = t.content.sections as Record<string, string>;
  const lang = locale === "ar" ? "ar" : "fr-FR";
  const weekday = new Intl.DateTimeFormat(lang, { weekday: "narrow", timeZone: "UTC" });
  const longDay = new Intl.DateTimeFormat(lang, { weekday: "long", day: "numeric", month: "long", timeZone: "UTC" });
  const date = (day: string) => new Date(`${day}T00:00:00Z`);
  const today = data.todayRow;

  return (
    <section className="mt-7" aria-labelledby="tableau-de-bord" data-dashboard>
      <h2 id="tableau-de-bord" className="text-xl">{d.title}</h2>

      <div className="mt-3 rounded-lg bg-tint p-4">
        <p className="text-base text-muted">{d.streakLabel}</p>
        <p className="text-2xl font-medium" data-streak={data.streak}>
          {data.streak > 0 ? d.streak.replace("{n}", String(data.streak)) : <span className="text-base font-normal">{d.streakNone}</span>}
        </p>
        <p className="sr-only">{d.week}</p>
        <ol className="mt-3 grid grid-cols-7 gap-1" data-week>
          {data.week.map(({ day, active }) => (
            <li key={day} className="flex flex-col items-center gap-1" data-day={day} data-active={active ? "1" : "0"}>
              <span aria-hidden className="text-base text-muted">{weekday.format(date(day))}</span>
              <span aria-hidden className={`size-7 rounded-full border-2 ${active ? "border-emerald bg-emerald" : "border-line"} ${day === data.today ? "ring-2 ring-gold ring-offset-2 ring-offset-tint" : ""}`} />
              <span className="sr-only">{longDay.format(date(day))} : {active ? d.active : d.inactive}</span>
            </li>
          ))}
        </ol>
      </div>

      <h3 className="mt-6 text-lg">{d.today}</h3>
      <dl className="mt-2 divide-y divide-line border-y border-line" data-today>
        <div className="flex justify-between gap-3 py-2"><dt>{d.exercises}</dt><dd className="font-medium" data-today-exercises>{today.exercises}</dd></div>
        <div className="flex justify-between gap-3 py-2"><dt>{d.reviews}</dt><dd className="font-medium" data-today-reviews>{today.reviews}</dd></div>
        <div className="flex justify-between gap-3 py-2"><dt>{d.reading}</dt><dd className="font-medium" data-today-reading>{today.readings > 0 ? d.yes : d.no}</dd></div>
      </dl>

      <h3 className="mt-6 text-lg">{d.next}</h3>
      {data.next ? (
        <Link href={`/apprendre/${data.next.slug}`} className="mt-2 block rounded-lg bg-emerald px-4 py-3 text-on-emerald" data-next={data.next.slug}>
          <span className="block text-base">{sections[data.next.section] ?? data.next.section}{data.next.position ? ` · ${t.content.step.replace("{n}", String(data.next.position))}` : ""}</span>
          <span className="block font-medium">{data.next.title}</span>
        </Link>
      ) : <p className="mt-2 text-muted" data-next="">{d.nextNone}</p>}

      <h3 className="mt-6 text-lg">{d.memorise}</h3>
      <p className="mt-1" data-memorised={data.memorised}>{d.memorised.replace("{n}", String(data.memorised))}</p>
      {data.memorised > 0 ? <p data-due={data.due}>{d.due.replace("{n}", String(data.due))}</p> : null}
      <Link href={data.due > 0 ? "/apprendre/memorisation/revision" : "/apprendre/memorisation"} className="flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">
        {data.due > 0 ? d.reviewNow : d.startHifdh}
      </Link>

      {data.sections.length ? (
        <>
          <h3 className="mt-6 text-lg">{d.sections}</h3>
          <ul className="mt-2 space-y-3" data-sections>
            {data.sections.map((s) => {
              const label = sections[s.section] ?? s.section;
              return (
                <li key={s.section} data-progress-section={s.section} data-done={s.done} data-total={s.total}>
                  <div className="flex justify-between gap-3 text-base">
                    <span className="font-medium">{label}</span>
                    <span className="text-muted">{d.lessons.replace("{done}", String(s.done)).replace("{total}", String(s.total))}</span>
                  </div>
                  <div role="progressbar" aria-label={label} aria-valuemin={0} aria-valuemax={s.total} aria-valuenow={s.done} className="mt-1 h-2 overflow-hidden rounded-full bg-tint">
                    <div className="h-full rounded-full bg-emerald" style={{ width: `${s.total ? Math.round((s.done / s.total) * 100) : 0}%` }} />
                  </div>
                </li>
              );
            })}
          </ul>
        </>
      ) : null}
      <p className="mt-4 text-base text-muted">{d.note}</p>
    </section>
  );
}
