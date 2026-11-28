"use server";

import { createClient, getSession } from "@/lib/supabase/server";

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/;

export async function saveQuizAttempt(itemId: string, revisionId: string, score: number, total: number) {
  const session = await getSession();
  const valid = UUID.test(itemId) && UUID.test(revisionId) && Number.isInteger(score) && Number.isInteger(total) && total >= 1 && total <= 100 && score >= 0 && score <= total;
  if (!session || !valid) return false;
  const supabase = await createClient();
  const { error } = await supabase.from("quiz_attempts").insert({ item_id: itemId, revision_id: revisionId, score, total });
  return !error;
}

/** Revision espacee : chaque reponse d'une personne connectee replace (ou non) la question dans ses revisions. */
export async function recordAnswer(questionId: string, correct: boolean, source: "lesson" | "review") {
  const session = await getSession();
  if (!session || !UUID.test(questionId) || typeof correct !== "boolean") return false;
  const supabase = await createClient();
  const { error } = await supabase.rpc("quiz_review_record", { p_question: questionId, p_correct: correct, p_source: source === "review" ? "review" : "lesson" });
  return !error;
}
