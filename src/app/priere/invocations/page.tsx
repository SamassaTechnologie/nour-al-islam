import Link from "next/link";
import { getAdhkarList } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { createClient } from "@/lib/supabase/server";

export const metadata = { title: "Les invocations authentiques" };

export default async function Page() {
  const [{ t }, items] = await Promise.all([getPreferences(), getAdhkarList()]);
  const a = t.adhkar;
  const counts = new Map<string, number>();
  if (items.length) {
    const { data } = await (await createClient()).from("content_adhkar").select("revision_id").in("revision_id", items.map((item) => item.revisionId));
    for (const row of data ?? []) counts.set(row.revision_id, (counts.get(row.revision_id) ?? 0) + 1);
  }
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/priere" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{a.backPrayer}</Link>
      <h1 className="text-3xl">{a.title}</h1>
      <p className="mt-3 text-muted">{a.intro}</p>
      {items.length ? (
        <ol className="mt-6 divide-y divide-line border-y border-line">
          {items.map((item) => (
            <li key={item.slug} data-adhkar-category={item.slug}>
              <Link href={`/priere/invocations/${item.slug}`} className="flex gap-3 py-3">
                {item.position ? <span aria-hidden className="mt-0.5 flex size-8 shrink-0 items-center justify-center rounded-full border border-gold text-base font-medium">{item.position}</span> : null}
                <span className="min-w-0">
                  <span className="font-medium">{item.title}</span>
                  {item.provisional ? <span data-provisional className="ms-2 inline-block rounded border border-gold px-1.5 text-base">{t.content.provisionalTag}</span> : null}
                  <span className="block text-base text-muted">{a.count.replace("{n}", String(counts.get(item.revisionId) ?? 0))}{item.summary ? `. ${item.summary}` : ""}</span>
                </span>
              </Link>
            </li>
          ))}
        </ol>
      ) : <p className="mt-6 border-s-2 border-gold ps-3 font-medium" data-empty>{a.empty}</p>}
    </main>
  );
}
