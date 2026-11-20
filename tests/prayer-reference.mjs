// Horaires de priere : comparaison avec un calcul independant (api.aladhan.com).
// Placer prayer-times.ts a cote (npm i adhan@4.4.6) ; lancer avec node --experimental-strip-types.
import { computeTimes, localDate } from "./prayer-times.ts";

let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const ALADHAN = { MuslimWorldLeague: 3, UmmAlQura: 4, Egyptian: 5, Karachi: 1, NorthAmerica: 2, Kuwait: 9, Qatar: 10 };
const cases = [
  ["Bamako", 12.6392, -8.0029, "Africa/Bamako", "MuslimWorldLeague", "standard"],
  ["Bamako (ʿaṣr hanafite)", 12.6392, -8.0029, "Africa/Bamako", "MuslimWorldLeague", "hanafi"],
  ["Kayes", 14.4469, -11.4456, "Africa/Bamako", "MuslimWorldLeague", "standard"],
  ["Tombouctou", 16.7666, -3.0026, "Africa/Bamako", "MuslimWorldLeague", "standard"],
  ["Dakar (Égypte)", 14.7167, -17.4677, "Africa/Dakar", "Egyptian", "standard"],
  ["Abidjan (Karachi)", 5.36, -4.0083, "Africa/Abidjan", "Karachi", "standard"],
  ["La Mecque (Umm al-Qurā)", 21.4225, 39.8262, "Asia/Riyadh", "UmmAlQura", "standard"],
  ["Niamey (Koweït)", 13.5116, 2.1254, "Africa/Niamey", "Kuwait", "standard"],
];
const dates = [new Date(Date.UTC(2026, 10, 20, 12)), new Date(Date.UTC(2027, 5, 21, 12))]; // novembre et solstice de juin
const keys = { fajr: "Fajr", sunrise: "Sunrise", dhuhr: "Dhuhr", asr: "Asr", maghrib: "Maghrib", isha: "Isha" };
for (const when of dates) for (const [label, lat, lng, tz, method, asr] of cases) {
  const day = localDate(when, tz);
  const ours = computeTimes({ lat, lng }, day, method, asr);
  const url = `https://api.aladhan.com/v1/timings/${String(day.day).padStart(2, "0")}-${String(day.month).padStart(2, "0")}-${day.year}?latitude=${lat}&longitude=${lng}&method=${ALADHAN[method]}&school=${asr === "hanafi" ? 1 : 0}&timezonestring=${tz}`;
  // Le service limite le nombre d'appels : pause entre les appels et nouvelles tentatives.
  let ref = null;
  for (let attempt = 0; attempt < 5 && !ref; attempt++) {
    await new Promise((r) => setTimeout(r, 1500 * (attempt + 1)));
    ref = (await (await fetch(url)).json().catch(() => null))?.data?.timings ?? null;
  }
  if (!ref) { check(`${label} : service de référence indisponible`, false); continue; }
  const fmt = new Intl.DateTimeFormat("en-GB", { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: tz });
  const diffs = Object.entries(keys).map(([k, rk]) => {
    const [h, m] = ref[rk].split(":").map(Number);
    const [oh, om] = fmt.format(ours[k]).split(":").map(Number);
    return [k, (oh * 60 + om) - (h * 60 + m)];
  });
  const worst = Math.max(...diffs.map(([, d]) => Math.abs(d)));
  check(`${label}, ${day.day}/${day.month}/${day.year} : écart maximal ${worst} min (tolérance 2)`, worst <= 2, diffs.map(([k, d]) => `${k} ${d >= 0 ? "+" : ""}${d}`).join(", "));
}
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
