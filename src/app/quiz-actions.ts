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
