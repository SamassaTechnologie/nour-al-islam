import Link from "next/link";
import { ComingSection } from "@/components/coming-section";
import { getPublishedList } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";

export const metadata = { title: "Apprendre" };

export default async function Page() {
  const [{ t }, items] = await Promise.all([getPreferences(), getPublishedList()]);
  return (
    <ComingSection section={t.soon.learn} t={t.soon}>
      <Link href="/apprendre/memorisation" className="mt-6 block rounded-lg bg-emerald px-4 py-3 text-on-emerald">
        <span className="block font-medium">{t.hifdh.open}</span>
        <span className="block text-base">{t.hifdh.openNote}</span>
      </Link>
      {items.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{t.content.available}</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line">
            {items.map((item) => <li key={item.slug}><Link href={`/apprendre/${item.slug}`} className="block py-3"><span className="font-medium">{item.title}</span>{item.provisional ? <span data-provisional className="ms-2 inline-block rounded border border-gold px-1.5 text-base">{t.content.provisionalTag}</span> : null}<span className="block text-base text-muted">{t.content.kinds[item.kind]}{item.summary ? `. ${item.summary}` : ""}</span></Link></li>)}
          </ul>
        </section>
      ) : null}
    </ComingSection>
  );
}
