import Link from "next/link";
import { ComingSection } from "@/components/coming-section";
import { getPreferences } from "@/lib/preferences";

export const metadata = { title: "Prière" };

export default async function Page() {
  const { t } = await getPreferences();
  return (
    <ComingSection section={t.soon.prayer} t={t.soon}>
      <Link href="/priere/invocations" className="mt-6 block rounded-lg bg-emerald px-4 py-3 text-on-emerald" data-open-adhkar>
        <span className="block font-medium">{t.adhkar.open}</span>
        <span className="block text-base">{t.adhkar.openNote}</span>
      </Link>
    </ComingSection>
  );
}
