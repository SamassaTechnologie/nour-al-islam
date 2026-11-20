"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import { type Download, formatSize, listDownloads, removeDownload, syncDownloads } from "@/lib/chapter-audio";

// Liste des sourates telechargees sur cet appareil, avec retrait. N'apparait que s'il y en a.
export function AudioDownloads({ t, names }: { t: Dictionary["quran"]; names: string[] }) {
  const [items, setItems] = useState<Download[]>([]);

  useEffect(() => {
    const refresh = () => setItems(listDownloads().sort((a, b) => a.surah - b.surah || a.reciterName.localeCompare(b.reciterName)));
    refresh();
    void syncDownloads();
    window.addEventListener("nour-downloads", refresh);
    return () => window.removeEventListener("nour-downloads", refresh);
  }, []);

  if (!items.length) return null;
  const total = items.reduce((sum, item) => sum + item.bytes, 0);
  return (
    <details className="mt-3 rounded-lg border border-line px-4" data-audio-downloads>
      <summary className="flex min-h-12 cursor-pointer items-center justify-between font-medium">
        <span>{t.downloadsTitle} ({items.length})</span>
        <span className="text-base font-normal text-muted">{formatSize(total)}</span>
      </summary>
      <ul className="divide-y divide-line border-t border-line">
        {items.map((item) => (
          <li key={`${item.reciter}-${item.surah}`} className="flex items-center gap-2 py-2">
            <Link href={`/coran/${item.surah}`} className="min-w-0 flex-1">
              <span className="block font-medium">{item.surah}. {names[item.surah - 1]}</span>
              <span className="block truncate text-base text-muted">{item.reciterName} · {formatSize(item.bytes)}</span>
            </Link>
            <button type="button" onClick={() => void removeDownload(item.reciter, item.surah)} className="min-h-11 rounded-md px-2 text-base underline underline-offset-4">{t.removeDownload}</button>
          </li>
        ))}
      </ul>
      <p className="pb-3 text-sm text-muted">{t.downloadNote} {t.audioCredit}</p>
    </details>
  );
}
