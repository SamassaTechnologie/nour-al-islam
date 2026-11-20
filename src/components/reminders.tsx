"use client";

import { useEffect, useRef, useState } from "react";
import { getPushKey, removePushSubscription, savePushSubscription, type PushSettings } from "@/app/push-actions";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["reminders"];
type Base = Omit<PushSettings, "prayers" | "adhkar">;
type State = "loading" | "unsupported" | "ios" | "denied" | "off" | "on";
const KEY = "nour_reminders";

function toUint8(base64url: string) {
  const pad = "=".repeat((4 - (base64url.length % 4)) % 4);
  const raw = atob((base64url + pad).replace(/-/g, "+").replace(/_/g, "/"));
  return Uint8Array.from(raw, (c) => c.charCodeAt(0));
}

function loadChoice() {
  try {
    const raw = JSON.parse(localStorage.getItem(KEY) ?? "null");
    return { prayers: raw?.prayers !== false, adhkar: raw?.adhkar !== false };
  } catch { return { prayers: true, adhkar: true }; }
}

/** Rappels a l'heure des prieres et pour les invocations du matin et du soir (Web Push). */
export function Reminders({ base, placeLabel, t }: { base: Base; placeLabel: string; t: T }) {
  const [state, setState] = useState<State>("loading");
  const [choice, setChoice] = useState({ prayers: true, adhkar: true });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const baseKey = JSON.stringify(base);
  const synced = useRef("");

  useEffect(() => {
    setChoice(loadChoice());
    const ios = /iPad|iPhone|iPod/.test(navigator.userAgent) || (navigator.platform === "MacIntel" && navigator.maxTouchPoints > 1);
    const standalone = window.matchMedia("(display-mode: standalone)").matches || (navigator as { standalone?: boolean }).standalone === true;
    if (!("serviceWorker" in navigator) || !("PushManager" in window) || !("Notification" in window)) { setState(ios && !standalone ? "ios" : "unsupported"); return; }
    if (Notification.permission === "denied") { setState("denied"); return; }
    navigator.serviceWorker.getRegistration("/").then(async (reg) => {
      const sub = await reg?.pushManager.getSubscription();
      setState(sub && Notification.permission === "granted" ? "on" : "off");
    }).catch(() => setState("off"));
  }, []);

  // Si la ville, la methode ou la langue changent, l'abonnement est mis a jour.
  useEffect(() => {
    if (state !== "on" || synced.current === baseKey + JSON.stringify(choice)) return;
    synced.current = baseKey + JSON.stringify(choice);
    (async () => {
      const sub = await (await navigator.serviceWorker.getRegistration("/"))?.pushManager.getSubscription();
      if (sub) await savePushSubscription(sub.toJSON() as never, { ...JSON.parse(baseKey), ...choice });
    })();
  }, [state, baseKey, choice]);

  const persist = (next: typeof choice) => {
    setChoice(next);
    try { localStorage.setItem(KEY, JSON.stringify(next)); } catch { /* reglage facultatif */ }
  };

  const enable = async () => {
    setBusy(true); setError("");
    try {
      const permission = await Notification.requestPermission();
      if (permission !== "granted") { setState(permission === "denied" ? "denied" : "off"); return; }
      const reg = await navigator.serviceWorker.register("/sw.js", { scope: "/" });
      await navigator.serviceWorker.ready;
      const key = await getPushKey();
      if (!key) throw new Error("key");
      const sub = (await reg.pushManager.getSubscription()) ?? await reg.pushManager.subscribe({ userVisibleOnly: true, applicationServerKey: toUint8(key) });
      const ok = await savePushSubscription(sub.toJSON() as never, { ...base, ...choice });
      if (!ok) throw new Error("save");
      synced.current = baseKey + JSON.stringify(choice);
      setState("on");
    } catch {
      setError(t.error);
    } finally { setBusy(false); }
  };

  const disable = async () => {
    setBusy(true); setError("");
    try {
      const sub = await (await navigator.serviceWorker.getRegistration("/"))?.pushManager.getSubscription();
      if (sub) { await removePushSubscription(sub.endpoint); await sub.unsubscribe(); }
      setState("off");
    } catch { setError(t.error); } finally { setBusy(false); }
  };

  return (
    <section className="mt-7" aria-labelledby="rappels" data-reminders={state}>
      <h2 id="rappels" className="text-xl">{t.title}</h2>
      <p className="mt-1 text-muted">{t.intro}</p>
      {state === "ios" ? (
        <div className="mt-3 rounded-lg bg-tint p-4" data-ios-help>
          <p className="font-medium">{t.iosTitle}</p>
          <ol className="mt-2 list-decimal space-y-1 ps-5">{t.iosSteps.map((s) => <li key={s}>{s}</li>)}</ol>
        </div>
      ) : null}
      {state === "unsupported" ? <p className="mt-3 font-medium">{t.unsupported}</p> : null}
      {state === "denied" ? <p className="mt-3 font-medium" role="alert">{t.denied}</p> : null}
      {state === "off" || state === "on" ? (
        <>
          <label className="mt-3 flex min-h-11 items-center gap-3">
            <input type="checkbox" className="h-5 w-5 accent-emerald" checked={choice.prayers} onChange={(e) => persist({ ...choice, prayers: e.target.checked })} data-choice="prayers" />
            {t.prayers}
          </label>
          <label className="flex min-h-11 items-center gap-3">
            <input type="checkbox" className="h-5 w-5 accent-emerald" checked={choice.adhkar} onChange={(e) => persist({ ...choice, adhkar: e.target.checked })} data-choice="adhkar" />
            {t.adhkar}
          </label>
          {state === "on" ? <p className="mt-2 font-medium text-emerald" role="status" data-reminders-on>{t.on.replace("{place}", placeLabel)}</p> : null}
          <button type="button" disabled={busy || (state === "off" && !choice.prayers && !choice.adhkar)} onClick={state === "on" ? disable : enable}
            className={`mt-3 min-h-12 w-full rounded-lg px-4 font-medium ${state === "on" ? "border border-line" : "bg-emerald text-on-emerald"}`} data-reminders-toggle>
            {busy ? t.busy : state === "on" ? t.disable : t.enable}
          </button>
        </>
      ) : null}
      {error ? <p className="mt-2" role="alert">{error}</p> : null}
      <p className="mt-3 text-base text-muted">{t.privacy}</p>
    </section>
  );
}
