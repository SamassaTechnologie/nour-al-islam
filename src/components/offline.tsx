"use client";

import { useEffect, useState } from "react";

const SIGNED_KEY = "nour_signed_in";

/** Enregistre le service worker (hors connexion, rappels) et signale l'absence de connexion. */
export function OfflineSupport({ signedIn, label }: { signedIn: boolean; label: string }) {
  const [offline, setOffline] = useState(false);

  useEffect(() => {
    if (!("serviceWorker" in navigator)) return;
    navigator.serviceWorker.register("/sw.js", { scope: "/" }).then(async () => {
      // Apres connexion ou deconnexion, les pages gardees d'une autre session sont effacees.
      let previous: string | null = null;
      try { previous = localStorage.getItem(SIGNED_KEY); localStorage.setItem(SIGNED_KEY, signedIn ? "1" : "0"); } catch { /* facultatif */ }
      if (previous !== null && previous !== (signedIn ? "1" : "0")) {
        (await navigator.serviceWorker.ready).active?.postMessage({ type: "clear-pages" });
      }
    }).catch(() => { /* le site fonctionne sans */ });
  }, [signedIn]);

  useEffect(() => {
    const update = () => setOffline(!navigator.onLine);
    update();
    window.addEventListener("online", update);
    window.addEventListener("offline", update);
    return () => { window.removeEventListener("online", update); window.removeEventListener("offline", update); };
  }, []);

  if (!offline) return null;
  return <p role="status" className="bg-gold px-4 py-2 text-center text-base font-medium text-night" data-offline-banner>{label}</p>;
}
