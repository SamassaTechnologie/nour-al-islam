import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { LessonQuiz } from "@/components/lesson-quiz";
import { getPreferences } from "@/lib/preferences";
import { getDueReviews } from "@/lib/review";
import { getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Révision des exercices" };

/** Seance de revision espacee : les questions ratees dont la date est arrivee, toutes lecons confondues. */
export default async function QuizReview() {
  if (!(await getSession())) redirect("/connexion?suivant=/apprendre/revision");
  const [{ t, locale }, { questions, total }] = await Promise.all([getPreferences(), getDueReviews()]);
  const r = t.review;
  return (
    <main className="mx-auto max-w-xl px-5 pt-5" data-review-page>
      <Link href="/apprendre" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{r.back}</Link>
      <h1 className="text-3xl">{r.title}</h1>
      <p className="mt-2 text-muted">{r.intro}</p>
      {questions.length ? (
        <>
          <p className="mt-4 font-medium" data-review-count={total}>{r.session.replace("{n}", String(questions.length)).replace("{total}", String(total))}</p>
          <LessonQuiz questions={questions} signedIn best={null} contentLocale="fr" uiLocale={locale} t={t.quiz} review={{ more: total > questions.length, t: r }} />
        </>
      ) : (
        <div className="mt-6 rounded-lg bg-tint p-4" data-review-empty>
          <p className="font-medium">{r.none}</p>
          <p className="mt-1 text-base text-muted">{r.noneNote}</p>
          <Link href="/apprendre" className="mt-2 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{r.back}</Link>
        </div>
      )}
    </main>
  );
}
