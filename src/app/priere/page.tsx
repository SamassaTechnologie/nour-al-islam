import { ComingSection } from "@/components/coming-section";
import { getPreferences } from "@/lib/preferences";

export const metadata = { title: "Prière" };

export default async function Page() {
  const { t } = await getPreferences();
  return <ComingSection section={t.soon.prayer} t={t.soon} />;
}
