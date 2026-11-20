"use server";

import { createClient, getSession } from "@/lib/supabase/server";

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/** Ajoute ou retire un contenu des favoris. Renvoie le nouvel etat, ou null en cas d'echec. */
export async function toggleFavorite(itemId: string): Promise<boolean | null> {
  const session = await getSession();
  if (!session || !UUID.test(itemId)) return null;
  const supabase = await createClient();
  const removed = await supabase.from("favorites").delete().eq("user_id", session.user.id).eq("item_id", itemId).select("item_id");
  if (removed.error) return null;
  if (removed.data.length > 0) return false;
  const { error } = await supabase.from("favorites").insert({ user_id: session.user.id, item_id: itemId });
  return error ? null : true;
}
