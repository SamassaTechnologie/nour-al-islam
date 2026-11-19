"use client";

import Link from "next/link";
import { useEffect, useMemo, useRef, useState, useTransition } from "react";
import { rateHifdh } from "@/app/quran-actions";
import type { Dictionary } from "@/lib/dictionaries";

export type HifdhVerse = { id: number; surah: number; number: number; text: string; translation: string | null; surahName: string };
type T = Dictionary["hifdh"];
type Mask = "none" | "half" | "all";

const REPEATS = [1, 3, 5];
const LETTER = /[ء-يٮ-ۓ]/;

/** Regroupe chaque signe de pause avec le mot precedent, sans changer le texte. */
function words(text: string) {
  const groups: string[] = [];
  for (const part of text.split(" ")) {
    if (groups.length && !LETTER.test(part)) groups[groups.length - 1] += ` ${part}`;
    else groups.push(part);
  }
  return groups;
}

export function HifdhTrainer({ verses, start, backHref, t }: { verses: HifdhVerse[]; start: number; backHref: string; t: T }) {
  const [index, setIndex] = useState(start);
  const [mask, setMask] = useState<Mask>("none");
  const [shown, setShown] = useState<Set<number>>(new Set());
  const [repeat, setRepeat] = useState(3);
  const [playing, setPlaying] = useState(false);
  const [audioFailed, setAudioFailed] = useState(false);
  const [saveFailed, setSaveFailed] = useState(false);
  const [meaning, setMeaning] = useState(false);
  const [pending, run] = useTransition();
  const audio = useRef<HTMLAudioElement>(null);
  const plays = useRef(0);
  const recitation = useRef<number | null>(null);
  const verse = verses[index];
  const parts = useMemo(() => (verse ? words(verse.text) : []), [verse]);

  useEffect(() => {
    setMask("none");
    setShown(new Set());
    setMeaning(false);
    setPlaying(false);
    audio.current?.pause();
  }, [index]);

  const hidden = (position: number) => !shown.has(position) && (mask === "all" || (mask === "half" && position % 2 === 1));
  const choose = (value: Mask) => { setMask(value); setShown(new Set()); };

  const loadRecitation = async () => {
    if (recitation.current) return recitation.current;
    const data = (await (await fetch("/api/audio")).json()) as { recitations: { id: number; name: string }[] };
    let saved = 0;
    try { saved = Number(localStorage.getItem("nour_recitation")); } catch { /* reglage facultatif */ }
    recitation.current = data.recitations.some((r) => r.id === saved) ? saved : (data.recitations.find((r) => /afasy/i.test(r.name)) ?? data.recitations[0]).id;
    return recitation.current;
  };

  const listen = async () => {
    const element = audio.current;
    if (!element || !verse) return;
    if (playing) { element.pause(); setPlaying(false); return; }
    try {
      setAudioFailed(false);
      element.muted = false;
      const id = await loadRecitation();
      const res = await fetch(`/api/audio?recitation=${id}&surah=${verse.surah}`);
      if (!res.ok) throw new Error("audio");
      const file = ((await res.json()) as { files: { number: number; url: string }[] }).files.find((item) => item.number === verse.number);
      if (!file) throw new Error("audio");
      plays.current = 1;
      if (element.src !== file.url) element.src = file.url;
      element.currentTime = 0;
      await element.play();
      setPlaying(true);
    } catch {
      setAudioFailed(true);
      setPlaying(false);
    }
  };

  const onEnded = () => {
    const element = audio.current;
    if (element && plays.current < repeat) {
      plays.current += 1;
      element.currentTime = 0;
      void element.play();
    } else setPlaying(false);
  };

  const rate = (known: boolean) => run(async () => {
    const result = await rateHifdh(verse.id, known);
    setSaveFailed(!result);
    if (result) setIndex(index + 1);
  });

  const option = (active: boolean) => `min-h-11 flex-1 rounded-md px-1 text-base ${active ? "bg-emerald font-medium text-on-emerald" : ""}`;

  if (!verse) {
    return (
      <div role="status" className="mt-6 border-s-2 border-gold ps-4">
        <p className="text-xl">{t.finished}</p>
        <Link href={backHref} className="mt-1 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.back}</Link>
      </div>
    );
  }

  return (
    <section className="mt-3" data-hifdh-verse={`${verse.surah}:${verse.number}`}>
      <p className="text-muted">{verse.surahName}, {t.verse} {verse.number} ({index + 1} / {verses.length})</p>
      <p lang="ar" dir="rtl" className="quran-text hifdh-text mt-3">
        {parts.map((part, position) => (
          <span key={position}>
            {position ? " " : ""}
            <span role="button" tabIndex={0} data-word={position} data-hidden={hidden(position) ? "" : undefined} aria-label={hidden(position) ? t.revealWord : undefined} onClick={() => setShown(new Set(shown).add(position))} onKeyDown={(event) => { if (event.key === "Enter") setShown(new Set(shown).add(position)); }} className="hifdh-word">{part}</span>
          </span>
        ))}
      </p>
      {meaning && verse.translation ? <p className="mt-2">{verse.translation}</p> : null}
      <div className="mt-4 flex gap-1 rounded-lg bg-tint p-1" role="group" aria-label={t.maskLabel}>
        <button type="button" aria-pressed={mask === "none"} onClick={() => choose("none")} className={option(mask === "none")}>{t.showAll}</button>
        <button type="button" aria-pressed={mask === "half"} onClick={() => choose("half")} className={option(mask === "half")}>{t.hideHalf}</button>
        <button type="button" aria-pressed={mask === "all"} onClick={() => choose("all")} className={option(mask === "all")}>{t.hideAll}</button>
      </div>
      <audio ref={audio} playsInline onEnded={onEnded} onError={() => { if (audio.current?.getAttribute("src")) { setAudioFailed(true); setPlaying(false); } }} />
      <div className="mt-2 flex items-center gap-2">
        <button type="button" onClick={() => void listen()} className="min-h-11 rounded-lg border border-line px-4 font-medium">{playing ? t.stop : t.listen}</button>
        <div className="flex flex-1 gap-1 rounded-lg bg-tint p-1" role="group" aria-label={t.repeat}>
          {REPEATS.map((n) => <button key={n} type="button" aria-pressed={repeat === n} onClick={() => setRepeat(n)} className={option(repeat === n)}>{n}×</button>)}
        </div>
      </div>
      {audioFailed ? <p role="alert" className="mt-1 text-danger">{t.audioError}</p> : null}
      {verse.translation ? <button type="button" aria-pressed={meaning} onClick={() => setMeaning(!meaning)} className="mt-1 inline-flex min-h-11 items-center text-muted underline underline-offset-4">{meaning ? t.hideMeaning : t.showMeaning}</button> : null}
      {saveFailed ? <p role="alert" className="mt-1 text-danger">{t.saveError}</p> : null}
      <div className="mt-3 grid grid-cols-2 gap-2">
        <button type="button" disabled={pending} onClick={() => rate(false)} className="min-h-12 rounded-lg border border-line font-medium disabled:opacity-50">{t.again}</button>
        <button type="button" disabled={pending} onClick={() => rate(true)} className="min-h-12 rounded-lg bg-emerald font-medium text-on-emerald disabled:opacity-50">{t.known}</button>
      </div>
      <p className="mt-2 text-base text-muted">{t.rule}</p>
    </section>
  );
}
