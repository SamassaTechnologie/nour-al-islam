import Link from "next/link";
import { setPreference } from "@/app/actions";
import { Icon, Star, type IconName } from "@/components/art";
import { NavLink } from "@/components/nav-link";
import type { Dictionary, Locale } from "@/lib/dictionaries";
import type { Theme } from "@/lib/preferences";

const nextTheme: Record<Theme, Theme> = { system: "dark", dark: "light", light: "system" };
const themeIcon: Record<Theme, IconName> = { system: "auto", dark: "moon", light: "sun" };

function navItems(t: Dictionary, signedIn: boolean) {
  return [
    { href: "/", label: t.nav.home, icon: "home" as const },
    { href: "/coran", label: t.nav.quran, icon: "quran" as const },
    { href: "/apprendre", label: t.nav.learn, icon: "learn" as const },
    { href: "/priere", label: t.nav.prayer, icon: "prayer" as const },
    { href: signedIn ? "/profil" : "/connexion", label: t.nav.profile, icon: "profile" as const },
  ];
}

export function AppHeader({ t, locale, theme, signedIn }: { t: Dictionary; locale: Locale; theme: Theme; signedIn: boolean }) {
  return (
    <header className="app-header bg-night text-on-night">
      <div className="mx-auto flex h-14 max-w-5xl items-center gap-2 px-4">
        <Link href="/" className="flex min-h-11 items-center gap-2 font-display text-lg">
          <Star className="h-4 w-4 text-gold" />
          {t.brand}
        </Link>
        <nav aria-label={t.mainNav} className="ms-8 hidden gap-1 min-[900px]:flex">
          {navItems(t, signedIn).map((item) => (
            <NavLink key={item.href} href={item.href} className="rounded-md px-3 py-1.5 text-base text-on-night/80 hover:text-on-night" activeClassName="bg-white/10 !text-on-night">
              {item.label}
            </NavLink>
          ))}
        </nav>
        <div className="ms-auto flex items-center">
          <form action={setPreference}>
            <input type="hidden" name="key" value="locale" />
            <input type="hidden" name="value" value={locale === "fr" ? "ar" : "fr"} />
            <button aria-label={t.switchLanguage} lang={locale === "fr" ? "ar" : "fr"} className="min-h-11 rounded-md px-3 text-base hover:bg-white/10">
              {t.otherLanguage}
            </button>
          </form>
          <form action={setPreference}>
            <input type="hidden" name="key" value="theme" />
            <input type="hidden" name="value" value={nextTheme[theme]} />
            <button aria-label={t.themeNext[theme]} className="grid h-11 w-11 place-items-center rounded-md hover:bg-white/10">
              <Icon name={themeIcon[theme]} className="h-5 w-5" />
            </button>
          </form>
        </div>
      </div>
    </header>
  );
}

export function BottomNav({ t, signedIn }: { t: Dictionary; signedIn: boolean }) {
  return (
    <nav aria-label={t.mainNav} className="bottom-nav fixed inset-x-0 bottom-0 z-20 border-t border-line bg-page min-[900px]:hidden">
      <div className="mx-auto grid h-[var(--nav-height)] max-w-lg grid-cols-5">
        {navItems(t, signedIn).map((item) => (
          <NavLink key={item.href} href={item.href} className="flex flex-col items-center justify-center gap-0.5 text-[0.8125rem] leading-tight text-muted" activeClassName="!text-emerald font-medium">
            <Icon name={item.icon} />
            {item.label}
          </NavLink>
        ))}
      </div>
    </nav>
  );
}
