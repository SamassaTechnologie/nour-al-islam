import type { ReactNode } from "react";
import Link from "next/link";
import { Star } from "@/components/art";
import type { Dictionary } from "@/lib/dictionaries";

type Section = Dictionary["soon"]["quran"];

// `label` remplace « pas encore ouverte » quand une partie est deja ouverte ; `links` rend la liste cliquable.
export function ComingSection({ section, t, children, label, intro, links }: { section: Section; t: Dictionary["soon"]; children?: ReactNode; label?: string; intro?: string; links?: (string | null)[] }) {
  return (
    <main className="mx-auto max-w-xl px-5 pt-8">
      <h1 className="text-3xl">{section.title}</h1>
      <p className="mt-3 border-s-2 border-gold ps-3 font-medium" data-section-status>{label ?? t.label}</p>
      <p className="mt-3 text-muted">{intro ?? section.intro}</p>
      {children}
      <h2 className="mt-8 text-xl">{t.planned}</h2>
      <ul className="mt-3 space-y-2">
        {section.items.map((item, index) => {
          const href = links?.[index];
          return (
            <li key={item} className="flex gap-3">
              <Star className="mt-2 h-3 w-3 shrink-0 text-gold-ink" />
              {href ? <Link href={href} className="text-emerald underline underline-offset-4" data-planned-link>{item}</Link> : <span>{item}</span>}
            </li>
          );
        })}
      </ul>
      <Link href="/" className="mt-8 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.back}</Link>
    </main>
  );
}
