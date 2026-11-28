import Link from "next/link";
import { ComingSection } from "@/components/coming-section";
import { OpenSection } from "@/components/open-section";
import { getPublishedList, type PublishedCard } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata = { title: "Apprendre" };

type Best = { score: number; total: number };
const LEVELS = [1, 2, 3] as const;
/** Une lecon sans niveau va au niveau Intermediaire. */
const levelOf = (item: PublishedCard) => (item.level === 1 || item.level === 3 ? item.level : 2);

export default async function Page({ searchParams }: { searchParams: Promise<{ niveau?: string }> }) {
  const [{ t }, items, session, params] = await Promise.all([getPreferences(), getPublishedList(), getSession(), searchParams]);
  const c = t.content;
  const lv = t.levels;
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

  // Niveau conseille : celui de la premiere lecon dont les exercices ne sont pas faits (Debutant pour un visiteur).
  const ordered = LEVELS.flatMap((level) => items.filter((item) => levelOf(item) === level));
  const firstTodo = session ? ordered.find((item) => withQuestions.has(item.revisionId) && !best.has(item.id)) : undefined;
  const suggested = firstTodo ? levelOf(firstTodo) : 1;
  const asked = Number(params.niveau);
  const current = asked === 1 || asked === 2 || asked === 3 ? asked : suggested;

  const inLevel = items.filter((item) => levelOf(item) === current);
  const groups: { section: string; items: PublishedCard[] }[] = [];
  for (const item of inLevel) {
    const group = groups.find((g) => g.section === item.section);
    if (group) group.items.push(item);
    else groups.push({ section: item.section, items: [item] });
  }
  const sections = c.sections as Record<string, string>;
  const doneIn = (list: PublishedCard[]) => list.filter((item) => best.has(item.id)).length;
  // Rubrique ouverte d'emblee : la premiere qui a encore une lecon a faire.
  const openSection = (groups.find((g) => g.items.some((item) => !best.has(item.id))) ?? groups[0])?.section;

  return (
    <ComingSection section={t.soon.learn} t={t.soon} label={t.soon.learn.label} intro={t.soon.learn.introOpen}>
      <OpenSection />

      <nav aria-label={lv.label} className="mt-6 grid grid-cols-3 gap-1 rounded-lg bg-tint p-1" data-levels>
        {LEVELS.map((level) => {
          const count = items.filter((item) => levelOf(item) === level).length;
          const active = level === current;
          return (
            <Link key={level} href={`/apprendre?niveau=${level}`} aria-current={active ? "page" : undefined} data-level-tab={level}
              className={`flex min-h-14 flex-col items-center justify-center rounded-md px-1 text-center ${active ? "bg-emerald text-on-emerald" : "text-ink hover:bg-page"}`}>
              <span className="font-medium leading-tight">{lv.names[level - 1]}</span>
              <span className={`text-sm ${active ? "text-on-emerald/90" : "text-muted"}`}>{lv.count.replace("{n}", String(count))}</span>
            </Link>
          );
        })}
      </nav>

      <section className="mt-4" aria-labelledby="niveau-courant" data-level={current}>
        <h2 id="niveau-courant" className="flex flex-wrap items-center gap-x-3 text-2xl">
          {lv.names[current - 1]}
          {current === suggested ? <span className="rounded border border-gold px-1.5 text-base font-normal" data-suggested>{lv.suggested}</span> : null}
        </h2>
        <p className="mt-1 text-muted">{lv.intros[current - 1]}</p>
        {session && inLevel.length ? (() => {
          const done = doneIn(inLevel);
          return (
            <div className="mt-3" data-level-progress={`${done}/${inLevel.length}`}>
              <p className="text-base">{lv.progress.replace("{done}", String(done)).replace("{total}", String(inLevel.length))}</p>
              <div role="progressbar" aria-label={lv.names[current - 1]} aria-valuemin={0} aria-valuemax={inLevel.length} aria-valuenow={done} className="mt-1 h-2 overflow-hidden rounded-full bg-tint">
                <div className="h-full rounded-full bg-emerald" style={{ width: `${Math.round((done / inLevel.length) * 100)}%` }} />
              </div>
            </div>
          );
        })() : null}

        {groups.length ? groups.map((group) => {
          const done = doneIn(group.items);
          return (
            // Unite pliable : touchez son titre pour voir ou cacher ses lecons.
            <details key={group.section} id={`rubrique-${group.section}`} open={group.section === openSection} className="group mt-3 border-b border-line first-of-type:mt-6" data-section={group.section}>
              <summary className="flex min-h-14 cursor-pointer list-none items-center gap-3 py-2 [&::-webkit-details-marker]:hidden">
                <span className="min-w-0 flex-1">
                  <span className="block text-xl font-display">{sections[group.section] ?? group.section}</span>
                  <span className="block text-base text-muted" data-section-count>
                    {group.items.length === 1 ? t.soon.learn.lesson : t.soon.learn.lessons.replace("{n}", String(group.items.length))}
                    {session && done ? ` · ${c.exercisesDoneCount.replace("{n}", String(done))}` : ""}
                  </span>
                  {session ? (
                    <span aria-hidden className="mt-1.5 block h-1.5 overflow-hidden rounded-full bg-tint">
                      <span className="block h-full rounded-full bg-gold" style={{ width: `${Math.round((done / group.items.length) * 100)}%` }} />
                    </span>
                  ) : null}
                </span>
                <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-muted transition-transform group-open:rotate-180"><path d="m6 9 6 6 6-6" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
              </summary>
              <ol className="mb-3 divide-y divide-line border-t border-line">
                {group.items.map((item) => {
                  const score = best.get(item.id);
                  return (
                    <li key={item.slug} data-lesson={item.slug}>
                      <Link href={`/apprendre/${item.slug}`} className="flex gap-3 py-3">
                        <span aria-hidden className={`mt-0.5 flex size-8 shrink-0 items-center justify-center rounded-full border text-base font-medium ${score ? "border-emerald bg-emerald text-on-emerald" : "border-gold"}`}>
                          {score ? <svg viewBox="0 0 24 24" className="h-4 w-4"><path d="m5 12 5 5 9-10" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" /></svg> : item.position ?? "•"}
                        </span>
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
          );
        }) : <p className="mt-6 text-muted" data-level-empty>{lv.empty}</p>}
      </section>

      <h2 className="mt-8 text-xl">{lv.tools}</h2>
      <Link href="/apprendre/memorisation" className="mt-3 block rounded-lg bg-emerald px-4 py-3 text-on-emerald">
        <span className="block font-medium">{t.hifdh.open}</span>
        <span className="block text-base">{t.hifdh.openNote}</span>
      </Link>
      <Link href="/assistant" className="mt-3 flex min-h-12 items-center justify-center rounded-lg border border-line px-4 font-medium text-emerald" data-open-assistant>{t.assistant.open}</Link>
    </ComingSection>
  );
}
