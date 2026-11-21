import { NextResponse } from "next/server";
import { AudioUnavailable } from "@/lib/quran-audio";
import { getSurahWords } from "@/lib/quran-words";
import { getSession } from "@/lib/supabase/server";

const STAFF = new Set(["editor", "reviewer", "admin"]);

// Mot a mot d'une sourate : equipe connectee seulement, en attendant la validation des savants.
export async function GET(request: Request) {
  const session = await getSession();
  if (!session?.profile || !STAFF.has(session.profile.role)) return NextResponse.json({ error: "Réservé à l’équipe" }, { status: 403 });
  const surah = Number(new URL(request.url).searchParams.get("surah"));
  if (!Number.isInteger(surah) || surah < 1 || surah > 114) return NextResponse.json({ error: "Paramètres invalides" }, { status: 400 });
  try {
    return NextResponse.json({ verses: await getSurahWords(surah) }, { headers: { "Cache-Control": "private, no-store" } });
  } catch (error) {
    const status = error instanceof AudioUnavailable ? error.status : 500;
    return NextResponse.json({ error: "Mot à mot indisponible", upstream: status }, { status: 503 });
  }
}
