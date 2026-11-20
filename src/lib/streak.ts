/** Calculs du tableau de bord, sans acces a la base (testables seuls). Jours au format AAAA-MM-JJ, en UTC. */

export const dayKey = (date: Date) => date.toISOString().slice(0, 10);

export function addDays(day: string, delta: number) {
  const d = new Date(`${day}T00:00:00Z`);
  d.setUTCDate(d.getUTCDate() + delta);
  return dayKey(d);
}

/**
 * Nombre de jours actifs d'affilee jusqu'a aujourd'hui.
 * Si rien n'est encore fait aujourd'hui, la serie d'hier reste en cours (elle n'est pas perdue avant la fin du jour).
 */
export function currentStreak(activeDays: Iterable<string>, today: string) {
  const days = new Set(activeDays);
  let day = days.has(today) ? today : addDays(today, -1);
  let count = 0;
  while (days.has(day)) {
    count++;
    day = addDays(day, -1);
  }
  return count;
}

/** Les sept derniers jours, du plus ancien a aujourd'hui. */
export function lastWeek(activeDays: Iterable<string>, today: string) {
  const days = new Set(activeDays);
  return Array.from({ length: 7 }, (_, i) => {
    const day = addDays(today, i - 6);
    return { day, active: days.has(day) };
  });
}
