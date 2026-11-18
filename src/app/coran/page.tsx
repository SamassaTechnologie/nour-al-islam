import { ComingSection } from "@/components/coming-section";
import { getPreferences } from "@/lib/preferences";

export const metadata = { title: "Coran" };

export default async function Page() {
  const { t } = await getPreferences();
  return <ComingSection section={t.soon.quran} t={t.soon} />;
}
