import { MushafReader } from "@/components/mushaf-reader";
import { getPreferences } from "@/lib/preferences";
import { getSurahs } from "@/lib/quran";
import { getSession } from "@/lib/supabase/server";

export default async function MushafLayout({ children }: { children: React.ReactNode }) {
  const [{ t }, surahs, session] = await Promise.all([getPreferences(), getSurahs(), getSession()]);
  // Mot a mot : equipe seulement tant que les savants ne l'ont pas valide.
  const staff = Boolean(session?.profile && ["editor", "reviewer", "admin"].includes(session.profile.role));
  return <MushafReader t={t.quran} names={surahs.map((surah) => surah.name_translit)} staff={staff}>{children}</MushafReader>;
}
