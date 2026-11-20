"use server";

import { generateText } from "ai";
import { ASSISTANT_MODEL, buildPrompt, citedDocs, DAILY_LIMIT, retrieve, SYSTEM_PROMPT } from "@/lib/assistant";
import { createClient, getSession } from "@/lib/supabase/server";

export type AssistantResult =
  | { ok: true; answer: string; sources: { n: number; title: string; href: string }[]; remaining: number }
  | { ok: false; error: "signin" | "length" | "quota" | "unavailable" };

export async function askAssistant(question: string): Promise<AssistantResult> {
  const session = await getSession();
  if (!session) return { ok: false, error: "signin" };
  const q = (question ?? "").trim().replace(/\s+/g, " ");
  if (q.length < 5 || q.length > 500) return { ok: false, error: "length" };
  const { data: remaining, error } = await (await createClient()).rpc("assistant_take_quota", { p_limit: DAILY_LIMIT });
  if (error || remaining === null || remaining < 0) return { ok: false, error: error ? "unavailable" : "quota" };
  try {
    const docs = await retrieve(q);
    const { text } = await generateText({
      model: ASSISTANT_MODEL,
      system: SYSTEM_PROMPT,
      prompt: buildPrompt(q, docs),
      maxOutputTokens: 900,
      temperature: 0.2,
    });
    const sources = citedDocs(text, docs).map(({ n, title, href }) => ({ n, title, href }));
    return { ok: true, answer: text.trim(), sources, remaining };
  } catch (e) {
    console.error("assistant", e instanceof Error ? e.message : String(e));
    return { ok: false, error: "unavailable" };
  }
}
