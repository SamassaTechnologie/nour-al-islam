"use client";

import { useEffect, useMemo, useState } from "react";
import { CITIES, computeTimes, DEFAULT_METHOD, localDate, METHODS, nextPrayer, PRAYERS, type AsrSchool, type Method, type Place } from "@/lib/prayer-times";
import type { Dictionary, Locale } from "@/lib/dictionaries";

type T = Dictionary["prayerTimes"];
const KEY = "nour_prayer_settings";
type Settings = { place: Place; method: Method; asr: AsrSchool };
const DEFAULTS: Settings = { place: CITIES[0], method: DEFAULT_METHOD, asr: "standard" };

function load(): Settings {
  try {
    const raw = JSON.parse(localStorage.getItem(KEY) ?? "null");
    if (!raw) return DEFAULTS;
    const place = raw.place && Number.isFinite(raw.place.lat) && Number.isFinite(raw.place.lng) && Math.abs(raw.place.lat) <= 90 && Math.abs(raw.place.lng) <= 180 ? raw.place as Place : DEFAULTS.place;
    try { new Intl.DateTimeFormat("fr", { timeZone: place.tz }); } catch { place.tz = DEFAULTS.place.tz; }
    return { place, method: METHODS.includes(raw.method) ? raw.method : DEFAULT_METHOD, asr: raw.asr === "hanafi" ? "hanafi" : "standard" };
  } catch { return DEFAULTS; }
}

export function PrayerTimesView({ t, locale }: { t: T; locale: Locale }) {
  const [settings, setSettings] = useState<Settings | null>(null);
  const [now, setNow] = useState(() => new Date());
  const [locating, setLocating] = useState(false);
  const [geoError, setGeoError] = useState("");

  useEffect(() => { setSettings(load()); }, []);
  useEffect(() => {
    const id = setInterval(() => setNow(new Date()), 30_000);
    return () => clearInterval(id);
  }, []);
  const save = (next: Settings) => {
    setSettings(next);
    try { localStorage.setItem(KEY, JSON.stringify(next)); } catch { /* reglage facultatif */ }
  };

  const lang = locale === "ar" ? "ar" : "fr-FR";
  const data = useMemo(() => {
    if (!settings) return null;
    const day = localDate(now, settings.place.tz);
    const times = computeTimes(settings.place, day, settings.method, settings.asr);
    let next = nextPrayer(times, now);
    let nextTime = next ? times[next] : null;
    if (!next) { // apres le ʿishāʾ : le fajr du lendemain
      const tomorrow = localDate(new Date(now.getTime() + 24 * 3600_000), settings.place.tz);
      next = "fajr";
      nextTime = computeTimes(settings.place, tomorrow, settings.method, settings.asr).fajr;
    }
    return { times, next, nextTime: nextTime! };
  }, [settings, now]);

  if (!settings || !data) return <p className="mt-6 text-muted" role="status">{t.loading}</p>;
  const fmt = new Intl.DateTimeFormat(lang, { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: settings.place.tz });
  const dateFmt = new Intl.DateTimeFormat(lang, { weekday: "long", day: "numeric", month: "long", year: "numeric", timeZone: settings.place.tz });
  const minutes = Math.max(0, Math.round((data.nextTime.getTime() - now.getTime()) / 60_000));
  const inText = t.in.replace("{h}", String(Math.floor(minutes / 60))).replace("{m}", String(minutes % 60));

  const locate = () => {
    if (!("geolocation" in navigator)) { setGeoError(t.geoUnavailable); return; }
    setLocating(true); setGeoError("");
    navigator.geolocation.getCurrentPosition((pos) => {
      setLocating(false);
      save({ ...settings, place: { label: t.myPosition, lat: Math.round(pos.coords.latitude * 1e4) / 1e4, lng: Math.round(pos.coords.longitude * 1e4) / 1e4, tz: Intl.DateTimeFormat().resolvedOptions().timeZone } });
    }, () => { setLocating(false); setGeoError(t.geoDenied); }, { timeout: 15000, maximumAge: 3600_000 });
  };

  return (
    <div data-prayer-times data-place={settings.place.label} data-method={settings.method} data-asr={settings.asr}>
      <p className="mt-4 font-medium" data-date>{settings.place.label} · {dateFmt.format(now)}</p>
      <div className="mt-3 rounded-lg bg-emerald px-4 py-3 text-on-emerald" data-next={data.next}>
        <p className="text-base">{t.next}</p>
        <p className="text-2xl font-medium">{t.names[data.next]} · {fmt.format(data.nextTime)}</p>
        <p className="text-base" data-countdown={minutes}>{inText}</p>
      </div>
      <ol className="mt-4 divide-y divide-line border-y border-line" data-list>
        {PRAYERS.map((k) => (
          <li key={k} data-prayer={k} data-time={data.times[k].toISOString()} className={`flex items-center justify-between gap-3 py-3 ${k === "sunrise" ? "text-muted" : ""} ${k === data.next ? "font-medium text-emerald" : ""}`}>
            <span>{t.names[k]}{k === "sunrise" ? <span className="block text-base">{t.sunriseNote}</span> : null}</span>
            <span className="tabular-nums text-xl" dir="ltr">{fmt.format(data.times[k])}</span>
          </li>
        ))}
      </ol>

      <h2 className="mt-7 text-xl">{t.settings}</h2>
      <button type="button" onClick={locate} disabled={locating} className="mt-3 min-h-12 w-full rounded-lg border border-line px-4 font-medium" data-locate>
        {locating ? t.locating : t.useLocation}
      </button>
      {geoError ? <p role="alert" className="mt-2 text-base">{geoError}</p> : null}
      <label className="mt-4 block font-medium" htmlFor="pt-city">{t.city}</label>
      <select id="pt-city" className="mt-1 min-h-12 w-full rounded-lg border border-line bg-page px-3" value={CITIES.some((c) => c.label === settings.place.label) ? settings.place.label : ""}
        onChange={(e) => { const c = CITIES.find((x) => x.label === e.target.value); if (c) save({ ...settings, place: c }); }}>
        {CITIES.some((c) => c.label === settings.place.label) ? null : <option value="">{settings.place.label}</option>}
        {CITIES.map((c) => <option key={c.label} value={c.label}>{c.label}</option>)}
      </select>
      <label className="mt-4 block font-medium" htmlFor="pt-method">{t.method}</label>
      <select id="pt-method" className="mt-1 min-h-12 w-full rounded-lg border border-line bg-page px-3" value={settings.method} onChange={(e) => save({ ...settings, method: e.target.value as Method })}>
        {METHODS.map((m) => <option key={m} value={m}>{t.methods[m]}</option>)}
      </select>
      <fieldset className="mt-4">
        <legend className="font-medium">{t.asr}</legend>
        {(["standard", "hanafi"] as const).map((s) => (
          <label key={s} className="flex min-h-11 items-center gap-3">
            <input type="radio" name="asr" value={s} checked={settings.asr === s} onChange={() => save({ ...settings, asr: s })} className="h-5 w-5 accent-emerald" />
            {t.asrSchools[s]}
          </label>
        ))}
      </fieldset>
      <p className="mt-5 border-s-2 border-gold ps-3 text-base" role="note">{t.note}</p>
    </div>
  );
}
