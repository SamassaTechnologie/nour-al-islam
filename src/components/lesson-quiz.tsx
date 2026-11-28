"use client";

import Link from "next/link";
import { useEffect, useRef, useState, useTransition } from "react";
import { recordAnswer, saveQuizAttempt } from "@/app/quiz-actions";
import type { Dictionary, Locale } from "@/lib/dictionaries";
import type { QuizQuestion } from "@/lib/quiz";
import type { ReviewQuestion } from "@/lib/review";
import { optionOrder } from "@/lib/quiz-order";

type Score = { score: number; total: number };

type Review = { more: boolean; t: Dictionary["review"] };

/**
 * Exercices d'une lecon, ou seance de revision (`review`) : les questions viennent alors de plusieurs lecons.
 * Pour une personne connectee, chaque reponse alimente la revision espacee.
 */
export function LessonQuiz({ questions, itemId, revisionId, slug, signedIn, best, contentLocale, uiLocale, t, reviewT, review }: {
  questions: (QuizQuestion | ReviewQuestion)[];
  itemId?: string;
  revisionId?: string;
  slug?: string;
  reviewT?: Dictionary["review"];
  review?: Review;
  signedIn: boolean;
  best: Score | null;
  contentLocale: string;
  uiLocale: Locale;
  t: Dictionary["quiz"];
}) {
  const [index, setIndex] = useState(0);
  const [choice, setChoice] = useState<number | null>(null);
  const [score, setScore] = useState(0);
  const [done, setDone] = useState(false);
  const [saved, setSaved] = useState<"idle" | "saved" | "error">("idle");
  const [bestScore, setBest] = useState(best);
  const [attempt, setAttempt] = useState(0);
  const [pending, run] = useTransition();
  const [, record] = useTransition();
  const [recordError, setRecordError] = useState(false);
  const [missed, setMissed] = useState(0);
  const started = useRef(false);
  const questionRef = useRef<HTMLDivElement>(null);
  const nextRef = useRef<HTMLButtonElement>(null);
  const resultRef = useRef<HTMLDivElement>(null);
  const q = questions[index];
  const answered = choice !== null;
  const correct = answered && choice === q.answer;
  const order = optionOrder(q.id, q.options.length, attempt);
  const origin = "lesson" in q ? q.lesson : null;
  const qLocale = origin?.locale ?? contentLocale;

  // Le focus suit l'exercice : bouton suivant apres une reponse, nouvelle question, puis resultat.
  useEffect(() => {
    if (answered) nextRef.current?.focus();
  }, [answered]);
  useEffect(() => {
    if (started.current) (done ? resultRef : questionRef).current?.focus();
  }, [index, done]);

  const pick = (option: number) => {
    if (answered) return;
    started.current = true;
    setChoice(option);
    const right = option === q.answer;
    if (right) setScore((value) => value + 1);
    else setMissed((value) => value + 1);
    if (signedIn) {
      const id = q.id;
      record(async () => {
        if (!(await recordAnswer(id, right, review ? "review" : "lesson"))) setRecordError(true);
      });
    }
  };
  const next = () => {
    if (index + 1 < questions.length) {
      setIndex(index + 1);
      setChoice(null);
      return;
    }
    setDone(true);
    if (!signedIn || review || !itemId || !revisionId) return;
    run(async () => {
      const ok = await saveQuizAttempt(itemId, revisionId, score, questions.length);
      setSaved(ok ? "saved" : "error");
      if (ok && (!bestScore || score / questions.length > bestScore.score / bestScore.total)) setBest({ score, total: questions.length });
    });
  };
  const restart = () => {
    setIndex(0);
    setChoice(null);
    setScore(0);
    setDone(false);
    setSaved("idle");
    setMissed(0);
    setAttempt((value) => value + 1);
  };
  const optionClass = (option: number) => {
    const base = "min-h-11 w-full rounded-lg border px-3 py-2 text-start";
    if (!answered) return `${base} border-line`;
    if (option === q.answer) return `${base} border-emerald bg-tint font-medium`;
    if (option === choice) return `${base} border-danger text-danger`;
    return `${base} border-line text-muted`;
  };

  return (
    <section className="mt-8 border-t border-line pt-5" aria-labelledby={review ? undefined : "quiz-title"} data-quiz>
      {review ? null : <h2 id="quiz-title" className="text-xl">{t.title}</h2>}
      {bestScore ? <p className="text-muted" data-best>{t.best} : {bestScore.score} / {bestScore.total}</p> : null}
      {done ? (
        <div ref={resultRef} tabIndex={-1} className="mt-3 border-s-2 border-gold ps-4 outline-none">
          {review ? (
            <>
              <p className="text-xl" data-score>{review.t.done}</p>
              <p>{review.t.doneNote.replace("{score}", String(score)).replace("{total}", String(questions.length))}</p>
              {missed > 0 ? <p className="text-muted" data-will-return>{review.t.willReturn}</p> : null}
              {recordError ? <p role="alert" className="text-danger">{review.t.saveError}</p> : null}
              {review.more ? <a href="/apprendre/revision" className="mt-3 inline-flex min-h-11 items-center rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-review-more>{review.t.more}</a> : null}
              <Link href="/apprendre" className="mt-2 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{review.t.back}</Link>
            </>
          ) : (
          <>
          <p className="text-xl" data-score>{t.result} : {score} / {questions.length}</p>
          <div role="status">
            {signedIn ? (
              saved === "saved" ? <p data-saved>{t.saved}</p> : saved === "error" ? <p className="text-danger">{t.saveError}</p> : pending ? <p className="text-muted">{t.saving}</p> : null
            ) : null}
          </div>
          {signedIn ? null : (
            <Link href={`/connexion?suivant=/apprendre/${slug}`} className="inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.signIn}</Link>
          )}
          {signedIn && missed > 0 && reviewT ? <p className="mt-1 text-muted" data-will-return>{reviewT.willReturn}</p> : null}
          {signedIn && recordError && reviewT ? <p role="alert" className="text-danger">{reviewT.saveError}</p> : null}
          <button type="button" onClick={restart} className="mt-2 block min-h-11 rounded-lg border border-line px-4 font-medium">{t.retry}</button>
          </>
          )}
        </div>
      ) : (
        <div className="mt-3" data-question={index}>
          <div ref={questionRef} tabIndex={-1} className="outline-none">
            <p className="text-muted">{t.progress.replace("{n}", String(index + 1)).replace("{total}", String(questions.length))}</p>
            {origin ? <p className="text-base text-muted" data-origin>{review?.t.from.replace("{title}", origin.title)}</p> : null}
            <p lang={qLocale} dir={qLocale === "ar" ? "rtl" : "ltr"} className="mt-1 font-medium" data-prompt>{q.prompt}</p>
          </div>
          {q.display ? <p lang="ar" dir="rtl" className="my-2 text-center text-6xl leading-normal" data-display>{q.display}</p> : null}
          {q.excerpt ? (
            <figure className="mt-2">
              <p lang="ar" dir="rtl" className="quran-text text-center" data-excerpt>{q.excerpt.text}</p>
              <figcaption className="text-center text-base text-muted">
                {t.excerpt.replace("{name}", uiLocale === "ar" ? q.excerpt.nameAr : q.excerpt.name).replace("{n}", String(q.excerpt.ayah))}
              </figcaption>
            </figure>
          ) : null}
          <ul lang={qLocale} className="mt-3 space-y-2">
            {order.map((n) => (
              <li key={n}>
                <button type="button" dir="auto" disabled={answered} aria-pressed={choice === n} data-option={n} onClick={() => pick(n)} className={optionClass(n)}>{q.options[n]}</button>
              </li>
            ))}
          </ul>
          <div role="status" className="mt-3">
            {answered ? (
              <>
                <p className={`font-medium ${correct ? "text-emerald" : "text-danger"}`} data-verdict={correct ? "correct" : "wrong"}>{correct ? t.correct : t.wrong}</p>
                <p lang={qLocale} dir={qLocale === "ar" ? "rtl" : "ltr"} className="mt-1" data-explanation>{q.explanation}</p>
                {origin && !correct ? <Link href={`/apprendre/${origin.slug}`} className="mt-1 inline-flex min-h-11 items-center text-emerald underline underline-offset-4" data-origin-link>{review?.t.reread}</Link> : null}
              </>
            ) : null}
          </div>
          {answered ? <button ref={nextRef} type="button" onClick={next} className="mt-3 min-h-11 rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-next>{index + 1 < questions.length ? t.next : t.finish}</button> : null}
        </div>
      )}
    </section>
  );
}
