// Plan de lecture du Coran (khatm) : 604 pages reparties en parts quotidiennes egales.
// Le plan est garde sur l'appareil ; l'avancement se compte en pages lues dans l'ordre.

export const PAGES = 604;
export const DURATIONS = [7, 10, 15, 20, 30, 60] as const;
export const KHATM_KEY = "nour_khatm";
export const MUSHAF_LAST_KEY = "nour_mushaf_last";

export type Plan = { days: number; start: string; done: number; log: { date: string; to: number }[]; finished?: string };

/** Date locale AAAA-MM-JJ. */
export function localDate(d = new Date()) {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

function daysBetween(from: string, to: string) {
  const [a, b] = [from, to].map((s) => Date.UTC(Number(s.slice(0, 4)), Number(s.slice(5, 7)) - 1, Number(s.slice(8, 10))));
  return Math.round((b - a) / 86400_000);
}

/** Fin (page) de la part numero k (1 a days). */
export const boundary = (k: number, days: number) => Math.round((Math.min(k, days) * PAGES) / days);

export function newPlan(days: number, today = localDate(), from = 0): Plan {
  return { days, start: today, done: Math.max(0, Math.min(PAGES, from)), log: [] };
}

/** Etat du plan a une date donnee. */
export function planStatus(plan: Plan, today = localDate()) {
  const day = Math.max(0, daysBetween(plan.start, today)); // 0 = premier jour
  const expected = boundary(day + 1, plan.days); // pages a avoir lues a la fin d'aujourd'hui
  let k = 1;
  while (k < plan.days && boundary(k, plan.days) <= plan.done) k++;
  // Apres une lecture en avance, il peut rester quelques pages avant la fin de la part : on y joint la part suivante.
  if (k < plan.days && boundary(k, plan.days) - plan.done < PAGES / plan.days / 2) k++;
  const portionEnd = plan.done >= PAGES ? PAGES : Math.max(boundary(k, plan.days), plan.done + 1);
  const portion = plan.done >= PAGES ? null : { from: plan.done + 1, to: Math.min(PAGES, portionEnd), number: k };
  const behind = Math.max(0, expected - plan.done);
  const ahead = Math.max(0, plan.done - expected);
  const readToday = plan.log.some((entry) => entry.date === today);
  return {
    day: Math.min(day + 1, plan.days),
    overdue: day + 1 > plan.days && plan.done < PAGES,
    expected,
    portion,
    behind,
    ahead,
    readToday,
    percent: Math.round((plan.done / PAGES) * 100),
    finished: plan.done >= PAGES,
  };
}

/** Marque une part comme lue jusqu'a la page `to`. */
export function markRead(plan: Plan, to: number, today = localDate()): Plan {
  const done = Math.max(plan.done, Math.min(PAGES, to));
  const log = [...plan.log.filter((e) => e.date !== today), { date: today, to: done }].slice(-400);
  return { ...plan, done, log, finished: done >= PAGES ? plan.finished ?? today : plan.finished };
}

export function loadPlan(): Plan | null {
  try {
    const raw = JSON.parse(localStorage.getItem(KHATM_KEY) ?? "null");
    if (!raw || !DURATIONS.includes(raw.days) || !/^\d{4}-\d{2}-\d{2}$/.test(raw.start) || !Number.isInteger(raw.done)) return null;
    return { days: raw.days, start: raw.start, done: Math.max(0, Math.min(PAGES, raw.done)), log: Array.isArray(raw.log) ? raw.log : [], finished: raw.finished };
  } catch {
    return null;
  }
}

export function savePlan(plan: Plan | null) {
  try {
    if (plan) localStorage.setItem(KHATM_KEY, JSON.stringify(plan));
    else localStorage.removeItem(KHATM_KEY);
    window.dispatchEvent(new Event("nour-khatm"));
  } catch {
    // Reglage conserve seulement pendant la visite.
  }
}
