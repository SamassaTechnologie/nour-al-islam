"use client";

import { useEffect, useRef, useState, useTransition } from "react";
import { saveReading, toggleBookmark } from "@/app/quran-actions";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["quran"];
const SCALE_KEY = "nour_quran_scale";
const TRANSLATION_KEY = "nour_quran_translation";

function read(key: string) {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
}

function write(key: string, value: string) {
  try {
    localStorage.setItem(key, value);
  } catch {
    // Reglage conserve seulement pour cette page.
  }
}

export function ReaderControls({ t }: { t: T }) {
  const [scale, setScale] = useState(1);
  const [translation, setTranslation] = useState(true);
  const [focus, setFocus] = useState(false);

  useEffect(() => {
    const saved = Number(read(SCALE_KEY));
    if (saved >= 0.8 && saved <= 1.8) setScale(saved);
    if (read(TRANSLATION_KEY) === "off") setTranslation(false);
  }, []);

  useEffect(() => {
    const root = document.documentElement;
    root.style.setProperty("--quran-scale", String(scale));
    root.toggleAttribute("data-hide-translation", !translation);
    root.toggleAttribute("data-reading", focus);
    return () => root.removeAttribute("data-reading");
  }, [scale, translation, focus]);

  const size = (delta: number) => {
    const next = Math.min(1.8, Math.max(0.8, Math.round((scale + delta) * 10) / 10));
    setScale(next);
    write(SCALE_KEY, String(next));
  };
  const toggleTranslation = () => {
    write(TRANSLATION_KEY, translation ? "off" : "on");
    setTranslation(!translation);
  };
  const button = "grid min-h-11 min-w-11 place-items-center rounded-md px-2 text-base";

  return (
    <div className="reader-bar sticky top-0 z-10 -mx-5 flex items-center gap-1 border-b border-line bg-page px-3">
      <button type="button" aria-label={t.smaller} onClick={() => size(-0.1)} className={button}>A−</button>
      <button type="button" aria-label={t.larger} onClick={() => size(0.1)} className={`${button} text-xl`}>A+</button>
      <button type="button" aria-pressed={translation} onClick={toggleTranslation} className={`${button} ms-auto ${translation ? "text-emerald" : "text-muted"}`}>{t.translation}</button>
      <button type="button" aria-pressed={focus} onClick={() => setFocus(!focus)} className={`${button} ${focus ? "text-emerald" : ""}`}>{focus ? t.exitFocus : t.focus}</button>
    </div>
  );
}

export function BookmarkButton({ ayahId, initial, t }: { ayahId: number; initial: boolean; t: T }) {
  const [saved, setSaved] = useState(initial);
  const [pending, start] = useTransition();
  return (
    <button
      type="button"
      disabled={pending}
      aria-pressed={saved}
      aria-label={saved ? t.removeBookmark : t.addBookmark}
      onClick={() => start(async () => {
        const result = await toggleBookmark(ayahId);
        if (result !== null) setSaved(result);
      })}
      className={`grid h-11 w-11 place-items-center rounded-md ${saved ? "text-gold-ink" : "text-muted"}`}
    >
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill={saved ? "currentColor" : "none"} stroke="currentColor" strokeWidth="1.6" strokeLinejoin="round">
        <path d="M6 3.5h12V21l-6-4.5L6 21Z" />
      </svg>
    </button>
  );
}

/** Retient le verset visible pour les personnes connectees. */
export function ReadingTracker({ surah }: { surah: number }) {
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  useEffect(() => {
    const observer = new IntersectionObserver((entries) => {
      const visible = entries.filter((e) => e.isIntersecting).sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top)[0];
      if (!visible) return;
      const id = Number((visible.target as HTMLElement).dataset.ayahId);
      if (timer.current) clearTimeout(timer.current);
      timer.current = setTimeout(() => void saveReading(surah, id), 2500);
    }, { rootMargin: "-15% 0px -60% 0px" });
    document.querySelectorAll("[data-ayah-id]").forEach((el) => observer.observe(el));
    return () => {
      observer.disconnect();
      if (timer.current) clearTimeout(timer.current);
    };
  }, [surah]);
  return null;
}
