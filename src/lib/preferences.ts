import { cookies } from "next/headers";
import { dictionaries, type Locale } from "@/lib/dictionaries";

export type Theme = "system" | "light" | "dark";

export const LOCALE_COOKIE = "nour_locale";
export const THEME_COOKIE = "nour_theme";
export const QURAN_VIEW_COOKIE = "nour_quran_view";

export const isLocale = (v: unknown): v is Locale => v === "fr" || v === "ar";
export const isTheme = (v: unknown): v is Theme => v === "system" || v === "light" || v === "dark";

export async function getPreferences() {
  const store = await cookies();
  const rawLocale = store.get(LOCALE_COOKIE)?.value;
  const rawTheme = store.get(THEME_COOKIE)?.value;
  const locale: Locale = isLocale(rawLocale) ? rawLocale : "fr";
  const theme: Theme = isTheme(rawTheme) ? rawTheme : "system";
  const quranView = store.get(QURAN_VIEW_COOKIE)?.value === "mushaf" ? "mushaf" : "verses";
  return { locale, theme, quranView, t: dictionaries[locale] };
}

export const preferenceCookie = {
  httpOnly: true,
  sameSite: "lax" as const,
  secure: process.env.NODE_ENV === "production",
  path: "/",
  maxAge: 60 * 60 * 24 * 365,
};
