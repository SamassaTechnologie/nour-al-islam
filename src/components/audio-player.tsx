"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import {
  type ChapterAudio,
  type ChapterReciter,
  RECITER_KEY,
  defaultReciter,
  downloadChapter,
  fetchChapter,
  fetchReciters,
  findDownload,
  listDownloads,
  reciterLabel,
  removeDownload,
  store,
  stored,
  syncDownloads,
  verseAt,
} from "@/lib/chapter-audio";

type T = Dictionary["quran"];

const SPEED_KEY = "nour_audio_speed";
const REPEATS = [1, 3, 5, 10];
const SPEEDS = [0.75, 1, 1.25, 1.5];

// Un seul fichier par sourate : le telephone garde la lecture ecran eteint ou application en arriere-plan.
export function AudioPlayer({ surah, surahName, t }: { surah: number; surahName: string; t: T }) {
  const audio = useRef<HTMLAudioElement>(null);
  const plays = useRef(1);
  const verseRef = useRef(1);
  const pendingSeek = useRef<number | null>(null);
  const [reciters, setReciters] = useState<ChapterReciter[]>([]);
  const [reciter, setReciter] = useState<number | null>(null);
  const [chapter, setChapter] = useState<ChapterAudio | null>(null);
  const [verse, setVerse] = useState(1);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(true);
  const [failed, setFailed] = useState(false);
  const [open, setOpen] = useState(false);
  const [repeat, setRepeat] = useState(1);
  const [loop, setLoop] = useState(false);
  const [speed, setSpeed] = useState(1);
  const [progress, setProgress] = useState(0);
  const [saved, setSaved] = useState(false);
  const [saving, setSaving] = useState<number | null>(null);
  const [saveFailed, setSaveFailed] = useState(false);

  const timings = chapter?.timings ?? [];
  const current = reciters.find((r) => r.id === reciter);
  const verseIndex = timings.findIndex((x) => x.number === verse);

  useEffect(() => {
    let active = true;
    const savedSpeed = Number(stored(SPEED_KEY));
    if (SPEEDS.includes(savedSpeed)) setSpeed(savedSpeed);
    fetchReciters()
      .then((list) => {
        if (!active) return;
        setReciters(list);
        setReciter(defaultReciter(list));
      })
      .catch(() => {
        // Hors connexion : on prend le recitant de la sourate telechargee, s'il y en a une.
        if (!active) return;
        const id = Number(stored(RECITER_KEY));
        const here = listDownloads().filter((d) => d.surah === surah);
        const item = here.find((d) => d.reciter === id) ?? here[0] ?? null;
        if (item) {
          setReciters([{ id: item.reciter, name: item.reciterName, style: null }]);
          setReciter(item.reciter);
        } else {
          setFailed(true);
          setLoading(false);
        }
      });
    void syncDownloads();
    return () => {
      active = false;
    };
  }, [surah]);

  useEffect(() => {
    if (reciter === null) return;
    let active = true;
    setLoading(true);
    setFailed(false);
    setSaved(Boolean(findDownload(reciter, surah)));
    fetchChapter(reciter, surah)
      .then((data) => {
        if (!active) return;
        setChapter(data);
        setLoading(false);
      })
      .catch(() => active && (setFailed(true), setLoading(false)));
    const onChange = () => setSaved(Boolean(findDownload(reciter, surah)));
    window.addEventListener("nour-downloads", onChange);
    return () => {
      active = false;
      window.removeEventListener("nour-downloads", onChange);
    };
  }, [reciter, surah]);

  // Nouveau fichier : on garde la position (changement de recitant pendant l'ecoute).
  useEffect(() => {
    const element = audio.current;
    if (!element || !chapter) return;
    const wasPlaying = !element.paused;
    if (element.src !== chapter.url) {
      const target = chapter.timings.find((x) => x.number === verseRef.current);
      pendingSeek.current = target ? target.from / 1000 : 0;
      element.src = chapter.url;
      element.load();
      if (wasPlaying) element.play().catch(() => setPlaying(false));
    }
  }, [chapter]);

  useEffect(() => {
    if (audio.current) audio.current.playbackRate = speed;
  }, [speed]);

  const highlight = useCallback((number: number, scroll: boolean) => {
    document.querySelectorAll("[data-playing]").forEach((el) => el.removeAttribute("data-playing"));
    const el = document.getElementById(`v${surah}-${number}`);
    el?.setAttribute("data-playing", "");
    if (scroll && el && document.visibilityState === "visible") el.scrollIntoView({ behavior: "smooth", block: "center" });
  }, [surah]);

  useEffect(() => () => document.querySelectorAll("[data-playing]").forEach((el) => el.removeAttribute("data-playing")), []);

  const play = useCallback(() => {
    audio.current?.play().catch(() => setPlaying(false));
  }, []);

  const seekTo = useCallback((number: number, autoplay: boolean) => {
    const element = audio.current;
    const target = timings.find((x) => x.number === number);
    if (!element || !target) return;
    plays.current = 1;
    verseRef.current = number;
    setVerse(number);
    highlight(number, true);
    if (element.readyState >= 1) element.currentTime = target.from / 1000;
    else pendingSeek.current = target.from / 1000;
    if (autoplay) play();
  }, [highlight, play, timings]);

  const updatePosition = useCallback(() => {
    const element = audio.current;
    if (!element || !("mediaSession" in navigator) || !Number.isFinite(element.duration) || element.duration <= 0) return;
    try {
      navigator.mediaSession.setPositionState({ duration: element.duration, playbackRate: element.playbackRate, position: Math.min(element.currentTime, element.duration) });
    } catch {
      // Etat non accepte par ce navigateur.
    }
  }, []);

  const onTime = () => {
    const element = audio.current;
    if (!element || !timings.length) return;
    const ms = element.currentTime * 1000;
    if (element.duration) setProgress(element.currentTime / element.duration);
    const active = timings.find((x) => x.number === verseRef.current);
    // Repetition du verset : retour au debut du verset tant que le nombre n'est pas atteint.
    if (active && repeat > 1 && ms >= active.to - 120 && plays.current < repeat) {
      plays.current += 1;
      element.currentTime = active.from / 1000;
      return;
    }
    const at = verseAt(timings, ms);
    if (at && at.number !== verseRef.current) {
      plays.current = 1;
      verseRef.current = at.number;
      setVerse(at.number);
      highlight(at.number, !element.paused);
    }
  };

  const onEnded = () => {
    const element = audio.current;
    if (!element) return;
    const last = timings.at(-1);
    if (last && repeat > 1 && plays.current < repeat) {
      plays.current += 1;
      element.currentTime = last.from / 1000;
      play();
    } else if (loop) {
      seekTo(timings[0]?.number ?? 1, true);
    } else {
      setPlaying(false);
    }
  };

  const toggle = useCallback(() => {
    const element = audio.current;
    if (!element || !chapter) return;
    if (element.paused) {
      highlight(verseRef.current, true);
      play();
    } else {
      element.pause();
    }
  }, [chapter, highlight, play]);

  useEffect(() => {
    const onClick = (event: MouseEvent) => {
      const button = (event.target as HTMLElement).closest<HTMLElement>("[data-play-verse]");
      if (!button) return;
      const number = Number(button.dataset.playVerse);
      const element = audio.current;
      if (number === verseRef.current && element && element.currentTime > 0) {
        highlight(number, false);
        play();
      } else {
        seekTo(number, true);
      }
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, [highlight, play, seekTo]);

  useEffect(() => {
    if (!("mediaSession" in navigator) || !chapter) return;
    navigator.mediaSession.metadata = new MediaMetadata({
      title: `${surahName} · ${surah}:${verse}`,
      artist: current?.name ?? "",
      album: "NOUR AL-ISLAM",
      artwork: [{ src: "/icons/icon-192.png", sizes: "192x192", type: "image/png" }, { src: "/icons/icon-512.png", sizes: "512x512", type: "image/png" }],
    });
  }, [chapter, current, surah, surahName, verse]);

  useEffect(() => {
    if (!("mediaSession" in navigator) || !chapter) return;
    const session = navigator.mediaSession;
    const index = timings.findIndex((x) => x.number === verse);
    session.setActionHandler("play", () => play());
    session.setActionHandler("pause", () => audio.current?.pause());
    session.setActionHandler("previoustrack", index > 0 ? () => seekTo(timings[index - 1].number, true) : null);
    session.setActionHandler("nexttrack", index >= 0 && index + 1 < timings.length ? () => seekTo(timings[index + 1].number, true) : null);
    try {
      session.setActionHandler("seekto", (details) => {
        if (audio.current && details.seekTime !== undefined) audio.current.currentTime = details.seekTime;
        updatePosition();
      });
    } catch {
      // Action non prise en charge.
    }
  }, [chapter, play, seekTo, timings, updatePosition, verse]);

  const download = async () => {
    if (!current || saving !== null) return;
    setSaveFailed(false);
    setSaving(0);
    try {
      await downloadChapter(current.id, current.name, surah, (ratio) => setSaving(Math.round(ratio * 100)));
      setSaved(true);
    } catch {
      setSaveFailed(true);
      await removeDownload(current.id, surah).catch(() => undefined);
    } finally {
      setSaving(null);
    }
  };

  const control = "grid h-11 min-w-11 place-items-center rounded-md disabled:opacity-40";
  const choice = (active: boolean) => `min-h-11 flex-1 rounded-md text-base ${active ? "bg-emerald font-medium text-on-emerald" : ""}`;
  const canDownload = typeof window !== "undefined" && "caches" in window;

  return (
    <section aria-label={t.audioPlayer} className="audio-bar fixed inset-x-0 z-20 border-t border-line bg-page" data-audio-mode="chapter">
      <audio
        ref={audio}
        preload="metadata"
        playsInline
        onLoadedMetadata={() => {
          const element = audio.current;
          if (element && pendingSeek.current !== null) {
            element.currentTime = pendingSeek.current;
            pendingSeek.current = null;
          }
          if (element) element.playbackRate = speed;
          updatePosition();
        }}
        onPlay={() => { setPlaying(true); highlight(verseRef.current, false); updatePosition(); }}
        onPause={() => { setPlaying(false); updatePosition(); }}
        onSeeked={updatePosition}
        onRateChange={updatePosition}
        onTimeUpdate={onTime}
        onEnded={onEnded}
        onError={() => { if (chapter) { setFailed(true); setPlaying(false); } }}
        onCanPlay={() => setFailed(false)}
      />
      <div aria-hidden="true" className="h-0.5 bg-line">
        <div className="h-full bg-emerald" style={{ width: `${(progress * 100).toFixed(2)}%` }} />
      </div>
      <div className="mx-auto max-w-xl px-3">
        {open ? (
          <div className="max-h-[60dvh] space-y-3 overflow-y-auto border-b border-line py-3">
            <label className="block text-base font-medium">
              {t.reciter}
              <select
                value={reciter ?? ""}
                onChange={(event) => {
                  const id = Number(event.target.value);
                  store(RECITER_KEY, String(id));
                  setReciter(id);
                }}
                className="mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-2 font-normal"
              >
                {reciters.map((r) => <option key={r.id} value={r.id}>{reciterLabel(r)}</option>)}
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
            {canDownload && current ? (
              <div className="rounded-lg border border-line p-3" data-download={saved ? "saved" : saving !== null ? "saving" : "none"}>
                {saved ? (
                  <div className="flex items-center gap-2">
                    <p className="flex-1 text-base font-medium text-emerald">{t.downloaded}</p>
                    <button type="button" onClick={() => void removeDownload(current.id, surah).then(() => setSaved(false))} className="min-h-11 rounded-md px-2 text-base underline underline-offset-4">{t.removeDownload}</button>
                  </div>
                ) : (
                  <button type="button" disabled={saving !== null || !chapter} onClick={() => void download()} className="min-h-11 w-full rounded-lg bg-emerald px-3 font-medium text-on-emerald disabled:opacity-60" data-download-button>
                    {saving !== null ? t.downloading.replace("{p}", String(saving)) : t.download}
                  </button>
                )}
                {saveFailed ? <p role="alert" className="mt-2 text-base text-danger">{t.downloadError}</p> : null}
                <p className="mt-2 text-sm text-muted">{t.downloadNote}</p>
              </div>
            ) : null}
            <p className="text-sm text-muted">{t.audioCredit} {current ? t.reciterBy.replace("{name}", current.name) : null}</p>
          </div>
        ) : null}
        <div className="flex h-14 items-center gap-1">
          <button type="button" aria-label={t.previousVerse} disabled={!chapter || verseIndex <= 0} onClick={() => seekTo(timings[verseIndex - 1].number, playing)} className={control}>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rtl:rotate-180" fill="currentColor"><path d="M6 5h2v14H6zM20 5v14L9 12z" /></svg>
          </button>
          <button type="button" aria-label={playing ? t.pause : t.play} disabled={!chapter || loading} onClick={toggle} className="grid h-11 w-11 place-items-center rounded-full bg-emerald text-on-emerald disabled:opacity-40" data-audio-toggle>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor">{playing ? <path d="M6 5h4v14H6zM14 5h4v14h-4z" /> : <path d="M8 5v14l11-7z" />}</svg>
          </button>
          <button type="button" aria-label={t.nextVerse} disabled={!chapter || verseIndex < 0 || verseIndex + 1 >= timings.length} onClick={() => seekTo(timings[verseIndex + 1].number, playing)} className={control}>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rtl:rotate-180" fill="currentColor"><path d="M16 5h2v14h-2zM4 5v14l11-7z" /></svg>
          </button>
          <p role="status" className="min-w-0 flex-1 truncate px-1 text-base" data-audio-status>
            {failed ? t.audioError : loading ? t.audioLoading : chapter ? <><span className="font-medium" data-audio-verse>{surah}:{verse}</span> <span className="text-muted">{current?.name}</span>{saved ? <span className="sr-only"> · {t.downloaded}</span> : null}</> : null}
          </p>
          {saved ? <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-emerald"><path d="M12 4v11m0 0-4-4m4 4 4-4M5 20h14" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg> : null}
          <button type="button" aria-expanded={open} aria-label={t.audioSettings} disabled={!reciters.length} onClick={() => setOpen(!open)} className={control} data-audio-settings>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round"><path d="M4 7h10M18 7h2M4 17h2M10 17h10" /><circle cx="16" cy="7" r="2" /><circle cx="8" cy="17" r="2" /></svg>
          </button>
        </div>
      </div>
    </section>
  );
}
