"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useCallback, useEffect, useRef, useState, type ReactNode } from "react";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["quran"];
type Recitation = { id: number; name: string; style: string | null };
type AudioFile = { number: number; url: string };
type Position = { surah: number; verse: number };

const LAST_PAGE = 604;
const RECITATION_KEY = "nour_recitation";
const SPEED_KEY = "nour_audio_speed";
const AUTO_KEY = "nour_mushaf_auto";
const SPEEDS = [0.75, 1, 1.25, 1.5];
const AUTO = [0, 1, 2, 3];

const stored = (key: string) => {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
};
const store = (key: string, value: string) => {
  try {
    localStorage.setItem(key, value);
  } catch {
    // Reglage conserve seulement pendant la visite.
  }
};
const verseKey = (p: Position) => `${p.surah}:${p.verse}`;
const parseKey = (key: string): Position => {
  const [surah, verse] = key.split(":").map(Number);
  return { surah, verse };
};

export function MushafReader({ t, names, children }: { t: T; names: string[]; children: ReactNode }) {
  const router = useRouter();
  const page = Number(usePathname().split("/").pop()) || 1;
  const audio = useRef<HTMLAudioElement>(null);
  const cache = useRef(new Map<string, AudioFile[]>());
  const playingRef = useRef(false);
  const posRef = useRef<Position | null>(null);
  const turning = useRef(0);
  const touch = useRef<{ x: number; y: number } | null>(null);
  const [recitations, setRecitations] = useState<Recitation[]>([]);
  const [recitation, setRecitation] = useState<number | null>(null);
  const [pos, setPos] = useState<Position | null>(null);
  const [playing, setPlaying] = useState(false);
  const [failed, setFailed] = useState(false);
  const [open, setOpen] = useState(false);
  const [speed, setSpeed] = useState(1);
  const [auto, setAuto] = useState(0);

  const goPage = useCallback((target: number) => {
    if (target >= 1 && target <= LAST_PAGE) router.push(`/coran/mushaf/${target}`);
  }, [router]);

  const highlight = useCallback((position: Position | null) => {
    document.querySelectorAll("[data-current]").forEach((el) => el.removeAttribute("data-current"));
    if (!position) return false;
    const words = document.querySelectorAll(`[data-v="${verseKey(position)}"]`);
    words.forEach((el) => el.setAttribute("data-current", ""));
    return words.length > 0;
  }, []);

  const filesFor = useCallback(async (surah: number) => {
    const key = `${recitation}:${surah}`;
    const known = cache.current.get(key);
    if (known) return known;
    const res = await fetch(`/api/audio?recitation=${recitation}&surah=${surah}`);
    if (!res.ok) throw new Error("audio");
    const files = ((await res.json()) as { files: AudioFile[] }).files;
    cache.current.set(key, files);
    return files;
  }, [recitation]);

  const select = useCallback(async (position: Position, autoplay: boolean) => {
    posRef.current = position;
    setPos(position);
    try {
      const file = (await filesFor(position.surah)).find((item) => item.number === position.verse);
      const element = audio.current;
      if (!file || !element || posRef.current !== position) return;
      if (element.src !== file.url) {
        element.src = file.url;
        element.load();
      }
      element.playbackRate = speed;
      setFailed(false);
      if (autoplay) await element.play();
    } catch {
      setFailed(true);
    }
  }, [filesFor, speed]);

  useEffect(() => {
    setSpeed(SPEEDS.includes(Number(stored(SPEED_KEY))) ? Number(stored(SPEED_KEY)) : 1);
    setAuto(AUTO.includes(Number(stored(AUTO_KEY))) ? Number(stored(AUTO_KEY)) : 0);
    const root = document.documentElement;
    root.setAttribute("data-reading", "");
    fetch("/api/audio")
      .then((res) => (res.ok ? res.json() : Promise.reject(new Error("audio"))))
      .then((data: { recitations: Recitation[] }) => {
        const saved = Number(stored(RECITATION_KEY));
        setRecitations(data.recitations);
        setRecitation(data.recitations.some((r) => r.id === saved) ? saved : (data.recitations.find((r) => /afasy/i.test(r.name)) ?? data.recitations[0]).id);
      })
      .catch(() => setFailed(true));
    return () => root.removeAttribute("data-reading");
  }, []);

  useEffect(() => {
    if (audio.current) audio.current.playbackRate = speed;
  }, [speed]);

  useEffect(() => {
    document.cookie = `nour_mushaf_page=${page}; path=/; max-age=31536000; samesite=lax${location.protocol === "https:" ? "; secure" : ""}`;
    turning.current = 0;
    if (page < LAST_PAGE) router.prefetch(`/coran/mushaf/${page + 1}`);
    if (page > 1) router.prefetch(`/coran/mushaf/${page - 1}`);
    let frame = 0;
    let active = true;
    const prepare = async (article: HTMLElement) => {
      const sample = article.querySelector<HTMLElement>(".mushaf-word")?.textContent ?? undefined;
      await Promise.all([document.fonts.load(`20px "qcf-p${page}"`, sample), document.fonts.load(`20px "qcf-surah-names"`, "001")]).catch(() => undefined);
      if (!active) return;
      article.querySelectorAll<HTMLElement>(".mushaf-line").forEach((line) => {
        const used = Array.from(line.children).reduce((sum, child) => sum + child.getBoundingClientRect().width, 0);
        line.toggleAttribute("data-full", used / parseFloat(getComputedStyle(line).fontSize) > 12.5);
      });
      article.setAttribute("data-ready", "");
    };
    const wait = () => {
      const article = document.querySelector<HTMLElement>(`article[data-page="${page}"]`);
      if (!article) {
        frame = requestAnimationFrame(wait);
        return;
      }
      void prepare(article);
      if (playingRef.current) {
        highlight(posRef.current);
      } else if (!posRef.current || !highlight(posRef.current)) {
        highlight(null);
        if (recitation !== null) void select(parseKey(article.dataset.first ?? "1:1"), false);
      }
    };
    wait();
    return () => {
      active = false;
      cancelAnimationFrame(frame);
    };
  }, [highlight, page, recitation, router, select]);

  useEffect(() => {
    if (!auto || playing || page >= LAST_PAGE) return;
    const timer = setTimeout(() => goPage(page + 1), auto * 60_000);
    return () => clearTimeout(timer);
  }, [auto, goPage, page, playing]);

  const onEnded = async () => {
    const current = posRef.current;
    if (!current) return;
    let next: Position | null = null;
    try {
      const files = await filesFor(current.surah);
      const index = files.findIndex((file) => file.number === current.verse);
      next = files[index + 1] ? { surah: current.surah, verse: files[index + 1].number } : current.surah < 114 ? { surah: current.surah + 1, verse: 1 } : null;
    } catch {
      setFailed(true);
    }
    if (!next) {
      setPlaying(false);
      playingRef.current = false;
      return;
    }
    playingRef.current = true;
    await select(next, true);
    if (!highlight(next) && page < LAST_PAGE && turning.current !== page + 1) {
      turning.current = page + 1;
      goPage(page + 1);
    }
  };

  const toggle = () => {
    const element = audio.current;
    if (!element || !pos) return;
    if (element.paused) {
      playingRef.current = true;
      highlight(pos);
      element.play().catch(() => {
        playingRef.current = false;
        setFailed(true);
      });
    } else {
      playingRef.current = false;
      element.pause();
    }
  };

  const onClick = (event: React.MouseEvent) => {
    const word = (event.target as HTMLElement).closest<HTMLElement>("[data-v]");
    if (!word?.dataset.v) return;
    const position = parseKey(word.dataset.v);
    highlight(position);
    void select(position, playingRef.current);
  };

  const onTouchEnd = (event: React.TouchEvent) => {
    const start = touch.current;
    const end = event.changedTouches[0];
    touch.current = null;
    if (!start || !end) return;
    const dx = end.clientX - start.x;
    if (Math.abs(dx) > 60 && Math.abs(end.clientY - start.y) < 50) goPage(page + (dx > 0 ? 1 : -1));
  };

  const reciter = recitations.find((r) => r.id === recitation);
  const control = "grid h-11 min-w-11 place-items-center rounded-md disabled:opacity-40";
  const choice = (active: boolean) => `min-h-11 flex-1 rounded-md text-base ${active ? "bg-emerald font-medium text-on-emerald" : ""}`;
  const arrow = "M15 5 8 12l7 7";

  return (
    <main className="mx-auto max-w-xl px-3 pt-1 pb-16">
      <div className="flex min-h-11 items-center justify-between text-base">
        <Link href="/coran" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.allSurahs}</Link>
        {pos ? <span className="text-muted">{names[pos.surah - 1]}</span> : null}
      </div>
      <div onClick={onClick} onTouchStart={(event) => { const p = event.touches[0]; touch.current = { x: p.clientX, y: p.clientY }; }} onTouchEnd={onTouchEnd}>{children}</div>
      <p className="py-1 text-center text-base text-muted">{t.mushafPage} <span data-page-number>{page}</span></p>
      <section aria-label={t.audioPlayer} className="audio-bar fixed inset-x-0 z-20 border-t border-line bg-page">
        <audio ref={audio} preload="auto" playsInline onPlay={() => { playingRef.current = true; setPlaying(true); }} onPause={() => { if (!audio.current?.ended) playingRef.current = false; setPlaying(false); }} onEnded={() => void onEnded()} onError={() => { if (audio.current?.getAttribute("src")) setFailed(true); }} onCanPlay={() => setFailed(false)} />
        <div className="mx-auto max-w-xl px-3">
          {open ? (
            <div className="space-y-3 border-b border-line py-3">
              <label className="block text-base font-medium">
                {t.reciter}
                <select value={recitation ?? ""} onChange={(event) => { const id = Number(event.target.value); store(RECITATION_KEY, String(id)); setRecitation(id); }} className="mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-2 font-normal">
                  {recitations.map((r) => <option key={r.id} value={r.id}>{r.style ? `${r.name} (${r.style})` : r.name}</option>)}
                </select>
              </label>
              <fieldset>
                <legend className="text-base font-medium">{t.speed}</legend>
                <div dir="ltr" className="mt-1 flex gap-1 rounded-lg bg-tint p-1">
                  {SPEEDS.map((n) => <button key={n} type="button" aria-pressed={speed === n} onClick={() => { store(SPEED_KEY, String(n)); setSpeed(n); }} className={choice(speed === n)}>{n}×</button>)}
                </div>
              </fieldset>
              <fieldset>
                <legend className="text-base font-medium">{t.autoTurn}</legend>
                <div className="mt-1 flex gap-1 rounded-lg bg-tint p-1">
                  {AUTO.map((n) => <button key={n} type="button" aria-pressed={auto === n} onClick={() => { store(AUTO_KEY, String(n)); setAuto(n); }} className={choice(auto === n)}>{n ? `${n} ${t.minutes}` : t.autoOff}</button>)}
                </div>
              </fieldset>
              <p className="text-sm text-muted">{t.mushafCredit} {t.audioCredit}</p>
            </div>
          ) : null}
          <div className="flex h-14 items-center gap-1">
            <button type="button" aria-label={t.nextPage} disabled={page >= LAST_PAGE} onClick={() => goPage(page + 1)} className={control}><svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rtl:rotate-180" fill="none" stroke="currentColor" strokeWidth="2"><path d={arrow} /></svg></button>
            <button type="button" aria-label={playing ? t.pause : t.play} disabled={!pos || !recitation} onClick={toggle} className="grid h-11 w-11 place-items-center rounded-full bg-emerald text-on-emerald disabled:opacity-40">
              <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor">{playing ? <path d="M6 5h4v14H6zM14 5h4v14h-4z" /> : <path d="M8 5v14l11-7z" />}</svg>
            </button>
            <button type="button" aria-label={t.previousPage} disabled={page <= 1} onClick={() => goPage(page - 1)} className={control}><svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 rotate-180 rtl:rotate-0" fill="none" stroke="currentColor" strokeWidth="2"><path d={arrow} /></svg></button>
            <p role="status" className="min-w-0 flex-1 truncate px-1 text-base">{failed ? t.audioError : pos ? <><span className="font-medium">{pos.surah}:{pos.verse}</span> <span className="text-muted">{reciter?.name}</span></> : t.audioLoading}</p>
            <button type="button" aria-expanded={open} aria-label={t.audioSettings} onClick={() => setOpen(!open)} className={control}><svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round"><path d="M4 7h10M18 7h2M4 17h2M10 17h10" /><circle cx="16" cy="7" r="2" /><circle cx="8" cy="17" r="2" /></svg></button>
          </div>
        </div>
      </section>
    </main>
  );
}
