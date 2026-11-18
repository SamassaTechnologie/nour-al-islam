import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { SignUpForm } from "@/components/forms";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Créer un compte" };

export default async function SignUpPage() {
  if (await getSession()) redirect("/profil");
  const { t } = await getPreferences();
  return (
    <main className="mx-auto max-w-md px-5 pt-8">
      <h1 className="text-3xl">{t.auth.signUpTitle}</h1>
      <p className="mt-2 mb-6 text-muted">{t.auth.signUpIntro}</p>
      <SignUpForm t={t.auth} />
    </main>
  );
}
