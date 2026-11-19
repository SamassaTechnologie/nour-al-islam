// Melange des propositions : permutation complete, repartition egale, stable, nouvelle a chaque tentative.
// Lancer : node --experimental-strip-types tests/quiz-order.mjs
import { optionOrder } from "../src/lib/quiz-order.ts";
import { randomUUID } from "node:crypto";
let fails = 0; const ok = (l, c) => { if (!c) fails++; console.log((c ? "OK   " : "ECHEC") + " " + l); };
for (const n of [2, 3, 4, 5]) {
  const pos = Array(n).fill(0); const N = 20000; let changed = 0;
  for (let i = 0; i < N; i++) {
    const id = randomUUID(); const o = optionOrder(id, n, 0);
    if ([...o].sort().join() !== [...Array(n).keys()].join()) { fails++; }
    pos[o.indexOf(0)]++;
    if (optionOrder(id, n, 1).join() !== o.join()) changed++;
    if (optionOrder(id, n, 0).join() !== o.join()) fails++;
  }
  const share = pos.map((x) => x / N);
  ok(`${n} propositions : position de la 1re proposition ${share.map((s) => (s * 100).toFixed(1) + "%").join(" ")}`, share.every((s) => Math.abs(s - 1 / n) < 0.02));
  ok(`${n} propositions : nouvel ordre à la tentative suivante dans ${(changed / N * 100).toFixed(0)} % des cas`, changed / N > (1 - 1 / factorial(n)) - 0.03);
}
function factorial(k) { return k <= 1 ? 1 : k * factorial(k - 1); }
console.log("ECHECS", fails); process.exit(fails ? 1 : 0);
