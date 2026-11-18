"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["quran"];
type Recitation = { id: number; name: string; style: string | null };
type AudioFile = { number: number; url: string };

const RECITATION_KEY = "nour_recitation";
const SPEED_KEY = "nour_audio_speed";
const REPEATS = [1, 3, 5, 10];
const SPEEDS = [0.75, 1, 1.25, 1.5];

function stored(key: string) {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
}

function store(key: string, value: string) {
  try {
    localStorage.setItem(key, value);
  } catch {
    // Reglage conserve seulement pendant la visite.
  }
}

const label = (r: Recitation) => (r.style ? `${r.name} (${r.style})` : r.name);

export function AudioPlayer({ surah, surahName, t }: { surah: number; surahName: string; t: T }) {
  const audio = useRef<HTMLAudioElement>(null);
  const plays = useRef(1);
  const shouldPlay = useRef(false);
  const [recitations, setRecitations] = useState<Recitation[]>([]);
  const [recitation, setRecitation] = useState<number | null>(null);
  const [files, setFiles] = useState<AudioFile[]>([]);
  const [index, setIndex] = useState(0);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(true);
  const [failed, setFailed] = useState(false);
  const [open, setOpen] = useState(false);
  const [repeat, setRepeat] = useState(1);
  const [loop, setLoop] = useState(false);
  const [speed, setSpeed] = useState(1);

  useEffect(() => {
    let active = true;
    const savedSpeed = Number(stored(SPEED_KEY));
    if (SPEEDS.includes(savedSpeed)) setSpeed(savedSpeed);
    fetch("/api/audio")
      .then((res) => (res.ok ? res.json() : Promise.reject(new Error("audio"))))
      .then((data: { recitations: Recitation[] }) => {
        if (!active) return;
        const saved = Number(stored(RECITATION_KEY));
        const fallback = data.recitations.find((r) => /afasy/i.test(r.name)) ?? data.recitations[0];
        setRecitations(data.recitations);
        setRecitation(data.recitations.some((r) => r.id === saved) ? saved : fallback.id);
      })
      .catch(() => active && (setFailed(true), setLoading(false)));
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    if (recitation === null) return;
    let active = true;
    setLoading(true);
    setFailed(false);
    fetch(`/api/audio?recitation=${recitation}&surah=${surah}`)
      .then((res) => (res.ok ? res.json() : Promise.reject(new Error("audio"))))
      .then((data: { files: AudioFile[] }) => {
        if (!active) return;
        setFiles(data.files);
        setLoading(false);
      })
      .catch(() => active && (setFailed(true), setLoading(false)));
    return () => {
      active = false;
    };
  }, [recitation, surah]);

  const current = files[index];
  const reciter = recitations.find((r) => r.id === recitation);

  const go = useCallback((next: number, autoplay = true) => {
    plays.current = 1;
    shouldPlay.current = autoplay;
    setIndex(next);
  }, []);

  const start = useCallback(() => {
    const element = audio.current;
    if (!element) return;
    element.play().catch(() => setPlaying(false));
  }, []);

  useEffect(() => {
    const element = audio.current;
    if (!element || !current) return;
    if (element.src !== current.url) {
      element.src = current.url;
      element.load();
    }
    element.playbackRate = speed;
    if (shouldPlay.current) start();
    document.querySelectorAll("[data-playing]").forEach((el) => el.removeAttribute("data-playing"));
    const verse = document.getElementById(`v${surah}-${current.number}`);
    verse?.setAttribute("data-playing", "");
    if (shouldPlay.current) verse?.scrollIntoView({ behavior: "smooth", block: "center" });
    const following = files[index + 1];
    if (following) new Audio().src = following.url;
  }, [current, files, index, speed, start, surah]);

  useEffect(() => () => document.querySelectorAll("[data-playing]").forEach((el) => el.removeAttribute("data-playing")), []);

  const onEnded = () => {
    if (plays.current < repeat) {
      plays.current += 1;
      const element = audio.current;
      if (element) element.currentTime = 0;
      start();
    } else if (index + 1 < files.length) {
      go(index + 1);
    } else if (loop) {
      go(0);
    } else {
      shouldPlay.current = false;
      setPlaying(false);
    }
  };

  const toggle = useCallback(() => {
    const element = audio.current;
    if (!element || !current) return;
    if (element.paused) {
      shouldPlay.current = true;
      start();
    } else {
      shouldPlay.current = false;
      element.pause();
    }
  }, [current, start]);

  useEffect(() => {
    const onClick = (event: MouseEvent) => {
      const button = (event.target as HTMLElement).closest<HTMLElement>("[data-play-verse]");
      if (!button) return;
      const position = files.findIndex((file) => file.number === Number(button.dataset.playVerse));
      if (position < 0) return;
      if (position === index) {
        shouldPlay.current = true;
        start();
      } else {
        go(position);
      }
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, [files, go, index, start]);

  useEffect(() => {
    if (!("mediaSession" in navigator) || !current) return;
    navigator.mediaSession.metadata = new MediaMetadata({ title: `${surahName} ${surah}:${current.number}`, artist: reciter?.name ?? "", album: "NOUR AL-ISLAM" });
    navigator.mediaSession.setActionHandler("play", () => { shouldPlay.current = true; start(); });
    navigator.mediaSession.setActionHandler("pause", () => { shouldPlay.current = false; audio.current?.pause(); });
    navigator.mediaSession.setActionHandler("previoustrack", index > 0 ? () => go(index - 1) : null);
    navigator.mediaSession.setActionHandler("nexttrack", index + 1 < files.length ? () => go(index + 1) : null);
  }, [current, files.length, go, index, reciter, start, surah, surahName]);

  const control = "grid h-11 min-w-11 place-items-center rounded-md disabled:opacity-40";
  const choice = (active: boolean) => `min-h-11 flex-1 rounded-md text-base ${active ? "bg-emerald font-medium text-on-emerald" : ""}`;

  return (
    <section aria-label={t.audioPlayer} className="audio-bar fixed inset-x-0 z-20 border-t border-line bg-page">
      <audio
        ref={audio}
        preload="auto"
        playsInline
        onPlay={() => setPlaying(true)}
        onPause={() => setPlaying(false)}
        onEnded={onEnded}
        onError={() => { if (current) { setFailed(true); setPlaying(false); } }}
        onCanPlay={() => setFailed(false)}
      />
      <div className="mx-auto max-w-xl px-3">
        {open ? (
          <div className="space-y-3 border-b border-line py-3">
            <label className="block text-base font-medium">
              {t.reciter}
              <select
                value={recitation ?? ""}
                onChange={(event) => {
                  const id = Number(event.target.value);
                  store(RECITATION_KEY, String(id));
                  shouldPlay.current = playing;
                  setRecitation(id);
                }}
                className="mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-2 font-normal"
              >
                {recitations.map((r) => <option key={r.id} value={r.id}>{label(r)}</option>)}
              </select>
            </label>
            <fieldset>
              <legend className="text-base font-medium">{t.repeatVerse}</legend>
              <div className="mt-1 flex gap-1 rounded-lg bg-tint p-1">
                {REPEATS.map((n) => <button key={n} type="button" aria-pressed={repeat === n} onClick={() => { plays.current = 1; setRepeat(n); }} className={choice(repeat === n)}>{n}×</button>)}
              </div>
            </fieldset>
            <fieldset>
              <legend className="text-base font-medium">{t.speed}</legend>
              <div dir="ltr" className="mt-1 flex gap-1 rounded-lg bg-tint p-1">
                {SPEEDS.map((n) => <button key={n} type="button" aria-pressed={speed === n} onClick={() => { store(SPEED_KEY, String(n)); setSpeed(n); }} className={choice(speed === n)}>{n}×</button>)}
              </div>
            </fieldset>
            <button type="button" aria-pressed={loop} onClick={() => setLoop(!loop)} className={`min-h-11 w-full rounded-lg border border-line text-base ${loop ? "border-emerald font-medium text-emerald" : ""}`}>{t.repeatSurah}</button>
            <p className="text-sm text-muted">{t.audioCredit}</p>
          </div>
        ) : null}
        <div className="flex h-14 items-center gap-1">
          <button type="button" aria-label={t.previousVerse} disabled={!current || index === 0} onClick={() => go(index - 1, playing)} className={control}>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rtl:rotate-180" fill="currentColor"><path d="M6 5h2v14H6zM20 5v14L9 12z" /></svg>
          </button>
          <button type="button" aria-label={playing ? t.pause : t.play} disabled={!current || loading} onClick={toggle} className="grid h-11 w-11 place-items-center rounded-full bg-emerald text-on-emerald disabled:opacity-40">
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor">{playing ? <path d="M6 5h4v14H6zM14 5h4v14h-4z" /> : <path d="M8 5v14l11-7z" />}</svg>
          </button>
          <button type="button" aria-label={t.nextVerse} disabled={!current || index + 1 >= files.length} onClick={() => go(index + 1, playing)} className={control}>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rtl:rotate-180" fill="currentColor"><path d="M16 5h2v14h-2zM4 5v14l11-7z" /></svg>
          </button>
          <p role="status" className="min-w-0 flex-1 truncate px-1 text-base">
            {failed ? t.audioError : loading ? t.audioLoading : current ? <><span className="font-medium">{surah}:{current.number}</span> <span className="text-muted">{reciter?.name}</span></> : null}
          </p>
          <button type="button" aria-expanded={open} aria-label={t.audioSettings} disabled={!recitations.length} onClick={() => setOpen(!open)} className={control}>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round"><path d="M4 7h10M18 7h2M4 17h2M10 17h10" /><circle cx="16" cy="7" r="2" /><circle cx="8" cy="17" r="2" /></svg>
          </button>
        </div>
      </div>
    </section>
  );
}
