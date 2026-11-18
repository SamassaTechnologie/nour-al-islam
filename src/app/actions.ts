"use server";

import { revalidatePath } from "next/cache";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import type { AuthError } from "@supabase/supabase-js";
import type { AuthErrorKey } from "@/lib/dictionaries";
import { LOCALE_COOKIE, THEME_COOKIE, getPreferences, isLocale, isTheme, preferenceCookie } from "@/lib/preferences";
import { createClient, getSession } from "@/lib/supabase/server";

export type AuthState = { error?: AuthErrorKey; email?: string; name?: string; checkEmail?: boolean };
export type ProfileState = { status?: "saved" | "error" };

const text = (form: FormData, key: string) => {
  const value = form.get(key);
  return typeof value === "string" ? value.trim() : "";
};

/** N'accepte que les chemins internes pour eviter toute redirection vers un autre site. */
const safePath = (value: string) => (/^\/(?![/\\])/.test(value) ? value : "/profil");

function mapAuthError(error: AuthError): AuthErrorKey {
  switch (error.code) {
    case "invalid_credentials":
      return "invalidCredentials";
    case "email_not_confirmed":
      return "emailNotConfirmed";
    case "weak_password":
      return "weakPassword";
    case "validation_failed":
    case "email_address_invalid":
      return "invalidEmail";
    case "over_request_rate_limit":
    case "over_email_send_rate_limit":
      return "rateLimited";
    case "email_address_not_authorized":
    case "signup_disabled":
    case "email_provider_disabled":
      return "signupUnavailable";
    default:
      return error.status === 429 ? "rateLimited" : "generic";
  }
}

export async function signIn(_: AuthState, form: FormData): Promise<AuthState> {
  const email = text(form, "email");
  const password = form.get("password");
  if (!email || typeof password !== "string" || !password) return { error: "invalidCredentials", email };

  const supabase = await createClient();
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) return { error: mapAuthError(error), email };

  const { data: profile } = await supabase
    .from("profiles")
    .select("preferred_locale")
    .eq("id", data.user.id)
    .maybeSingle();
  if (isLocale(profile?.preferred_locale)) {
    (await cookies()).set(LOCALE_COOKIE, profile.preferred_locale, preferenceCookie);
  }
  revalidatePath("/", "layout");
  redirect(safePath(text(form, "next")));
}

export async function signUp(_: AuthState, form: FormData): Promise<AuthState> {
  const name = text(form, "name");
  const email = text(form, "email");
  const password = form.get("password");
  if (name.length < 2 || name.length > 60) return { error: "invalidName", email, name };
  if (typeof password !== "string" || password.length < 8 || password.length > 72) {
    return { error: "weakPassword", email, name };
  }

  const { locale } = await getPreferences();
  const site = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
  const supabase = await createClient();
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: { display_name: name, preferred_locale: locale },
      emailRedirectTo: `${site}/auth/callback`,
    },
  });
  if (error) return { error: mapAuthError(error), email, name };
  if (data.session) {
    revalidatePath("/", "layout");
    redirect("/profil");
  }
  return { checkEmail: true, email };
}

export async function signOut() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  revalidatePath("/", "layout");
  redirect("/");
}

export async function updateProfile(_: ProfileState, form: FormData): Promise<ProfileState> {
  const session = await getSession();
  if (!session) redirect("/connexion?suivant=/profil");
  const name = text(form, "name");
  if (name.length < 2 || name.length > 60) return { status: "error" };
  const supabase = await createClient();
  const { error } = await supabase.from("profiles").update({ display_name: name }).eq("id", session.user.id);
  if (error) return { status: "error" };
  revalidatePath("/", "layout");
  return { status: "saved" };
}

export async function setPreference(form: FormData) {
  const key = form.get("key");
  const value = form.get("value");
  const store = await cookies();
  if (key === "theme" && isTheme(value)) {
    store.set(THEME_COOKIE, value, preferenceCookie);
  } else if (key === "locale" && isLocale(value)) {
    store.set(LOCALE_COOKIE, value, preferenceCookie);
    const session = await getSession();
    if (session) {
      const supabase = await createClient();
      await supabase.from("profiles").update({ preferred_locale: value }).eq("id", session.user.id);
    }
  }
  revalidatePath("/", "layout");
}
