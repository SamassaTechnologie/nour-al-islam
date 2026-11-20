import { NextResponse, type NextRequest } from "next/server";
import { AudioUnavailable, getAudioFiles, getChapterAudio, getChapterReciters, getRecitations } from "@/lib/quran-audio";

const headers = { "Cache-Control": "public, s-maxage=86400, stale-while-revalidate=3600" };

export async function GET(request: NextRequest) {
  const params = request.nextUrl.searchParams;
  const rawReciter = params.get("reciter");
  const rawRecitation = params.get("recitation");
  const rawSurah = params.get("surah");
  try {
    if (params.has("chapters")) {
      return NextResponse.json({ reciters: await getChapterReciters() }, { headers });
    }
    if (rawReciter !== null) {
      const reciter = Number(rawReciter);
      const surah = Number(rawSurah);
      if (!Number.isInteger(reciter) || reciter < 1 || reciter > 9999 || !Number.isInteger(surah) || surah < 1 || surah > 114) {
        return NextResponse.json({ error: "Paramètres invalides" }, { status: 400 });
      }
      return NextResponse.json({ chapter: await getChapterAudio(reciter, surah) }, { headers });
    }
    if (rawRecitation === null && rawSurah === null) {
      return NextResponse.json({ recitations: await getRecitations() }, { headers });
    }
    const recitation = Number(rawRecitation);
    const surah = Number(rawSurah);
    if (!Number.isInteger(recitation) || recitation < 1 || recitation > 9999 || !Number.isInteger(surah) || surah < 1 || surah > 114) {
      return NextResponse.json({ error: "Paramètres invalides" }, { status: 400 });
    }
    return NextResponse.json({ files: await getAudioFiles(recitation, surah) }, { headers });
  } catch (error) {
    const status = error instanceof AudioUnavailable ? error.status : 500;
    console.error("Audio indisponible", error instanceof Error ? error.message : "erreur inconnue");
    return NextResponse.json({ error: "Audio indisponible", upstream: status }, { status: 503, headers: { "Cache-Control": "no-store" } });
  }
}
