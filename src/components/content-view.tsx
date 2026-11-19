import type { Reference } from "@/lib/admin";
import type { Surah } from "@/lib/quran";

export function referenceText(ref: Reference, surahs: Surah[]) {
  if (ref.kind === "quran") {
    const verses = ref.ayah_from === ref.ayah_to ? `${ref.ayah_from}` : `${ref.ayah_from}-${ref.ayah_to}`;
    return `Sourate ${surahs[(ref.surah ?? 1) - 1]?.name_translit} (${ref.surah}), verset ${verses}`;
  }
  if (ref.kind === "hadith") return `${ref.collection}, n° ${ref.hadith_number}, ${ref.edition}. Source : ${ref.source_title}. Degré : ${ref.grade} (${ref.graded_by})`;
  return `${ref.author}, ${ref.source_title}, ${ref.locator}`;
}

export const Paragraphs = ({ text }: { text: string }) => text.split(/\n\s*\n/).filter((part) => part.trim()).map((part, index) => <p key={index} className="mt-3 whitespace-pre-line">{part.trim()}</p>);
