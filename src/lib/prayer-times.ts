import { CalculationMethod, Coordinates, HighLatitudeRule, Madhab, PrayerTimes } from "adhan";

/** Methodes proposees. Le choix definitif sera fait avec les savants ; par defaut : Ligue islamique mondiale. */
export const METHODS = ["MuslimWorldLeague", "UmmAlQura", "Egyptian", "Karachi", "NorthAmerica", "Dubai", "Kuwait", "Qatar", "Turkey", "MoonsightingCommittee", "Singapore"] as const;
export type Method = (typeof METHODS)[number];
export const DEFAULT_METHOD: Method = "MuslimWorldLeague";
export type AsrSchool = "standard" | "hanafi";
export const PRAYERS = ["fajr", "sunrise", "dhuhr", "asr", "maghrib", "isha"] as const;
export type PrayerKey = (typeof PRAYERS)[number];

export type Place = { label: string; lat: number; lng: number; tz: string };

/** Villes proposees si la position n'est pas partagee (coordonnees du centre-ville, fuseau IANA). */
export const CITIES: Place[] = [
  { label: "Bamako", lat: 12.6392, lng: -8.0029, tz: "Africa/Bamako" },
  { label: "Kayes", lat: 14.4469, lng: -11.4456, tz: "Africa/Bamako" },
  { label: "Sikasso", lat: 11.3176, lng: -5.6665, tz: "Africa/Bamako" },
  { label: "Ségou", lat: 13.4317, lng: -6.2157, tz: "Africa/Bamako" },
  { label: "Mopti", lat: 14.4843, lng: -4.1830, tz: "Africa/Bamako" },
  { label: "Tombouctou", lat: 16.7666, lng: -3.0026, tz: "Africa/Bamako" },
  { label: "Gao", lat: 16.2717, lng: -0.0447, tz: "Africa/Bamako" },
  { label: "Dakar", lat: 14.7167, lng: -17.4677, tz: "Africa/Dakar" },
  { label: "Conakry", lat: 9.6412, lng: -13.5784, tz: "Africa/Conakry" },
  { label: "Abidjan", lat: 5.3600, lng: -4.0083, tz: "Africa/Abidjan" },
  { label: "Ouagadougou", lat: 12.3714, lng: -1.5197, tz: "Africa/Ouagadougou" },
  { label: "Niamey", lat: 13.5116, lng: 2.1254, tz: "Africa/Niamey" },
  { label: "Nouakchott", lat: 18.0735, lng: -15.9582, tz: "Africa/Nouakchott" },
  { label: "Paris", lat: 48.8566, lng: 2.3522, tz: "Europe/Paris" },
  { label: "La Mecque", lat: 21.4225, lng: 39.8262, tz: "Asia/Riyadh" },
  { label: "Médine", lat: 24.4672, lng: 39.6111, tz: "Asia/Riyadh" },
];

/** Date du jour (annee, mois 1-12, jour) dans le fuseau du lieu. */
export function localDate(now: Date, tz: string) {
  const parts = new Intl.DateTimeFormat("en-CA", { timeZone: tz, year: "numeric", month: "2-digit", day: "2-digit" }).formatToParts(now);
  const get = (type: string) => Number(parts.find((p) => p.type === type)!.value);
  return { year: get("year"), month: get("month"), day: get("day") };
}

/** Horaires d'un jour (instants exacts) pour un lieu, une methode et une ecole pour le ʿasr. */
export function computeTimes(place: Pick<Place, "lat" | "lng">, day: { year: number; month: number; day: number }, method: Method, asr: AsrSchool) {
  const params = CalculationMethod[method]();
  params.madhab = asr === "hanafi" ? Madhab.Hanafi : Madhab.Shafi;
  // Au-dela de 48° de latitude, la nuit peut manquer pour le fajr et le ʿishāʾ : regle recommandee par la bibliotheque.
  if (Math.abs(place.lat) > 48) params.highLatitudeRule = HighLatitudeRule.recommended(new Coordinates(place.lat, place.lng));
  // adhan lit l'annee, le mois et le jour d'une Date locale : on lui donne le jour du lieu.
  const times = new PrayerTimes(new Coordinates(place.lat, place.lng), new Date(day.year, day.month - 1, day.day), params);
  return Object.fromEntries(PRAYERS.map((k) => [k, times[k]])) as Record<PrayerKey, Date>;
}

/** Prochaine priere a partir de maintenant (le lever du soleil n'est pas une priere). */
export function nextPrayer(times: Record<PrayerKey, Date>, now: Date): PrayerKey | null {
  return PRAYERS.filter((k) => k !== "sunrise").find((k) => times[k].getTime() > now.getTime()) ?? null;
}
