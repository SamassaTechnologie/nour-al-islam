"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import { DURATIONS, MUSHAF_LAST_KEY, PAGES, type Plan, loadPlan, localDate, markRead, newPlan, planStatus, savePlan } from "@/lib/khatm";

type T = Dictionary["khatm"];
export type PageRef = { surah: number; number: number; juz: number };
type Refs = { starts: PageRef[]; names: string[]; counts: number[] };

/** Premier et dernier verset d'une suite de pages (repere lu dans le texte, jamais saisi). */
export function rangeLabel({ starts, names, counts }: Refs, from: number, to: number) {
  const first = starts[from - 1];
  let end: { surah: number; number: number };
  if (to >= PAGES) end = { surah: 114, number: counts[113] };
  else {
    const next = starts[to];
    end = next.number > 1 ? { surah: next.surah, number: next.number - 1 } : { surah: next.surah - 1, number: counts[next.surah - 2] };
  }
  return {
    start: `${names[first.surah - 1]} ${first.surah}:${first.number}`,
    end: `${names[end.surah - 1]} ${end.surah}:${end.number}`,
    juz: first.juz,
    surah: first.surah,
    verse: first.number,
  };
}

export function usePlan() {
  const [plan, setPlan] = useState<Plan | null | undefined>(undefined);
  useEffect(() => {
    const refresh = () => setPlan(loadPlan());
    refresh();
    window.addEventListener("nour-khatm", refresh);
    window.addEventListener("storage", refresh);
    return () => {
      window.removeEventListener("nour-khatm", refresh);
      window.removeEventListener("storage", refresh);
    };
  }, []);
  return plan;
}

export function KhatmPlan({ t, refs, lang }: { t: T; refs: Refs; lang: string }) {
  const plan = usePlan();
  const [days, setDays] = useState(30);
  const [from, setFrom] = useState(1);
  const [confirmStop, setConfirmStop] = useState(false);
  const [lastSeen, setLastSeen] = useState(0);

  useEffect(() => {
    try { setLastSeen(Number(localStorage.getItem(MUSHAF_LAST_KEY)) || 0); } catch { /* facultatif */ }
  }, [plan]);

  if (plan === undefined) return null;
  const number = new Intl.NumberFormat(lang);
  const dateFmt = new Intl.DateTimeFormat(lang, { day: "numeric", month: "long", year: "numeric" });

  if (!plan) {
    const perDay = Math.ceil((PAGES - (from - 1)) / days);
    return (
      <div className="mt-5" data-khatm="new">
        <fieldset>
          <legend className="font-medium">{t.choose}</legend>
          <div className="mt-2 grid grid-cols-3 gap-2">
            {DURATIONS.map((n) => (
              <button key={n} type="button" aria-pressed={days === n} onClick={() => setDays(n)} className={`min-h-14 rounded-lg border px-2 ${days === n ? "border-emerald bg-emerald font-medium text-on-emerald" : "border-line"}`} data-days={n}>
                {t.days.replace("{n}", number.format(n))}
              </button>
            ))}
          </div>
          <p className="mt-2 text-base text-muted" data-per-day>{t.perDay.replace("{n}", number.format(perDay))}</p>
        </fieldset>
        <label className="mt-4 block font-medium">
          {t.startFrom}
          <input type="number" inputMode="numeric" min={1} max={PAGES} value={from} onChange={(e) => setFrom(Math.max(1, Math.min(PAGES, Number(e.target.value) || 1)))} className="mt-1 block min-h-12 w-32 rounded-lg border border-line bg-page px-3 font-normal" data-start-page />
        </label>
        <p className="mt-1 text-base text-muted">{t.startFromNote}</p>
        <button type="button" onClick={() => savePlan(newPlan(days, localDate(), from - 1))} className="mt-5 flex min-h-12 w-full items-center justify-center rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-khatm-start>{t.start}</button>
      </div>
    );
  }

  const s = planStatus(plan);
  const range = s.portion ? rangeLabel(refs, s.portion.from, s.portion.to) : null;
  const seen = s.portion && lastSeen >= s.portion.from && lastSeen > plan.done ? Math.min(lastSeen, PAGES) : 0;

  return (
    <div className="mt-5" data-khatm="active" data-done={plan.done}>
      <div className="flex items-baseline justify-between gap-3">
        <p className="font-medium">{t.day.replace("{d}", number.format(s.day)).replace("{total}", number.format(plan.days))}</p>
        <p className={`text-base font-medium ${s.behind ? "text-danger" : "text-emerald"}`} data-khatm-status>
          {s.finished ? "" : s.behind ? t.behind.replace("{n}", number.format(s.behind)) : s.ahead ? t.ahead.replace("{n}", number.format(s.ahead)) : t.onTrack}
        </p>
      </div>
      <div className="mt-2 h-2 overflow-hidden rounded-full bg-tint" aria-hidden="true">
        <div className="h-full bg-emerald" style={{ width: `${(plan.done / PAGES) * 100}%` }} />
      </div>
      <p className="mt-1 text-base text-muted" data-khatm-progress>{t.progress.replace("{p}", number.format(s.percent)).replace("{done}", number.format(plan.done))}</p>
      {s.overdue ? <p className="mt-2 text-base">{t.overdue}</p> : null}

      {s.finished ? (
        <div className="mt-5 rounded-lg bg-emerald px-4 py-4 text-on-emerald" data-khatm-finished>
          <p className="text-xl font-medium">{t.finished.replace("{date}", dateFmt.format(new Date(`${plan.finished ?? localDate()}T12:00:00`)))}</p>
          <button type="button" onClick={() => savePlan(null)} className="mt-3 min-h-11 rounded-lg bg-page px-4 font-medium text-emerald">{t.restart}</button>
        </div>
      ) : s.portion && range ? (
        <section className="mt-5 rounded-lg border border-line p-4" aria-labelledby="part-du-jour" data-khatm-portion={`${s.portion.from}-${s.portion.to}`}>
          <p className="text-base text-muted" id="part-du-jour">{s.readToday && !s.behind ? t.next : t.today} · {t.juz.replace("{n}", number.format(range.juz))}</p>
          <p className="text-2xl font-medium">{t.portion.replace("{from}", number.format(s.portion.from)).replace("{to}", number.format(s.portion.to))}</p>
          <p className="text-base">{t.range.replace("{start}", range.start).replace("{end}", range.end)}</p>
          {s.readToday && !s.behind ? <p className="mt-2 font-medium text-emerald" data-khatm-today>{t.doneToday}</p> : null}
          <div className="mt-4 grid grid-cols-2 gap-2">
            <Link href={`/coran/mushaf/${s.portion.from}`} className="flex min-h-12 items-center justify-center rounded-lg bg-emerald px-3 text-center font-medium text-on-emerald" data-khatm-mushaf>{t.read}</Link>
            <Link href={`/coran/${range.surah}#v${range.surah}-${range.verse}`} className="flex min-h-12 items-center justify-center rounded-lg border border-line px-3 text-center font-medium">{t.readText}</Link>
          </div>
          {seen ? (
            <div className="mt-4 rounded-lg bg-tint p-3" data-khatm-seen={seen}>
              <p className="text-base">{t.seen.replace("{page}", number.format(seen))}</p>
              <button type="button" onClick={() => savePlan(markRead(plan, seen))} className="mt-2 min-h-11 font-medium text-emerald underline underline-offset-4">{t.markSeen.replace("{page}", number.format(seen))}</button>
            </div>
          ) : null}
          <button type="button" onClick={() => savePlan(markRead(plan, s.portion!.to))} className="mt-4 flex min-h-12 w-full items-center justify-center rounded-lg border-2 border-emerald px-4 font-medium text-emerald" data-khatm-mark>{t.markRead}</button>
        </section>
      ) : null}

      <button
        type="button"
        onClick={() => { if (confirmStop) { savePlan(null); setConfirmStop(false); } else setConfirmStop(true); }}
        className="mt-6 min-h-11 text-base text-muted underline underline-offset-4"
        data-khatm-stop
      >
        {confirmStop ? t.stopConfirm : t.stop}
      </button>
    </div>
  );
}

/** Carte resumee pour la page Coran. */
export function KhatmCard({ t, lang }: { t: T; lang: string }) {
  const plan = usePlan();
  if (plan === undefined) return null;
  const number = new Intl.NumberFormat(lang);
  const s = plan ? planStatus(plan) : null;
  return (
    <Link href="/coran/plan" className="mt-3 flex items-center gap-3 rounded-lg border border-line px-4 py-3 hover:border-gold" data-khatm-card={plan ? "active" : "new"}>
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-6 w-6 shrink-0 text-gold-ink" fill="none" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round"><rect x="4" y="5" width="16" height="15" rx="2" /><path d="M4 10h16M9 3v4M15 3v4M8 14l2 2 4-4" /></svg>
      <span className="min-w-0 flex-1">
        <span className="block font-medium">{t.card}</span>
        <span className="block text-base text-muted">
          {!s ? t.cardNote
            : s.finished ? t.finished.replace("{date}", new Intl.DateTimeFormat(lang, { day: "numeric", month: "long", year: "numeric" }).format(new Date(`${plan?.finished ?? localDate()}T12:00:00`)))
            : `${s.readToday && !s.behind ? t.next : t.today} : ${t.portion.replace("{from}", number.format(s.portion!.from)).replace("{to}", number.format(s.portion!.to))}${s.behind ? ` · ${t.behind.replace("{n}", number.format(s.behind))}` : ""}`}
        </span>
      </span>
      {s && !s.finished ? <span className="text-base font-medium text-emerald" dir="ltr">{number.format(s.percent)} %</span> : null}
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-muted rtl:-scale-x-100"><path d="m9 5 7 7-7 7" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
    </Link>
  );
}
