import { MushafReader } from "@/components/mushaf-reader";
import { getPreferences } from "@/lib/preferences";
import { getSurahs } from "@/lib/quran";

export default async function MushafLayout({ children }: { children: React.ReactNode }) {
  const [{ t }, surahs] = await Promise.all([getPreferences(), getSurahs()]);
  return <MushafReader t={t.quran} names={surahs.map((surah) => surah.name_translit)}>{children}</MushafReader>;
}
