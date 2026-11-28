"use client";

import { usePathname } from "next/navigation";
import { AudioPlayer } from "@/components/audio-player";
import type { Dictionary } from "@/lib/dictionaries";

/**
 * Lecteur des pages de sourate, place dans la mise en page de /coran : il reste monte quand on passe
 * d'une sourate a l'autre, ce qui permet d'enchainer sur la sourate suivante sans couper la recitation
 * (ecran eteint compris). Ailleurs (liste, Mushaf, tafsir...), il n'est pas affiche.
 */
export function SurahAudio({ names, t }: { names: string[]; t: Dictionary["quran"] }) {
  const match = usePathname().match(/^\/coran\/(\d{1,3})$/);
  const surah = match ? Number(match[1]) : 0;
  if (surah < 1 || surah > names.length) return null;
  return <AudioPlayer surah={surah} surahName={names[surah - 1]} t={t} />;
}
