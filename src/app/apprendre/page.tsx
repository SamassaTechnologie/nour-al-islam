import { ComingSection } from "@/components/coming-section";
import { getPreferences } from "@/lib/preferences";

export const metadata = { title: "Apprendre" };

export default async function Page() {
  const { t } = await getPreferences();
  return <ComingSection section={t.soon.learn} t={t.soon} />;
}
