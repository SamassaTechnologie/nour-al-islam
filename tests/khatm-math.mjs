// Calculs du plan de lecture : parts egales, retard, avance, fin du khatm.
import { execSync } from "node:child_process";
const src = execSync("npx --yes esbuild src/lib/khatm.ts --format=esm --log-level=error").toString();
const k = await import("data:text/javascript," + encodeURIComponent(src));
let failed = 0;
const check = (label, ok, d = "") => { if (!ok) failed++; console.log(`${ok ? "OK " : "ECHEC"} ${label}${d ? ` (${d})` : ""}`); };

for (const days of k.DURATIONS) {
  const sizes = Array.from({ length: days }, (_, i) => k.boundary(i + 1, days) - k.boundary(i, days));
  check(`${days} jours : total 604 pages`, sizes.reduce((a, b) => a + b, 0) === 604);
  check(`${days} jours : parts égales à une page près`, Math.max(...sizes) - Math.min(...sizes) <= 1, sizes.slice(0, 4).join(","));
}
let plan = k.newPlan(30, "2026-11-21");
let s = k.planStatus(plan, "2026-11-21");
check("jour 1 : part pages 1 à 20", s.portion.from === 1 && s.portion.to === 20 && s.day === 1, JSON.stringify(s.portion));
plan = k.markRead(plan, 20, "2026-11-21");
s = k.planStatus(plan, "2026-11-21");
check("part lue : à jour, part suivante 21 à 40", s.behind === 0 && s.readToday && s.portion.from === 21 && s.portion.to === 40);
s = k.planStatus(plan, "2026-11-24");
check("3 jours sans lire : en retard de 61 pages (fin du jour 4 : page 81)", s.behind === 61 && s.day === 4 && s.expected === 81, String(s.behind));
plan = k.markRead(plan, 100, "2026-11-22");
s = k.planStatus(plan, "2026-11-22");
check("lecture en avance : 60 pages d'avance", s.ahead === 60 && s.portion.from === 101 && s.portion.to === 121, JSON.stringify(s));
plan = k.markRead(plan, 30, "2026-11-23");
check("on ne recule jamais", plan.done === 100);
plan = k.markRead(plan, 604, "2026-12-01");
s = k.planStatus(plan, "2026-12-01");
check("khatm terminé", s.finished && s.portion === null && s.percent === 100 && plan.finished === "2026-12-01");
const late = k.planStatus(k.newPlan(7, "2026-11-01"), "2026-11-21");
check("plan dépassé : signalé", late.overdue && late.behind === 604);
const midway = k.planStatus(k.newPlan(30, "2026-11-21", 293), "2026-11-21");
check("départ à la page 294 : reste de part joint à la suivante (294 à 322)", midway.portion.from === 294 && midway.portion.to === 322, JSON.stringify(midway.portion));
const dst = k.planStatus(k.newPlan(30, "2026-03-28"), "2026-03-30");
check("changement d'heure sans effet sur le jour", dst.day === 3);
process.exit(failed ? 1 : 0);
