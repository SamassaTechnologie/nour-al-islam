"use client";

import { useEffect, useState } from "react";

type T = { save: string; saving: string; saved: string; note: string; error: string };
const KEY = "nour_quran_offline";

/** Garde les 114 sourates sur l'appareil pour les lire sans internet. */
export function SaveQuran({ t }: { t: T }) {
  const [state, setState] = useState<"idle" | "saving" | "saved" | "unsupported">("idle");
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    if (!("serviceWorker" in navigator) || !("caches" in window)) { setState("unsupported"); return; }
    try { if (localStorage.getItem(KEY) === "1") setState("saved"); } catch { /* facultatif */ }
    const onMessage = (e: MessageEvent) => {
      if (e.data?.type !== "save-progress") return;
      setProgress(e.data.done);
      if (e.data.done === e.data.total) {
        setState("saved");
        try { localStorage.setItem(KEY, "1"); } catch { /* facultatif */ }
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
    <div className="mt-3" data-save-quran={state}>
      <button type="button" onClick={start} disabled={state === "saving"} className="flex min-h-12 w-full items-center justify-center rounded-lg border border-line px-4 font-medium">
        {state === "saving" ? t.saving.replace("{n}", String(progress)) : state === "saved" ? t.saved : t.save}
      </button>
      <p className="mt-1 text-base text-muted">{t.note}</p>
    </div>
  );
}
