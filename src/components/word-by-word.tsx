"use client";

import { useEffect, useState } from "react";
import { createPortal } from "react-dom";
import type { Dictionary } from "@/lib/dictionaries";
import type { VerseWords, WordGloss } from "@/lib/quran-words";

type T = Dictionary["quran"];

// Liste des mots d'un verset (arabe au-dessus, sens en francais dessous).
export function WordList({ words, verse }: { words: WordGloss[]; verse: number }) {
  return (
    <ul dir="rtl" className="mt-3 flex flex-wrap gap-2 border-t border-line pt-3" data-wbw={verse}>
      {words.map((w, i) => (
        <li key={i} className="rounded-md bg-tint px-2 py-1 text-center">
          <span lang="ar" className="quran-text block !text-xl !leading-loose">{w.ar}</span>
          <span lang="fr" dir="ltr" className="block max-w-[9rem] text-sm leading-snug text-muted">{w.fr}</span>
        </li>
      ))}
    </ul>
  );
}

// Mot a mot (equipe seulement) : bouton en tete de sourate pour tous les versets,
// et bouton « Mot à mot » sur chaque verset (attribut data-wbw-verse) pour un seul verset.
export function WordByWord({ surah, t }: { surah: number; t: T }) {
  const [all, setAll] = useState(false);
  const [open, setOpen] = useState<Set<number>>(new Set());
  const [verses, setVerses] = useState<VerseWords[] | null>(null);
  const [failed, setFailed] = useState(false);
  const [slots, setSlots] = useState<Map<number, HTMLElement>>(new Map());
  const active = all || open.size > 0;
  const shown = (n: number) => all || open.has(n);

  useEffect(() => {
    if (!active || verses || failed) return;
    fetch(`/api/mot-a-mot?surah=${surah}`)
      .then((res) => (res.ok ? res.json() : Promise.reject(new Error("wbw"))))
      .then((data: { verses: VerseWords[] }) => setVerses(data.verses))
      .catch(() => setFailed(true));
  }, [active, surah, verses, failed]);

  // Boutons de chaque verset : un clic ouvre ou ferme le mot a mot de ce verset seulement.
  useEffect(() => {
    const onClick = (event: MouseEvent) => {
      const button = (event.target as HTMLElement).closest<HTMLElement>("[data-wbw-verse]");
      if (!button) return;
      const n = Number(button.dataset.wbwVerse);
      if (!n) return;
      if (all) {
        const ids = Array.from(document.querySelectorAll<HTMLElement>("[data-wbw-verse]")).map((b) => Number(b.dataset.wbwVerse));
        setAll(false);
        setOpen(new Set(ids.filter((id) => id !== n)));
        return;
      }
      setOpen((prev) => {
        const next = new Set(prev);
        if (next.has(n)) next.delete(n);
        else next.add(n);
        return next;
      });
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, [all]);

  // Etat visible des boutons de chaque verset.
  useEffect(() => {
    document.querySelectorAll<HTMLElement>("[data-wbw-verse]").forEach((b) => {
      b.setAttribute("aria-pressed", String(all || open.has(Number(b.dataset.wbwVerse))));
    });
  }, [all, open]);

  // Un emplacement sous la traduction de chaque verset de la sourate.
  useEffect(() => {
    if (!active) return;
    const map = new Map<number, HTMLElement>();
    document.querySelectorAll<HTMLElement>(`li[id^="v${surah}-"]`).forEach((li) => {
      const n = Number(li.id.split("-")[1]);
      const slot = document.createElement("div");
      slot.setAttribute("data-wbw-slot", String(n));
      li.appendChild(slot);
      map.set(n, slot);
    });
    setSlots(map);
    return () => {
      map.forEach((slot) => slot.remove());
      setSlots(new Map());
    };
  }, [active, surah]);

  const pressAll = () => {
    setAll(!all);
    setOpen(new Set());
  };

  return (
    <>
      <button type="button" aria-pressed={all} onClick={pressAll} className={`inline-flex min-h-11 items-center rounded-lg border px-4 font-medium ${all ? "border-emerald bg-emerald text-on-emerald" : "border-line text-emerald"}`} data-wbw-toggle>
        {t.wbw}
      </button>
      {all ? <p className="mt-2 basis-full text-sm text-muted" data-wbw-notice>{failed ? t.wbwError : t.wbwNotice}</p> : null}
      {Array.from(slots.entries()).map(([n, slot]) => {
        if (!shown(n)) return null;
        const words = verses?.find((v) => v.number === n)?.words;
        return createPortal(
          failed ? (
            <p className="mt-3 border-t border-line pt-3 text-sm text-muted" data-wbw-error>{t.wbwError}</p>
          ) : words ? (
            <>
              <WordList words={words} verse={n} />
              {!all ? <p className="mt-1 text-sm text-muted">{t.wbwShort}</p> : null}
            </>
          ) : (
            <p className="mt-3 border-t border-line pt-3 text-sm text-muted">…</p>
          ),
          slot,
          `wbw-${n}`,
        );
      })}
    </>
  );
}
