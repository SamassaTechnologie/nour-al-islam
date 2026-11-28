import type { Question } from "@/lib/admin";
import { getPublishedList } from "@/lib/content";
import { withExcerpts, type QuizQuestion } from "@/lib/quiz";
import { dayKey } from "@/lib/streak";
import { createClient } from "@/lib/supabase/server";

export type ReviewQuestion = QuizQuestion & { lesson: { title: string; slug: string; locale: string } };
type Row = { question_id: string; box: number; content_questions: Question };

/** Une seance de revision reste courte : quelques minutes par jour. */
export const REVIEW_SESSION = 15;

/**
 * Questions ratees dont la revision est due (lues sous les droits de l'utilisateur : RLS).
 * Seules comptent les questions de la version publiee d'une lecon : si une lecon a ete revue, ses anciennes questions sont ignorees.
 */
async function dueRows() {
  const supabase = await createClient();
  const [lessons, { data, error }] = await Promise.all([
    getPublishedList(),
    supabase.from("quiz_reviews").select("question_id,box,content_questions!inner(id,revision_id,prompt,display,surah,ayah,word_from,word_to,options,answer,explanation)")
      .lte("due", dayKey(new Date())).order("due").order("box").limit(300),
  ]);
  if (error) throw new Error(error.message);
  const byRevision = new Map(lessons.map((l) => [l.revisionId, l]));
  return (data as unknown as Row[]).flatMap((row) => {
    const lesson = byRevision.get(row.content_questions.revision_id);
    return lesson ? [{ question: row.content_questions, lesson }] : [];
  });
}

export async function countDueReviews() {
  return (await dueRows()).length;
}

export async function getDueReviews(): Promise<{ questions: ReviewQuestion[]; total: number }> {
  const rows = await dueRows();
  const picked = rows.slice(0, REVIEW_SESSION);
  const questions = await withExcerpts(picked.map((r) => r.question));
  return {
    total: rows.length,
    questions: questions.map((q, i) => ({ ...q, lesson: { title: picked[i].lesson.title, slug: picked[i].lesson.slug, locale: picked[i].lesson.locale } })),
  };
}
