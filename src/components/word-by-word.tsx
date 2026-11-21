"use client";

import { useEffect, useState } from "react";
import { createPortal } from "react-dom";
import type { Dictionary } from "@/lib/dictionaries";
import type { VerseWords } from "@/lib/quran-words";

type T = Dictionary["quran"];

// Mot a mot (equipe seulement) : bouton en tete de sourate, mots places sous chaque verset.
export function WordByWord({ surah, t }: { surah: number; t: T }) {
  const [on, setOn] = useState(false);
  const [verses, setVerses] = useState<VerseWords[] | null>(null);
  const [failed, setFailed] = useState(false);
  const [slots, setSlots] = useState<Map<number, HTMLElement>>(new Map());

  useEffect(() => {
    if (!on || verses) return;
    fetch(`/api/mot-a-mot?surah=${surah}`)
      .then((res) => (res.ok ? res.json() : Promise.reject(new Error("wbw"))))
      .then((data: { verses: VerseWords[] }) => setVerses(data.verses))
      .catch(() => setFailed(true));
  }, [on, surah, verses]);

  // Un emplacement sous la traduction de chaque verset.
  useEffect(() => {
    if (!on || !verses) return;
    const map = new Map<number, HTMLElement>();
    for (const v of verses) {
      const li = document.getElementById(`v${surah}-${v.number}`);
      if (!li) continue;
      const slot = document.createElement("div");
      slot.setAttribute("data-wbw-slot", String(v.number));
      li.appendChild(slot);
      map.set(v.number, slot);
    }
    setSlots(map);
    return () => {
      map.forEach((slot) => slot.remove());
      setSlots(new Map());
    };
  }, [on, verses, surah]);

  return (
    <>
      <button type="button" aria-pressed={on} onClick={() => setOn(!on)} className={`inline-flex min-h-11 items-center rounded-lg border px-4 font-medium ${on ? "border-emerald bg-emerald text-on-emerald" : "border-line text-emerald"}`} data-wbw-toggle>
        {t.wbw}
      </button>
      {on ? <p className="mt-2 basis-full text-sm text-muted" data-wbw-notice>{failed ? t.wbwError : t.wbwNotice}</p> : null}
      {on && verses
        ? verses.map((v) => {
            const slot = slots.get(v.number);
            if (!slot) return null;
            return createPortal(
              <ul dir="rtl" className="mt-3 flex flex-wrap gap-2 border-t border-line pt-3" data-wbw={v.number}>
                {v.words.map((w, i) => (
                  <li key={i} className="rounded-md bg-tint px-2 py-1 text-center">
                    <span lang="ar" className="quran-text block !text-xl !leading-loose">{w.ar}</span>
                    <span lang="fr" dir="ltr" className="block max-w-[9rem] text-sm leading-snug text-muted">{w.fr}</span>
                  </li>
                ))}
              </ul>,
              slot,
            );
          })
        : null}
    </>
  );
}
