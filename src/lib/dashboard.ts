import { getPublishedList, type PublishedCard } from "@/lib/content";
import { countDueReviews } from "@/lib/review";
import { currentStreak, dayKey, lastWeek } from "@/lib/streak";
import { createClient } from "@/lib/supabase/server";

type ActivityRow = { day: string; exercises: number; reviews: number; readings: number };
export type SectionProgress = { section: string; done: number; total: number };

/** Donnees du tableau de bord de l'utilisateur connecte (lues sous ses droits : RLS). */
export async function getDashboard() {
  const supabase = await createClient();
  const today = dayKey(new Date());
  const lessons = await getPublishedList();
  const [activity, questions, attempts, memorised, due, favorites, reviewDue] = await Promise.all([
    supabase.from("user_activity_days").select("day,exercises,reviews,readings").order("day", { ascending: false }).limit(400).returns<ActivityRow[]>(),
    lessons.length ? supabase.from("content_questions").select("revision_id").in("revision_id", lessons.map((l) => l.revisionId)) : Promise.resolve({ data: [] as { revision_id: string }[] }),
    supabase.from("quiz_attempts").select("item_id").limit(2000),
    supabase.from("hifdh_progress").select("ayah_id", { count: "exact", head: true }),
    supabase.from("hifdh_progress").select("ayah_id", { count: "exact", head: true }).lte("next_review", today),
    supabase.from("favorites").select("item_id", { count: "exact", head: true }),
    countDueReviews(),
  ]);
  const rows = activity.data ?? [];
  const active = rows.filter((r) => r.exercises + r.reviews + r.readings > 0).map((r) => r.day);
  const todayRow = rows.find((r) => r.day === today) ?? { day: today, exercises: 0, reviews: 0, readings: 0 };

  // Lecons avec exercices, dans l'ordre du parcours ; une lecon est « faite » quand ses exercices ont ete tentes.
  const withQuestions = new Set((questions.data ?? []).map((q) => q.revision_id));
  const tried = new Set((attempts.data ?? []).map((a) => a.item_id));
  // Parcours : niveau par niveau (Debutant, Intermediaire, Avance), puis l'ordre des rubriques et des places.
  const path = lessons.filter((l) => withQuestions.has(l.revisionId)).map((l, i) => ({ l, i }))
    .sort((a, b) => (a.l.level ?? 2) - (b.l.level ?? 2) || a.i - b.i).map(({ l }) => l);
  const sections: SectionProgress[] = [];
  // Progression par rubrique, dans l'ordre des rubriques (une rubrique peut s'etendre sur plusieurs niveaux).
  for (const lesson of lessons.filter((l) => withQuestions.has(l.revisionId))) {
    let entry = sections.find((s) => s.section === lesson.section);
    if (!entry) sections.push(entry = { section: lesson.section, done: 0, total: 0 });
    entry.total++;
    if (tried.has(lesson.id)) entry.done++;
  }
  const next: PublishedCard | null = path.find((l) => !tried.has(l.id)) ?? null;

  return {
    today,
    streak: currentStreak(active, today),
    week: lastWeek(active, today),
    todayRow,
    sections,
    next,
    lessonsDone: path.filter((l) => tried.has(l.id)).length,
    lessonsTotal: path.length,
    memorised: memorised.count ?? 0,
    due: due.count ?? 0,
    favorites: favorites.count ?? 0,
    reviewDue,
  };
}
