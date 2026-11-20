"use client";

import { useEffect } from "react";

// Garde l'ecran allume tant que `active` est vrai (recitation en cours, page qui tourne seule).
// L'utilisateur peut toujours eteindre l'ecran avec le bouton du telephone : la recitation continue.
// Le navigateur libere le verrou quand l'application passe en arriere-plan : on le reprend au retour.
export function useWakeLock(active: boolean) {
  useEffect(() => {
    if (!active || !("wakeLock" in navigator)) return;
    let lock: WakeLockSentinel | null = null;
    let cancelled = false;
    const request = async () => {
      if (cancelled || document.visibilityState !== "visible" || (lock && !lock.released)) return;
      try {
        lock = await navigator.wakeLock.request("screen");
        if (cancelled) await lock.release();
      } catch {
        // Refuse (economie d'energie, onglet cache) : l'ecran s'eteindra normalement.
      }
    };
    void request();
    document.addEventListener("visibilitychange", request);
    return () => {
      cancelled = true;
      document.removeEventListener("visibilitychange", request);
      void lock?.release().catch(() => undefined);
    };
  }, [active]);
}
