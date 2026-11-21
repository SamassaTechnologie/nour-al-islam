"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import { type Download, formatSize, listDownloads, removeDownload, syncDownloads } from "@/lib/chapter-audio";

// Recitations telechargees sur cet appareil, avec retrait (page « Sans internet »).
export function AudioDownloads({ t, o, names }: { t: Dictionary["quran"]; o: Dictionary["offline"]; names: string[] }) {
  const [items, setItems] = useState<Download[] | null>(null);

  useEffect(() => {
    const refresh = () => setItems(listDownloads().sort((a, b) => a.surah - b.surah || a.reciterName.localeCompare(b.reciterName)));
    refresh();
    void syncDownloads();
    window.addEventListener("nour-downloads", refresh);
    return () => window.removeEventListener("nour-downloads", refresh);
  }, []);

  const total = (items ?? []).reduce((sum, item) => sum + item.bytes, 0);
  return (
    <section className="mt-4 rounded-lg border border-line p-4" aria-labelledby="recitations" data-audio-downloads>
      <h2 id="recitations" className="text-lg font-medium">{o.audioTitle}</h2>
      {items === null ? null : items.length ? (
        <>
          <p className="text-base text-muted" data-downloads-total>{o.audioTotal.replace("{n}", String(items.length)).replace("{size}", formatSize(total))}</p>
          <ul className="mt-2 divide-y divide-line border-t border-line">
            {items.map((item) => (
              <li key={`${item.reciter}-${item.surah}`} className="flex items-center gap-3 py-2">
                <span aria-hidden="true" className="flex size-9 shrink-0 items-center justify-center rounded-full border border-gold text-base font-medium">{item.surah}</span>
                <Link href={`/coran/${item.surah}`} className="min-w-0 flex-1">
                  <span className="block font-medium">{names[item.surah - 1]}</span>
                  <span className="block truncate text-base text-muted">{item.reciterName} · {formatSize(item.bytes)}</span>
                </Link>
                <button type="button" onClick={() => void removeDownload(item.reciter, item.surah)} aria-label={`${t.removeDownload} : ${names[item.surah - 1]}`} className="grid size-11 shrink-0 place-items-center rounded-md text-muted hover:text-danger" data-remove-download>
                  <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M4 7h16M10 11v6M14 11v6M6 7l1 12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2l1-12M9 7V4h6v3" /></svg>
                </button>
              </li>
            ))}
          </ul>
        </>
      ) : (
        <p className="mt-1 text-base text-muted" data-downloads-empty>{o.audioEmpty}</p>
      )}
      <p className="mt-2 text-sm text-muted">{t.downloadNote} {t.audioCredit}</p>
    </section>
  );
}
