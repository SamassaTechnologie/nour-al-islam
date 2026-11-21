"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useCallback, useEffect, useRef, useState, type ReactNode } from "react";
import type { Dictionary } from "@/lib/dictionaries";
import { type ChapterAudio, type ChapterReciter, RECITER_KEY, defaultReciter, fetchChapter, fetchReciters, reciterLabel, store, stored, verseAt } from "@/lib/chapter-audio";
import { useWakeLock } from "@/lib/use-wake-lock";
import { MUSHAF_LAST_KEY } from "@/lib/khatm";

type T = Dictionary["quran"];
type Position = { surah: number; verse: number };

const LAST_PAGE = 604;
const SPEED_KEY = "nour_audio_speed";
const AUTO_KEY = "nour_mushaf_auto";
const ZOOM_KEY = "nour_mushaf_zoom";
const ZOOMS = [0.7, 0.8, 0.9, 1, 1.15, 1.3, 1.45, 1.6];
const SPEEDS = [0.75, 1, 1.25, 1.5];
const AUTO = [0, 1, 2, 3];

const verseKey = (p: Position) => `${p.surah}:${p.verse}`;
const parseKey = (key: string): Position => {
  const [surah, verse] = key.split(":").map(Number);
  return { surah, verse };
};

export function MushafReader({ t, names, children }: { t: T; names: string[]; children: ReactNode }) {
  const router = useRouter();
  const page = Number(usePathname().split("/").pop()) || 1;
  const audio = useRef<HTMLAudioElement>(null);
  const cache = useRef(new Map<string, ChapterAudio>());
  const loaded = useRef<{ surah: number; chapter: ChapterAudio } | null>(null);
  const pendingSeek = useRef<number | null>(null);
  const playingRef = useRef(false);
  const posRef = useRef<Position | null>(null);
  const turning = useRef(0);
  const touch = useRef<{ x: number; y: number } | null>(null);
  const [recitations, setRecitations] = useState<ChapterReciter[]>([]);
  const [recitation, setRecitation] = useState<number | null>(null);
  const [pos, setPos] = useState<Position | null>(null);
  const [playing, setPlaying] = useState(false);
  const [failed, setFailed] = useState(false);
  const [open, setOpen] = useState(false);
  const [speed, setSpeed] = useState(1);
  const [auto, setAuto] = useState(0);
  const [zoom, setZoom] = useState(1);
  const [landscape, setLandscape] = useState(false);

  // Telephone a l'horizontale (meme seuil que la feuille de style) : la taille de l'ecriture se regle.
  useEffect(() => {
    const query = window.matchMedia("(max-height: 520px)");
    const update = () => setLandscape(query.matches);
    update();
    query.addEventListener("change", update);
    return () => query.removeEventListener("change", update);
  }, []);

  const changeZoom = (step: number) => {
    const next = ZOOMS[Math.min(ZOOMS.length - 1, Math.max(0, ZOOMS.indexOf(zoom) + step))];
    store(ZOOM_KEY, String(next));
    setZoom(next);
  };

  // Derniere page ouverte : le plan de lecture propose de la compter comme lue.
  useEffect(() => store(MUSHAF_LAST_KEY, String(page)), [page]);

  // Ecran allume pendant la recitation ou quand les pages tournent seules.
  useWakeLock(playing || auto > 0);

  const goPage = useCallback((target: number) => {
    if (target >= 1 && target <= LAST_PAGE) router.push(`/coran/mushaf/${target}`);
  }, [router]);

  const highlight = useCallback((position: Position | null) => {
    document.querySelectorAll("[data-current]").forEach((el) => el.removeAttribute("data-current"));
    if (!position) return false;
    const words = document.querySelectorAll(`[data-v="${verseKey(position)}"]`);
    words.forEach((el) => el.setAttribute("data-current", ""));
    const screen = document.querySelector<HTMLElement>(".mushaf-screen");
    if (playingRef.current && words[0] && screen && screen.scrollHeight > screen.clientHeight) words[0].scrollIntoView({ behavior: "smooth", block: "center" });
    return words.length > 0;
  }, []);

  const chapterFor = useCallback(async (surah: number) => {
    if (recitation === null) throw new Error("audio");
    const key = `${recitation}:${surah}`;
    const known = cache.current.get(key);
    if (known) return known;
    const chapter = await fetchChapter(recitation, surah);
    cache.current.set(key, chapter);
    return chapter;
  }, [recitation]);

  // Un seul fichier par sourate : la lecture continue ecran eteint et en arriere-plan.
  const select = useCallback(async (position: Position, autoplay: boolean) => {
    posRef.current = position;
    setPos(position);
    try {
      const chapter = await chapterFor(position.surah);
      const element = audio.current;
      const timing = chapter.timings.find((item) => item.number === position.verse);
      if (!element || posRef.current !== position) return;
      const at = (timing?.from ?? 0) / 1000;
      if (element.src !== chapter.url) {
        loaded.current = { surah: position.surah, chapter };
        pendingSeek.current = at;
        element.src = chapter.url;
        element.load();
      } else if (element.readyState >= 1) {
        element.currentTime = at;
      } else {
        pendingSeek.current = at;
      }
      element.playbackRate = speed;
      setFailed(false);
      if (autoplay) await element.play();
    } catch {
      setFailed(true);
    }
  }, [chapterFor, speed]);

  useEffect(() => {
    setSpeed(SPEEDS.includes(Number(stored(SPEED_KEY))) ? Number(stored(SPEED_KEY)) : 1);
    setAuto(AUTO.includes(Number(stored(AUTO_KEY))) ? Number(stored(AUTO_KEY)) : 0);
    setZoom(ZOOMS.includes(Number(stored(ZOOM_KEY))) ? Number(stored(ZOOM_KEY)) : 1);
    const root = document.documentElement;
    root.setAttribute("data-reading", "");
    fetchReciters()
      .then((list) => {
        setRecitations(list);
        setRecitation(defaultReciter(list));
      })
      .catch(() => setFailed(true));
    return () => root.removeAttribute("data-reading");
  }, []);

  useEffect(() => {
    if (audio.current) audio.current.playbackRate = speed;
  }, [speed]);

  // Changement de recitant pendant l'ecoute : on reprend au meme verset avec la nouvelle voix.
  const lastRecitation = useRef<number | null>(null);
  useEffect(() => {
    if (recitation === null) return;
    const changed = lastRecitation.current !== null && lastRecitation.current !== recitation;
    lastRecitation.current = recitation;
    if (changed && playingRef.current && posRef.current) void select(posRef.current, true);
  }, [recitation, select]);

  useEffect(() => {
    document.cookie = `nour_mushaf_page=${page}; path=/; max-age=31536000; samesite=lax${location.protocol === "https:" ? "; secure" : ""}`;
    turning.current = 0;
    document.querySelector(".mushaf-screen")?.scrollTo(0, 0);
    if (page < LAST_PAGE) router.prefetch(`/coran/mushaf/${page + 1}`);
    if (page > 1) router.prefetch(`/coran/mushaf/${page - 1}`);
    let frame = 0;
    let active = true;
    const prepare = async (article: HTMLElement) => {
      const sample = article.querySelector<HTMLElement>(".mushaf-word")?.textContent ?? undefined;
      await Promise.all([document.fonts.load(`20px "qcf-p${page}"`, sample), document.fonts.load(`20px "qcf-surah-names"`, "001")]).catch(() => undefined);
      if (!active) return;
      const lines = Array.from(article.querySelectorAll<HTMLElement>(".mushaf-line"));
      let widest = 0;
      lines.forEach((line) => {
        const used = Array.from(line.children).reduce((sum, child) => sum + child.getBoundingClientRect().width, 0) / parseFloat(getComputedStyle(line).fontSize);
        widest = Math.max(widest, used);
        line.toggleAttribute("data-full", used > 12.5);
      });
      // Largeur de la page : la plus longue ligne, avec une petite marge (au moins 13,6 em pour garder une taille reguliere).
      const opening = lines.length <= 8;
      article.toggleAttribute("data-opening", opening);
      if (widest > 0) article.style.setProperty("--mushaf-em", String(Math.min(15.2, opening ? widest + 0.4 : Math.max(widest + 0.25, 13.6))));
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

  useEffect(() => {
    const onKey = (event: KeyboardEvent) => {
      if ((event.target as HTMLElement).closest("input, select, textarea")) return;
      if (event.key === "ArrowLeft") goPage(page + 1);
      if (event.key === "ArrowRight") goPage(page - 1);
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [goPage, page]);

  const follow = useCallback((next: Position) => {
    if (!highlight(next) && playingRef.current && page < LAST_PAGE && turning.current !== page + 1) {
      turning.current = page + 1;
      goPage(page + 1);
    }
  }, [goPage, highlight, page]);

  // Le verset en cours suit la position dans le fichier de la sourate.
  const onTime = () => {
    const element = audio.current;
    const current = loaded.current;
    if (!element || !current || element.src !== current.chapter.url || pendingSeek.current !== null) return;
    const at = verseAt(current.chapter.timings, element.currentTime * 1000);
    if (!at || (posRef.current?.surah === current.surah && posRef.current.verse === at.number)) return;
    const next = { surah: current.surah, verse: at.number };
    posRef.current = next;
    setPos(next);
    if (!element.paused) follow(next);
  };

  const onEnded = async () => {
    const current = loaded.current;
    if (!current || current.surah >= 114) {
      setPlaying(false);
      playingRef.current = false;
      return;
    }
    const next = { surah: current.surah + 1, verse: 1 };
    playingRef.current = true;
    await select(next, true);
    follow(next);
  };

  useEffect(() => {
    if (!("mediaSession" in navigator) || !pos) return;
    const reciterName = recitations.find((r) => r.id === recitation)?.name ?? "";
    navigator.mediaSession.metadata = new MediaMetadata({
      title: `${names[pos.surah - 1] ?? ""} · ${pos.surah}:${pos.verse}`,
      artist: reciterName,
      album: "NOUR AL-ISLAM",
      artwork: [{ src: "/icons/icon-192.png", sizes: "192x192", type: "image/png" }, { src: "/icons/icon-512.png", sizes: "512x512", type: "image/png" }],
    });
    const timings = loaded.current?.surah === pos.surah ? loaded.current.chapter.timings : [];
    const index = timings.findIndex((item) => item.number === pos.verse);
    const session = navigator.mediaSession;
    session.setActionHandler("play", () => { playingRef.current = true; void audio.current?.play(); });
    session.setActionHandler("pause", () => { playingRef.current = false; audio.current?.pause(); });
    session.setActionHandler("previoustrack", index > 0 ? () => void select({ surah: pos.surah, verse: timings[index - 1].number }, true) : null);
    session.setActionHandler("nexttrack", index >= 0 && index + 1 < timings.length ? () => void select({ surah: pos.surah, verse: timings[index + 1].number }, true) : null);
  }, [names, pos, recitation, recitations, select]);

  const positionState = () => {
    const element = audio.current;
    if (!element || !("mediaSession" in navigator) || !Number.isFinite(element.duration) || element.duration <= 0) return;
    try {
      navigator.mediaSession.setPositionState({ duration: element.duration, playbackRate: element.playbackRate, position: Math.min(element.currentTime, element.duration) });
    } catch {
      // Etat non accepte par ce navigateur.
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
    <main className="mushaf-screen" style={{ "--mushaf-zoom": zoom } as React.CSSProperties}>
      <div className="mx-auto flex min-h-11 w-full max-w-xl shrink-0 items-center justify-between px-3 text-base">
        <Link href="/coran" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.allSurahs}</Link>
        {pos ? <span className="text-muted">{names[pos.surah - 1]}</span> : null}
      </div>
      <div className="mushaf-stage" onClick={onClick} onTouchStart={(event) => { const p = event.touches[0]; touch.current = { x: p.clientX, y: p.clientY }; }} onTouchEnd={onTouchEnd}>{children}</div>
      <p className="shrink-0 py-1 text-center text-base text-muted">{t.mushafPage} <span data-page-number>{page}</span></p>
      <section aria-label={t.audioPlayer} className="audio-bar fixed inset-x-0 z-20 border-t border-line bg-page">
        <audio
          ref={audio}
          preload="metadata"
          playsInline
          onLoadedMetadata={() => {
            const element = audio.current;
            if (element && pendingSeek.current !== null) element.currentTime = pendingSeek.current;
            pendingSeek.current = null;
            if (element) element.playbackRate = speed;
            positionState();
          }}
          onTimeUpdate={onTime}
          onSeeked={positionState}
          onRateChange={positionState}
          onPlay={() => { playingRef.current = true; setPlaying(true); positionState(); }}
          onPause={() => { if (!audio.current?.ended) playingRef.current = false; setPlaying(false); }}
          onEnded={() => void onEnded()} onError={() => { if (audio.current?.getAttribute("src")) setFailed(true); }} onCanPlay={() => setFailed(false)} />
        <div className="mx-auto max-w-xl px-3">
          {open ? (
            <div className="space-y-3 border-b border-line py-3">
              <label className="block text-base font-medium">
                {t.reciter}
                <select value={recitation ?? ""} onChange={(event) => { const id = Number(event.target.value); store(RECITER_KEY, String(id)); cache.current.clear(); loaded.current = null; setRecitation(id); }} className="mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-2 font-normal">
                  {recitations.map((r) => <option key={r.id} value={r.id}>{reciterLabel(r)}</option>)}
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
              {landscape ? (
                <fieldset data-mushaf-zoom>
                  <legend className="text-base font-medium">{t.textSize}</legend>
                  <div className="mt-1 flex items-center gap-1 rounded-lg bg-tint p-1">
                    <button type="button" aria-label={t.smaller} disabled={zoom <= ZOOMS[0]} onClick={() => changeZoom(-1)} className="min-h-11 flex-1 rounded-md text-base disabled:opacity-40" data-zoom-out>A−</button>
                    <span className="min-w-16 text-center text-base font-medium" aria-live="polite" data-zoom-value>{Math.round(zoom * 100)} %</span>
                    <button type="button" aria-label={t.larger} disabled={zoom >= ZOOMS[ZOOMS.length - 1]} onClick={() => changeZoom(1)} className="min-h-11 flex-1 rounded-md text-lg font-medium disabled:opacity-40" data-zoom-in>A+</button>
                  </div>
                </fieldset>
              ) : null}
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
