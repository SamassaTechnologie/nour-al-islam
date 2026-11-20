"use server";

const FUNCTION_URL = `${process.env.NEXT_PUBLIC_SUPABASE_URL}/functions/v1/push`;
const headers = () => ({ "Content-Type": "application/json", apikey: process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ?? "" });

export type PushSettings = { lat: number; lng: number; tz: string; method: string; asr: "standard" | "hanafi"; prayers: boolean; adhkar: boolean; locale: "fr" | "ar" };
type Subscription = { endpoint: string; keys: { p256dh: string; auth: string } };

/** Cle publique d'envoi (VAPID) : elle identifie notre serveur aupres du service de notifications. */
export async function getPushKey(): Promise<string | null> {
  try {
    const res = await fetch(FUNCTION_URL, { headers: headers(), cache: "no-store" });
    return res.ok ? ((await res.json()).publicKey as string) : null;
  } catch { return null; }
}

export async function savePushSubscription(subscription: Subscription, settings: PushSettings): Promise<boolean> {
  try {
    const res = await fetch(FUNCTION_URL, { method: "POST", headers: headers(), body: JSON.stringify({ action: "subscribe", subscription, settings }) });
    return res.ok;
  } catch { return false; }
}

export async function removePushSubscription(endpoint: string): Promise<boolean> {
  try {
    const res = await fetch(FUNCTION_URL, { method: "POST", headers: headers(), body: JSON.stringify({ action: "unsubscribe", endpoint }) });
    return res.ok;
  } catch { return false; }
}
