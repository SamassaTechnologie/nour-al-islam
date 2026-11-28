import type { ReactNode } from "react";
import { SurahAudio } from "@/components/surah-audio";
import { getPreferences } from "@/lib/preferences";
import { getSurahs } from "@/lib/quran";

export default async function QuranLayout({ children }: { children: ReactNode }) {
  const [{ t }, surahs] = await Promise.all([getPreferences(), getSurahs()]);
  return (
    <>
      {children}
      <SurahAudio names={surahs.map((s) => s.name_translit)} t={t.quran} />
    </>
  );
}
