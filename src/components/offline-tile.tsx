"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import { formatSize, listDownloads } from "@/lib/chapter-audio";
import { QURAN_SAVED_KEY } from "@/components/save-quran";

// Tuile « Sans internet » : resume de ce qui est garde sur l'appareil.
export function OfflineTile({ o, className }: { o: Dictionary["offline"]; className: string }) {
  const [status, setStatus] = useState(o.tile);

  useEffect(() => {
    const refresh = () => {
      let text = false;
      try { text = localStorage.getItem(QURAN_SAVED_KEY) === "1"; } catch { /* facultatif */ }
      const items = listDownloads();
      const parts = [];
      if (text) parts.push(o.tileText);
      if (items.length) parts.push(`${o.tileAudio.replace("{n}", String(items.length))} (${formatSize(items.reduce((s, i) => s + i.bytes, 0))})`);
      setStatus(parts.length ? parts.join(" · ") : o.tile);
    };
    refresh();
    window.addEventListener("nour-downloads", refresh);
    return () => window.removeEventListener("nour-downloads", refresh);
  }, [o]);

  return (
    <Link href="/coran/hors-ligne" className={className} data-tile="offline">
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-6 w-6 text-gold-ink" fill="none" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round"><path d="M12 4v11m0 0-4-4m4 4 4-4M5 20h14" /></svg>
      <span className="mt-2 block font-medium">{o.hub}</span>
      <span className="block text-base leading-snug text-muted" data-offline-status>{status}</span>
    </Link>
  );
}
