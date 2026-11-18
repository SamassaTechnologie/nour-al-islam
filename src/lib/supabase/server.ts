import { cache } from "react";
import { cookies } from "next/headers";
import { createServerClient } from "@supabase/ssr";
import type { User } from "@supabase/supabase-js";

export type AppRole = "user" | "editor" | "reviewer" | "admin";

export type Profile = {
  id: string;
  display_name: string;
  preferred_locale: "fr" | "ar";
  role: AppRole;
};

export function supabaseEnv() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key) throw new Error("Variables Supabase manquantes : voir .env.example");
  return { url, key };
}

export async function createClient() {
  const store = await cookies();
  const { url, key } = supabaseEnv();
  return createServerClient(url, key, {
    cookies: {
      getAll: () => store.getAll(),
      setAll(items) {
        try {
          items.forEach(({ name, value, options }) => store.set(name, value, options));
        } catch {
          // Appel depuis un composant serveur : proxy.ts se charge du rafraichissement.
        }
      },
    },
  });
}

export const getSession = cache(async (): Promise<{ user: User; profile: Profile | null } | null> => {
  const store = await cookies();
  if (!store.getAll().some((c) => c.name.startsWith("sb-"))) return null;
  const supabase = await createClient();
  const { data, error } = await supabase.auth.getUser();
  if (error || !data.user) return null;
  const { data: profile } = await supabase
    .from("profiles")
    .select("id, display_name, preferred_locale, role")
    .eq("id", data.user.id)
    .maybeSingle<Profile>();
  return { user: data.user, profile };
});
