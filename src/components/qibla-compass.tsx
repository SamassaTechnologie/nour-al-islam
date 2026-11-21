"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import type { Dictionary } from "@/lib/dictionaries";
import { CITIES, type Place } from "@/lib/prayer-times";
import { angleDiff, distanceToKaaba, qiblaBearing } from "@/lib/qibla";
import { useWakeLock } from "@/lib/use-wake-lock";

type T = Dictionary["qibla"];
// Meme lieu que les horaires de priere : un seul reglage pour l'utilisateur.
const KEY = "nour_prayer_settings";
const FACING = 5; // degres de tolerance pour « face a la Qibla »

type Orientation = DeviceOrientationEvent & { webkitCompassHeading?: number };
type IOSPermission = { requestPermission?: () => Promise<"granted" | "denied"> };

function loadPlace(): Place {
  try {
    const place = JSON.parse(localStorage.getItem(KEY) ?? "null")?.place;
    if (place && Number.isFinite(place.lat) && Number.isFinite(place.lng) && Math.abs(place.lat) <= 90 && Math.abs(place.lng) <= 180) return place;
  } catch { /* reglage facultatif */ }
  return CITIES[0];
}

function savePlace(place: Place) {
  try {
    const current = JSON.parse(localStorage.getItem(KEY) ?? "{}") ?? {};
    localStorage.setItem(KEY, JSON.stringify({ ...current, place }));
  } catch { /* reglage facultatif */ }
}

export function QiblaCompass({ t, myPositionLabel, lang }: { t: T; myPositionLabel: string; lang: string }) {
  const [place, setPlace] = useState<Place | null>(null);
  const [heading, setHeading] = useState<number | null>(null);
  const [state, setState] = useState<"idle" | "waiting" | "on" | "none" | "denied">("idle");
  const [locating, setLocating] = useState(false);
  const [geoError, setGeoError] = useState("");
  const smooth = useRef<number | null>(null);
  const buzzed = useRef(false);
  const refused = useRef(false);

  useEffect(() => setPlace(loadPlace()), []);
  useWakeLock(state === "on");

  const bearing = useMemo(() => (place ? qiblaBearing(place.lat, place.lng) : 0), [place]);
  const km = useMemo(() => (place ? Math.round(distanceToKaaba(place.lat, place.lng)) : 0), [place]);

  // Cap du telephone (0 = nord, sens des aiguilles d'une montre), lisse pour eviter les tremblements.
  const onHeading = useCallback((value: number) => {
    const screenAngle = (typeof screen !== "undefined" && screen.orientation?.angle) || 0;
    const raw = (value + screenAngle + 360) % 360;
    const prev = smooth.current;
    const next = prev === null ? raw : (prev + angleDiff(raw, prev) * 0.25 + 360) % 360;
    smooth.current = next;
    setHeading(next);
  }, []);

  const start = useCallback(async () => {
    const Ctor = (typeof DeviceOrientationEvent !== "undefined" ? DeviceOrientationEvent : undefined) as (typeof DeviceOrientationEvent & IOSPermission) | undefined;
    if (!Ctor) { setState("none"); return; }
    // iPhone (et Chrome recent) : autorisation demandee au toucher. Si elle n'est pas accordee,
    // on ecoute quand meme : sans mesure au bout de 3 s, on explique pourquoi.
    refused.current = false;
    if (typeof Ctor.requestPermission === "function") {
      try {
        refused.current = (await Ctor.requestPermission()) !== "granted";
      } catch { refused.current = true; }
    }
    setState("waiting");
  }, []);

  useEffect(() => {
    if (state !== "waiting" && state !== "on") return;
    // Android : orientation absolue (alpha compte dans le sens inverse des aiguilles d'une montre depuis le nord).
    const onAbsolute = (e: DeviceOrientationEvent) => {
      if (e.alpha === null) return;
      setState("on");
      onHeading(360 - e.alpha);
    };
    // iPhone : cap de la boussole fourni directement.
    const onRelative = (e: Event) => {
      const heading = (e as Orientation).webkitCompassHeading;
      if (typeof heading !== "number" || Number.isNaN(heading)) return;
      setState("on");
      onHeading(heading);
    };
    window.addEventListener("deviceorientationabsolute", onAbsolute as EventListener);
    window.addEventListener("deviceorientation", onRelative);
    const timer = window.setTimeout(() => setState((s) => (s === "waiting" ? (refused.current ? "denied" : "none") : s)), 3000);
    return () => {
      window.clearTimeout(timer);
      window.removeEventListener("deviceorientationabsolute", onAbsolute as EventListener);
      window.removeEventListener("deviceorientation", onRelative);
    };
  }, [state === "idle", onHeading]); // eslint-disable-line react-hooks/exhaustive-deps

  const diff = heading === null ? null : angleDiff(bearing, heading);
  const facing = diff !== null && Math.abs(diff) <= FACING;

  useEffect(() => {
    if (facing && !buzzed.current) {
      buzzed.current = true;
      navigator.vibrate?.(60);
    } else if (!facing) {
      buzzed.current = false;
    }
  }, [facing]);

  const choose = (next: Place) => {
    savePlace(next);
    setPlace(next);
  };

  const locate = () => {
    if (!("geolocation" in navigator)) { setGeoError(t.geoDenied); return; }
    setLocating(true); setGeoError("");
    navigator.geolocation.getCurrentPosition((pos) => {
      setLocating(false);
      choose({ label: myPositionLabel, lat: Math.round(pos.coords.latitude * 1e4) / 1e4, lng: Math.round(pos.coords.longitude * 1e4) / 1e4, tz: Intl.DateTimeFormat().resolvedOptions().timeZone });
    }, () => { setLocating(false); setGeoError(t.geoDenied); }, { timeout: 15000, maximumAge: 3600_000 });
  };

  if (!place) return null;
  // Le cadran tourne avec le telephone : le N du cadran reste vers le nord, la fleche verte vers la Qibla.
  const dial = heading === null ? 0 : -heading;
  const number = new Intl.NumberFormat(lang, { maximumFractionDigits: 0 });

  return (
    <div data-qibla data-bearing={bearing.toFixed(1)} data-state={state} data-facing={facing ? "" : undefined}>
      <label className="mt-4 block text-base font-medium">
        {t.place}
        <select
          value={CITIES.some((c) => c.label === place.label) ? place.label : "__position"}
          onChange={(e) => {
            const city = CITIES.find((c) => c.label === e.target.value);
            if (city) choose(city);
          }}
          className="mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-2 font-normal"
          data-qibla-city
        >
          {CITIES.some((c) => c.label === place.label) ? null : <option value="__position">{place.label}</option>}
          {CITIES.map((c) => <option key={c.label} value={c.label}>{c.label}</option>)}
        </select>
      </label>
      <button type="button" onClick={locate} disabled={locating} className="mt-2 min-h-11 text-base font-medium text-emerald underline underline-offset-4 disabled:opacity-60">{locating ? t.locating : t.myPosition}</button>
      {geoError ? <p role="alert" className="text-base text-danger">{geoError}</p> : null}

      <div className={`mt-4 rounded-lg px-4 py-3 ${facing ? "bg-emerald text-on-emerald" : "bg-tint"}`} role="status" aria-live="polite" data-qibla-status>
        <p className="text-3xl font-medium" dir="ltr" data-qibla-degrees>{number.format(bearing)}°</p>
        <p className="text-base">{t.bearing.replace("{deg}", number.format(bearing))}</p>
        <p className="text-base">{t.distance.replace("{km}", number.format(km))}</p>
        {state === "on" && diff !== null ? (
          <p className="mt-1 font-medium" data-qibla-turn>
            {facing ? t.facing : diff > 0 ? t.turnRight.replace("{deg}", number.format(Math.abs(diff))) : t.turnLeft.replace("{deg}", number.format(Math.abs(diff)))}
          </p>
        ) : null}
      </div>

      <div className="relative mx-auto mt-6 aspect-square w-full max-w-[18rem]" dir="ltr">
        {/* Repere fixe : le haut du telephone */}
        <svg aria-hidden="true" viewBox="0 0 24 24" className={`absolute start-1/2 -top-3 z-10 h-6 w-6 -translate-x-1/2 ${facing ? "text-emerald" : "text-ink"}`}><path d="M12 22 4 6h16z" fill="currentColor" /></svg>
        <svg viewBox="0 0 200 200" className="h-full w-full" role="img" aria-label={t.bearing.replace("{deg}", number.format(bearing))} style={{ transform: `rotate(${dial}deg)`, transition: "transform 120ms linear" }} data-qibla-dial>
          <circle cx="100" cy="100" r="96" fill="none" stroke="var(--color-line, currentColor)" strokeWidth="2" />
          {Array.from({ length: 72 }, (_, i) => {
            const long = i % 18 === 0;
            const a = (i * 5 * Math.PI) / 180;
            const r1 = long ? 80 : i % 2 === 0 ? 86 : 89;
            return <line key={i} x1={100 + r1 * Math.sin(a)} y1={100 - r1 * Math.cos(a)} x2={100 + 94 * Math.sin(a)} y2={100 - 94 * Math.cos(a)} stroke="currentColor" strokeOpacity={long ? 0.9 : 0.4} strokeWidth={long ? 2 : 1} />;
          })}
          <text x="100" y="34" textAnchor="middle" fontSize="16" fontWeight="600" fill="currentColor">{t.north}</text>
          <g transform={`rotate(${bearing} 100 100)`} data-qibla-arrow>
            <line x1="100" y1="100" x2="100" y2="30" stroke="var(--color-emerald, #0e6b4f)" strokeWidth="5" strokeLinecap="round" />
            <rect x="89" y="10" width="22" height="22" rx="2" fill="#1b1b1b" stroke="var(--color-gold, #c9a23c)" strokeWidth="2" />
            <line x1="89" y1="17" x2="111" y2="17" stroke="var(--color-gold, #c9a23c)" strokeWidth="2" />
          </g>
          <circle cx="100" cy="100" r="5" fill="currentColor" />
        </svg>
      </div>

      {state === "idle" ? (
        <button type="button" onClick={() => void start()} className="mt-5 flex min-h-12 w-full items-center justify-center rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-qibla-start>{t.start}</button>
      ) : null}
      {state === "none" ? <p className="mt-4 text-base text-muted" data-qibla-none>{t.noCompass}</p> : null}
      {state === "denied" ? <p role="alert" className="mt-4 text-base text-danger">{t.denied}</p> : null}
      {state === "on" || state === "waiting" ? (
        <ul className="mt-4 space-y-1 text-base text-muted">
          <li>{t.flat}</li>
          <li>{t.calibrate}</li>
        </ul>
      ) : null}
      <p className="mt-4 text-sm text-muted">{t.accuracy}</p>
      <Link href="/coran/2#v2-144" className="mt-2 inline-flex min-h-11 items-center text-base text-emerald underline underline-offset-4">{t.reference}</Link>
    </div>
  );
}
