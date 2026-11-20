import type { Metadata } from "next";
import Link from "next/link";
import { AssistantChat } from "@/components/assistant-chat";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Assistant" };

export default async function AssistantPage() {
  const [{ t }, session] = await Promise.all([getPreferences(), getSession()]);
  const a = t.assistant;
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{a.title}</h1>
      <p className="mt-2 text-muted">{a.intro}</p>
      <ul className="mt-3 space-y-1 border-s-2 border-gold ps-3 text-base" role="note" data-assistant-rules>
        {a.rules.map((r) => <li key={r}>{r}</li>)}
      </ul>
      {session ? <AssistantChat t={a} /> : (
        <Link href="/connexion?suivant=/assistant" className="mt-6 flex min-h-12 items-center justify-center rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-assistant-signin>{a.signIn}</Link>
      )}
    </main>
  );
}
