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

/** Paragraphe commencant par de l'arabe (texte d'un hadith, par exemple) : police arabe, plus grande, de droite a gauche. */
const ARABIC_START = /^[\u0600-\u06FF]/;

export const Paragraphs = ({ text }: { text: string }) => text.split(/\n\s*\n/).filter((part) => part.trim()).map((part, index) => {
  const arabic = ARABIC_START.test(part.trim());
  return <p key={index} dir="auto" lang={arabic ? "ar" : undefined} className={`mt-3 whitespace-pre-line text-start ${arabic ? "arabic-text" : ""}`}>{part.trim()}</p>;
});
