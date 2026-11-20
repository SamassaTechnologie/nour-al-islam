import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { setPreference, signOut } from "@/app/actions";
import Link from "next/link";
import { ProfileForm } from "@/components/forms";
import { getReadingSummary, getSurahs } from "@/lib/quran";
import { getPreferences, type Theme } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";
import { Dashboard } from "@/components/dashboard";
import { getDashboard } from "@/lib/dashboard";

export const metadata: Metadata = { title: "Mon espace" };

function Choice({ name, value, label, active }: { name: string; value: string; label: string; active: boolean }) {
  return (
    <form action={setPreference} className="flex-1">
      <input type="hidden" name="key" value={name} />
      <input type="hidden" name="value" value={value} />
      <button aria-pressed={active} className={`min-h-11 w-full rounded-md px-2 text-base ${active ? "bg-emerald font-medium text-on-emerald" : "text-ink"}`}>
        {label}
      </button>
    </form>
  );
}

export default async function ProfilePage() {
  const session = await getSession();
  if (!session) redirect("/connexion?suivant=/profil");
  const [{ t, locale, theme }, reading, surahs, dashboard] = await Promise.all([getPreferences(), getReadingSummary(), getSurahs(), getDashboard()]);
  const last = reading?.recent[0];
  const p = t.profile;
  const name = session.profile?.display_name ?? "";
  const role = session.profile?.role ?? "user";
  const themes: Theme[] = ["system", "light", "dark"];
  return (
    <main className="mx-auto max-w-md px-5 pt-8">
      <p className="text-muted">{p.title}</p>
      <h1 className="text-3xl break-words">{p.greeting} {name}</h1>

      <section className="mt-7 border-s-2 border-gold ps-4">
        <h2 className="text-xl">{p.progressTitle}</h2>
        {last ? (
          <Link href={`/coran/${last.surah}#v${last.surah}-${last.ayahs.number}`} className="mt-1 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">
            {t.quran.progressLast} : {surahs[last.surah - 1].name_translit}, {last.ayahs.number}
          </Link>
        ) : <p className="mt-1 text-muted">{p.progressEmpty}</p>}
        <Link href="/coran/signets" className="flex min-h-11 items-center text-muted underline underline-offset-4">{t.quran.progressBookmarks} : {reading?.bookmarkCount ?? 0}</Link>
        <Link href="/favoris" className="flex min-h-11 items-center text-muted underline underline-offset-4" data-favorites-link>{t.favorites.count.replace("{n}", String(dashboard.favorites))}</Link>
        <Link href="/apprendre" className="flex min-h-11 items-center text-muted underline underline-offset-4" data-exercised>{p.exercises.replace("{n}", String(dashboard.lessonsDone))}</Link>
      </section>

      <Dashboard data={dashboard} t={t} locale={locale} />

      <section className="mt-9">
        <h2 className="mb-3 text-xl">{p.account}</h2>
        <ProfileForm t={p} pending={t.auth.pending} name={name} />
        <dl className="mt-5 space-y-2">
          <div>
            <dt className="text-base text-muted">{p.email}</dt>
            <dd dir="ltr" className="text-start break-all">{session.user.email}</dd>
          </div>
          {role !== "user" ? (
            <div>
              <dt className="text-base text-muted">{p.role}</dt>
              <dd>{p.roles[role]}</dd>
            </div>
          ) : null}
        </dl>
        {role !== "user" ? <Link href="/admin" className="mt-2 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{p.admin}</Link> : null}
      </section>

      <section className="mt-9">
        <h2 className="mb-3 text-xl">{p.preferences}</h2>
        <p className="mb-1 font-medium">{p.language}</p>
        <div className="flex gap-1 rounded-lg bg-tint p-1">
          <Choice name="locale" value="fr" label="Français" active={locale === "fr"} />
          <Choice name="locale" value="ar" label="العربية" active={locale === "ar"} />
        </div>
        <p className="mt-4 mb-1 font-medium">{p.theme}</p>
        <div className="flex gap-1 rounded-lg bg-tint p-1">
          {themes.map((value) => <Choice key={value} name="theme" value={value} label={p.themes[value]} active={theme === value} />)}
        </div>
      </section>

      <form action={signOut} className="mt-9">
        <button className="min-h-12 w-full rounded-lg border border-line px-5 font-medium">{p.signOut}</button>
      </form>
    </main>
  );
}
