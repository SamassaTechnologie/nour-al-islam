import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { getAdhkarList, getPublishedList, type PublishedCard } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { createClient, getSession } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Mes favoris" };

export default async function Favorites() {
  const session = await getSession();
  if (!session) redirect("/connexion?suivant=/favoris");
  const [{ t }, lessons, adhkar, favorites] = await Promise.all([
    getPreferences(),
    getPublishedList(),
    getAdhkarList(),
    (await createClient()).from("favorites").select("item_id,created_at").order("created_at", { ascending: false }).returns<{ item_id: string }[]>(),
  ]);
  const f = t.favorites;
  const sections = t.content.sections as Record<string, string>;
  // Seuls les contenus encore visibles pour cette personne sont affiches (un contenu retire disparait de la liste).
  const pick = (list: PublishedCard[]) => {
    const byId = new Map(list.map((x) => [x.id, x]));
    return (favorites.data ?? []).map((row) => byId.get(row.item_id)).filter((x): x is PublishedCard => Boolean(x));
  };
  const favLessons = pick(lessons);
  const favAdhkar = pick(adhkar);
  const item = (href: string, card: PublishedCard, label: string) => (
    <li key={card.id} data-favorite-item={card.slug}>
      <Link href={href} className="block py-3">
        <span className="block text-base text-muted">{label}</span>
        <span className="block font-medium">{card.title}</span>
      </Link>
    </li>
  );
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/profil" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{t.profile.title}</Link>
      <h1 className="text-3xl">{f.title}</h1>
      <p className="mt-2 text-muted">{f.intro}</p>
      {favLessons.length + favAdhkar.length === 0 ? <p className="mt-6 font-medium" data-favorites-empty>{f.empty}</p> : null}
      {favLessons.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{f.lessons}</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line" data-favorites="lessons">
            {favLessons.map((l) => item(`/apprendre/${l.slug}`, l, sections[l.section] ?? l.section))}
          </ul>
        </section>
      ) : null}
      {favAdhkar.length ? (
        <section className="mt-6">
          <h2 className="text-xl">{f.adhkar}</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line" data-favorites="adhkar">
            {favAdhkar.map((d) => item(`/priere/invocations/${d.slug}`, d, f.adhkar))}
          </ul>
        </section>
      ) : null}
      <Link href="/coran/signets" className="mt-6 flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{f.verses}</Link>
    </main>
  );
}
