import Link from "next/link";
import { ComingSection } from "@/components/coming-section";
import { OpenSection } from "@/components/open-section";
import { getPublishedList, type PublishedCard } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata = { title: "Apprendre" };

type Best = { score: number; total: number };

export default async function Page() {
  const [{ t }, items, session] = await Promise.all([getPreferences(), getPublishedList(), getSession()]);
  const c = t.content;
  const supabase = await createClient();
  // Lecons avec exercices, et meilleur resultat de l'utilisateur connecte.
  const withQuestions = new Set<string>();
  const best = new Map<string, Best>();
  if (items.length) {
    const [{ data: questions }, attempts] = await Promise.all([
      supabase.from("content_questions").select("revision_id").in("revision_id", items.map((item) => item.revisionId)),
      session ? supabase.from("quiz_attempts").select("item_id,score,total").limit(1000) : Promise.resolve({ data: [] as { item_id: string; score: number; total: number }[] }),
    ]);
    for (const row of questions ?? []) withQuestions.add(row.revision_id);
    for (const row of attempts.data ?? []) {
      const top = best.get(row.item_id);
      if (!top || row.score / row.total > top.score / top.total) best.set(row.item_id, { score: row.score, total: row.total });
    }
  }
  const groups: { section: string; items: PublishedCard[] }[] = [];
  for (const item of items) {
    const last = groups.at(-1);
    if (last?.section === item.section) last.items.push(item);
    else groups.push({ section: item.section, items: [item] });
  }
  const sections = c.sections as Record<string, string>;

  return (
    <ComingSection section={t.soon.learn} t={t.soon} label={t.soon.learn.label} intro={t.soon.learn.introOpen}>
      <OpenSection />
      <Link href="/apprendre/memorisation" className="mt-6 block rounded-lg bg-emerald px-4 py-3 text-on-emerald">
        <span className="block font-medium">{t.hifdh.open}</span>
        <span className="block text-base">{t.hifdh.openNote}</span>
      </Link>
      <Link href="/assistant" className="mt-3 flex min-h-12 items-center justify-center rounded-lg border border-line px-4 font-medium text-emerald" data-open-assistant>{t.assistant.open}</Link>
      {groups.map((group) => (
        // Rubrique pliable : touchez son titre pour voir ou cacher ses lecons.
        <details key={group.section} id={`rubrique-${group.section}`} className="group mt-3 border-b border-line first-of-type:mt-7" data-section={group.section}>
          <summary className="flex min-h-14 cursor-pointer list-none items-center gap-3 py-2 [&::-webkit-details-marker]:hidden">
            <span className="min-w-0 flex-1">
              <h2 className="text-xl">{sections[group.section] ?? group.section}</h2>
              <span className="block text-base text-muted" data-section-count>
                {group.items.length === 1 ? t.soon.learn.lesson : t.soon.learn.lessons.replace("{n}", String(group.items.length))}
                {(() => {
                  const done = group.items.filter((item) => best.has(item.id)).length;
                  return session && done ? ` · ${c.exercisesDoneCount.replace("{n}", String(done))}` : "";
                })()}
              </span>
            </span>
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-muted transition-transform group-open:rotate-180"><path d="m6 9 6 6 6-6" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
          </summary>
          <ol className="mb-3 divide-y divide-line border-t border-line">
            {group.items.map((item) => {
              const score = best.get(item.id);
              return (
                <li key={item.slug} data-lesson={item.slug}>
                  <Link href={`/apprendre/${item.slug}`} className="flex gap-3 py-3">
                    {item.position ? <span aria-hidden className="mt-0.5 flex size-8 shrink-0 items-center justify-center rounded-full border border-gold text-base font-medium">{item.position}</span> : null}
                    <span className="min-w-0">
                      <span className="font-medium">{item.position ? <span className="sr-only">{c.step.replace("{n}", String(item.position))} </span> : null}{item.title}</span>
                      {item.provisional ? <span data-provisional className="ms-2 inline-block rounded border border-gold px-1.5 text-base">{c.provisionalTag}</span> : null}
                      <span className="block text-base text-muted">{c.kinds[item.kind]}{item.summary ? `. ${item.summary}` : ""}</span>
                      {withQuestions.has(item.revisionId) ? (
                        score ? <span className="block text-base font-medium text-emerald" data-done>{c.exercisesDone.replace("{score}", String(score.score)).replace("{total}", String(score.total))}</span>
                          : <span className="block text-base text-muted" data-todo>{session ? c.exercisesTodo : c.exercisesAvailable}</span>
                      ) : null}
                    </span>
                  </Link>
                </li>
              );
            })}
          </ol>
        </details>
      ))}
    </ComingSection>
  );
}
