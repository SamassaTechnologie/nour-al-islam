import type { ReactNode } from "react";
import Link from "next/link";
import { Star } from "@/components/art";
import type { Dictionary } from "@/lib/dictionaries";

type Section = Dictionary["soon"]["quran"];

export function ComingSection({ section, t, children }: { section: Section; t: Dictionary["soon"]; children?: ReactNode }) {
  return (
    <main className="mx-auto max-w-xl px-5 pt-8">
      <h1 className="text-3xl">{section.title}</h1>
      <p className="mt-3 border-s-2 border-gold ps-3 font-medium">{t.label}</p>
      <p className="mt-3 text-muted">{section.intro}</p>
      {children}
      <h2 className="mt-8 text-xl">{t.planned}</h2>
      <ul className="mt-3 space-y-2">
        {section.items.map((item) => (
          <li key={item} className="flex gap-3">
            <Star className="mt-2 h-3 w-3 shrink-0 text-gold-ink" />
            <span>{item}</span>
          </li>
        ))}
      </ul>
      <Link href="/" className="mt-8 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.back}</Link>
    </main>
  );
}
