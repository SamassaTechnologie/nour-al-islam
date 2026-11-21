import { NextResponse } from "next/server";
import { AudioUnavailable, quranApi } from "@/lib/quran-audio";

// Verification provisoire : langues du mot a mot disponibles chez Quran Foundation (aucun contenu garde).
export async function GET(request: Request) {
  const params = new URL(request.url).searchParams;
  const lang = /^[a-z]{2}$/.test(params.get("lang") ?? "") ? params.get("lang")! : "fr";
  try {
    const verse = await quranApi<{ verse: { words: { char_type_name: string; text_uthmani?: string; translation?: { text: string; language_name: string } }[] } }>(
      `/verses/by_key/1:2?words=true&word_fields=text_uthmani&language=${lang}`,
    );
    const words = verse.verse.words.filter((w) => w.char_type_name === "word").map((w) => ({ lang: w.translation?.language_name, text: w.translation?.text }));
    return NextResponse.json({ lang, words }, { headers: { "Cache-Control": "no-store" } });
  } catch (error) {
    const status = error instanceof AudioUnavailable ? error.status : 500;
    return NextResponse.json({ error: "indisponible", upstream: status }, { status: 503 });
  }
}
