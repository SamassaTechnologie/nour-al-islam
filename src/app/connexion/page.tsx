import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { SignInForm } from "@/components/forms";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Connexion" };

export default async function SignInPage({ searchParams }: { searchParams: Promise<{ suivant?: string; erreur?: string }> }) {
  if (await getSession()) redirect("/profil");
  const [{ t }, params] = await Promise.all([getPreferences(), searchParams]);
  return (
    <main className="mx-auto max-w-md px-5 pt-8">
      <h1 className="mb-6 text-3xl">{t.auth.signInTitle}</h1>
      <SignInForm t={t.auth} next={params.suivant ?? "/profil"} initialError={params.erreur === "lien" ? t.auth.linkError : undefined} />
    </main>
  );
}
