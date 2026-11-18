"use server";

import { createClient, getSession } from "@/lib/supabase/server";

const validAyah = (id: number) => Number.isInteger(id) && id >= 1 && id <= 6236;

export async function toggleBookmark(ayahId: number): Promise<boolean | null> {
  const session = await getSession();
  if (!session || !validAyah(ayahId)) return null;
  const supabase = await createClient();
  const removed = await supabase.from("quran_bookmarks").delete().eq("user_id", session.user.id).eq("ayah_id", ayahId).select("ayah_id");
  if (removed.error) return null;
  if (removed.data.length > 0) return false;
  const { error } = await supabase.from("quran_bookmarks").insert({ user_id: session.user.id, ayah_id: ayahId });
  return error ? null : true;
}

export async function saveReading(surah: number, ayahId: number) {
  const session = await getSession();
  if (!session || !validAyah(ayahId) || !Number.isInteger(surah) || surah < 1 || surah > 114) return;
  const supabase = await createClient();
  await supabase.from("quran_reading_history").upsert(
    { user_id: session.user.id, surah, ayah_id: ayahId, updated_at: new Date().toISOString() },
    { onConflict: "user_id,surah" },
  );
}
