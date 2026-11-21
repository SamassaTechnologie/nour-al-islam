"use client";

import { useEffect, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["offline"];
export const QURAN_SAVED_KEY = "nour_quran_offline";

/** Garde les 114 sourates sur l'appareil pour les lire sans internet. */
export function SaveQuran({ t }: { t: T }) {
  const [state, setState] = useState<"idle" | "saving" | "saved" | "unsupported">("idle");
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    if (!("serviceWorker" in navigator) || !("caches" in window)) { setState("unsupported"); return; }
    try { if (localStorage.getItem(QURAN_SAVED_KEY) === "1") setState("saved"); } catch { /* facultatif */ }
    const onMessage = (e: MessageEvent) => {
      if (e.data?.type !== "save-progress") return;
      setProgress(e.data.done);
      if (e.data.done === e.data.total) {
        setState("saved");
        try { localStorage.setItem(QURAN_SAVED_KEY, "1"); } catch { /* facultatif */ }
      }
    };
    navigator.serviceWorker.addEventListener("message", onMessage);
    return () => navigator.serviceWorker.removeEventListener("message", onMessage);
  }, []);

  if (state === "unsupported") return null;
  const start = async () => {
    setState("saving"); setProgress(0);
    const reg = await navigator.serviceWorker.ready;
    reg.active?.postMessage({ type: "save-pages", urls: Array.from({ length: 114 }, (_, i) => `/coran/${i + 1}`) });
  };
  return (
    <section className="rounded-lg border border-line p-4" data-save-quran={state} aria-labelledby="texte-coran">
      <div className="flex items-start gap-3">
        <div className="min-w-0 flex-1">
          <h2 id="texte-coran" className="text-lg font-medium">{t.textTitle}</h2>
          <p className={`text-base ${state === "saved" ? "font-medium text-emerald" : "text-muted"}`} role="status">
            {state === "saving" ? t.saving.replace("{n}", String(progress)) : state === "saved" ? t.saved : t.textMissing}
          </p>
        </div>
        {state === "saved" ? (
          <button type="button" onClick={start} className="min-h-11 shrink-0 rounded-lg border border-line px-3 text-base font-medium">{t.update}</button>
        ) : null}
      </div>
      {state === "saving" ? (
        <div aria-hidden="true" className="mt-3 h-1.5 overflow-hidden rounded-full bg-tint">
          <div className="h-full bg-emerald transition-[width]" style={{ width: `${Math.round((progress / 114) * 100)}%` }} />
        </div>
      ) : null}
      {state === "idle" ? (
        <button type="button" onClick={start} className="mt-3 flex min-h-12 w-full items-center justify-center rounded-lg bg-emerald px-4 font-medium text-on-emerald">{t.save}</button>
      ) : null}
      <p className="mt-2 text-sm text-muted">{t.note}</p>
    </section>
  );
}
