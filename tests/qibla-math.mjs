// Calcul de la Qibla compare a des valeurs de reference independantes (formule du grand cercle).
import { execSync } from "node:child_process";
const src = execSync("npx --yes esbuild src/lib/qibla.ts --format=esm --log-level=error").toString();
const { qiblaBearing, distanceToKaaba, angleDiff } = await import("data:text/javascript," + encodeURIComponent(src));
let failed = 0;
const check = (label, ok, d = "") => { if (!ok) failed++; console.log(`${ok ? "OK " : "ECHEC"} ${label}${d ? ` (${d})` : ""}`); };
// Valeurs de reference : cap initial geodesique calcule avec geographiclib 2.x (ellipsoide WGS84),
// Geodesic.WGS84.Inverse(lat, lng, 21.422487, 39.826206). Tolerance 0,6 degre (sphere contre ellipsoide).
const REF = [
  ["Bamako", 12.6392, -8.0029, 72.4],
  ["Paris", 48.8566, 2.3522, 119.04],
  ["Médine", 24.4672, 39.6111, 176.21],
  ["Dakar", 14.7167, -17.4677, 73.98],
  ["New York", 40.7128, -74.006, 58.4],
  ["Jakarta", -6.2088, 106.8456, 295.02],
];
for (const [name, lat, lng, ref] of REF) {
  const b = qiblaBearing(lat, lng);
  check(`${name} : ${b.toFixed(1)}°`, Math.abs(angleDiff(b, ref)) < 0.6, `référence ${ref}°`);
}
const d = distanceToKaaba(12.6392, -8.0029);
check(`Bamako - La Mecque : ${Math.round(d)} km`, Math.abs(d - 5165) < 20);
check("écart d'angle 350/10 = -20", angleDiff(350, 10) === -20);
process.exit(failed ? 1 : 0);
