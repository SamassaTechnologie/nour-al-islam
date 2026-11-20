// Rappels Web Push de NOUR AL-ISLAM.
// - GET            : cle publique VAPID (creee au premier appel, cle privee gardee dans le coffre Vault).
// - subscribe      : enregistre ou met a jour un abonnement (appele par le serveur Next.js).
// - unsubscribe    : supprime un abonnement.
// - tick           : appele chaque minute par pg_cron (jeton secret) ; envoie les rappels dus.
import { createClient } from "npm:@supabase/supabase-js@2.49.1";
import webpush from "npm:web-push@3.6.7";
import { CalculationMethod, Coordinates, HighLatitudeRule, Madhab, PrayerTimes } from "npm:adhan@4.4.6";

const db = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
const METHODS = ["MuslimWorldLeague", "UmmAlQura", "Egyptian", "Karachi", "NorthAmerica", "Dubai", "Kuwait", "Qatar", "Turkey", "MoonsightingCommittee", "Singapore"];
const PRAYERS = ["fajr", "dhuhr", "asr", "maghrib", "isha"] as const;
const WINDOW_MS = 10 * 60_000; // un rappel manque de plus de 10 minutes n'est plus envoye
const ADHKAR_DELAY_MS = 30 * 60_000; // invocations : 30 minutes apres le fajr et apres le ʿasr

const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } });
const secret = async (name: string) => (await db.rpc("push_secret", { p_name: name })).data as string | null;

async function vapid() {
  let pub = await secret("vapid_public");
  let priv = await secret("vapid_private");
  if (!pub || !priv) {
    const keys = webpush.generateVAPIDKeys();
    const { error } = await db.rpc("push_store_vapid", { p_public: keys.publicKey, p_private: keys.privateKey });
    if (error) throw new Error(error.message);
    pub = await secret("vapid_public");
    priv = await secret("vapid_private");
  }
  return { pub: pub!, priv: priv! };
}

function validTz(tz: string) {
  try { new Intl.DateTimeFormat("fr", { timeZone: tz }); return true; } catch { return false; }
}

function localDay(now: Date, tz: string) {
  const p = new Intl.DateTimeFormat("en-CA", { timeZone: tz, year: "numeric", month: "2-digit", day: "2-digit" }).formatToParts(now);
  const g = (t: string) => Number(p.find((x) => x.type === t)!.value);
  return { year: g("year"), month: g("month"), day: g("day") };
}

// Meme calcul que src/lib/prayer-times.ts (bibliotheque adhan 4.4.6).
function times(lat: number, lng: number, day: { year: number; month: number; day: number }, method: string, asr: string) {
  const params = (CalculationMethod as Record<string, () => ReturnType<typeof CalculationMethod.MuslimWorldLeague>>)[method]();
  params.madhab = asr === "hanafi" ? Madhab.Hanafi : Madhab.Shafi;
  if (Math.abs(lat) > 48) params.highLatitudeRule = HighLatitudeRule.recommended(new Coordinates(lat, lng));
  // Deno tourne en UTC : on construit le jour du lieu a midi UTC pour qu'adhan lise la bonne date.
  return new PrayerTimes(new Coordinates(lat, lng), new Date(Date.UTC(day.year, day.month - 1, day.day, 12)), params);
}

const TEXT = {
  fr: {
    names: { fajr: "Fajr", dhuhr: "Dhuhr", asr: "ʿAṣr", maghrib: "Maghrib", isha: "ʿIshāʾ" },
    prayer: (n: string, h: string) => [`${n} · ${h}`, `C’est l’heure de la prière de ${n}.`],
    morning: ["Invocations du matin", "Un moment pour les invocations du matin."],
    evening: ["Invocations du soir", "Un moment pour les invocations du soir."],
  },
  ar: {
    names: { fajr: "الفجر", dhuhr: "الظهر", asr: "العصر", maghrib: "المغرب", isha: "العشاء" },
    prayer: (n: string, h: string) => [`${n} · ${h}`, `حان الآن وقت صلاة ${n}.`],
    morning: ["أذكار الصباح", "وقت لأذكار الصباح."],
    evening: ["أذكار المساء", "وقت لأذكار المساء."],
  },
};

type Sub = { id: string; endpoint: string; p256dh: string; auth: string; lat: number; lng: number; tz: string; method: string; asr: string; prayers: boolean; adhkar: boolean; locale: "fr" | "ar"; sent: Record<string, string> };

async function tick() {
  const { pub, priv } = await vapid();
  webpush.setVapidDetails("https://nour-al-islam.vercel.app", pub, priv);
  const { data, error } = await db.from("push_subscriptions").select("*").limit(5000);
  if (error) throw new Error(error.message);
  const now = new Date();
  let sentCount = 0, removed = 0;
  for (const s of (data ?? []) as Sub[]) {
    const day = localDay(now, s.tz);
    const key = `${day.year}-${day.month}-${day.day}`;
    const pt = times(Number(s.lat), Number(s.lng), day, s.method, s.asr);
    const tx = TEXT[s.locale] ?? TEXT.fr;
    const hour = (d: Date) => new Intl.DateTimeFormat(s.locale === "ar" ? "ar" : "fr-FR", { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: s.tz }).format(d);
    const events: { id: string; at: Date; title: string; body: string; url: string }[] = [];
    if (s.prayers) for (const p of PRAYERS) {
      const [title, body] = tx.prayer(tx.names[p], hour(pt[p]));
      events.push({ id: p, at: pt[p], title, body, url: "/priere/horaires" });
    }
    if (s.adhkar) {
      events.push({ id: "morning", at: new Date(pt.fajr.getTime() + ADHKAR_DELAY_MS), title: tx.morning[0], body: tx.morning[1], url: "/priere/invocations/adhkar-matin-et-soir" });
      events.push({ id: "evening", at: new Date(pt.asr.getTime() + ADHKAR_DELAY_MS), title: tx.evening[0], body: tx.evening[1], url: "/priere/invocations/adhkar-matin-et-soir" });
    }
    const sent = { ...s.sent };
    let changed = false, gone = false;
    for (const e of events) {
      const late = now.getTime() - e.at.getTime();
      if (late < 0 || late > WINDOW_MS || sent[e.id] === key) continue;
      try {
        await webpush.sendNotification({ endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } }, JSON.stringify({ title: e.title, body: e.body, url: e.url, tag: e.id }), { TTL: 600 });
        sentCount++;
      } catch (err) {
        const code = (err as { statusCode?: number }).statusCode;
        if (code === 404 || code === 410) { gone = true; break; }
        console.error("envoi", code ?? String(err));
      }
      sent[e.id] = key; changed = true;
    }
    if (gone) { await db.from("push_subscriptions").delete().eq("id", s.id); removed++; }
    else if (changed) await db.from("push_subscriptions").update({ sent }).eq("id", s.id);
  }
  return { subscriptions: data?.length ?? 0, sent: sentCount, removed };
}

Deno.serve(async (req) => {
  try {
    if (req.method === "GET") return json({ publicKey: (await vapid()).pub });
    if (req.method !== "POST") return json({ error: "method" }, 405);
    const body = await req.json().catch(() => ({}));
    if (body.action === "tick") {
      const token = await secret("push_cron_token");
      if (!token || req.headers.get("x-cron-token") !== token) return json({ error: "forbidden" }, 403);
      return json(await tick());
    }
    if (body.action === "unsubscribe") {
      if (typeof body.endpoint !== "string") return json({ error: "endpoint" }, 400);
      await db.from("push_subscriptions").delete().eq("endpoint", body.endpoint);
      return json({ ok: true });
    }
    if (body.action === "subscribe") {
      const sub = body.subscription, st = body.settings;
      const ok = sub && typeof sub.endpoint === "string" && sub.endpoint.startsWith("https://") && sub.endpoint.length <= 1000
        && typeof sub.keys?.p256dh === "string" && typeof sub.keys?.auth === "string"
        && st && Number.isFinite(st.lat) && Math.abs(st.lat) <= 90 && Number.isFinite(st.lng) && Math.abs(st.lng) <= 180
        && typeof st.tz === "string" && validTz(st.tz) && METHODS.includes(st.method) && (st.asr === "standard" || st.asr === "hanafi")
        && typeof st.prayers === "boolean" && typeof st.adhkar === "boolean" && (st.locale === "fr" || st.locale === "ar");
      if (!ok) return json({ error: "invalid" }, 400);
      const row = {
        endpoint: sub.endpoint, p256dh: sub.keys.p256dh, auth: sub.keys.auth,
        lat: Math.round(st.lat * 100) / 100, lng: Math.round(st.lng * 100) / 100, tz: st.tz, method: st.method, asr: st.asr,
        prayers: st.prayers, adhkar: st.adhkar, locale: st.locale, updated_at: new Date().toISOString(),
      };
      const { error } = await db.from("push_subscriptions").upsert(row, { onConflict: "endpoint" });
      if (error) return json({ error: "save" }, 500);
      return json({ ok: true });
    }
    return json({ error: "action" }, 400);
  } catch (e) {
    console.error(String(e));
    return json({ error: "server" }, 500);
  }
});
