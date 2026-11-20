// Dépose une version de l'application Android dans l'espace public « downloads ».
// Appel réservé : en-tête x-release-token égal au secret du coffre. Source limitée aux espaces de compilation Vercel.
import { createClient } from "jsr:@supabase/supabase-js@2";

const db = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } });
const hex = (buf: ArrayBuffer) => [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, "0")).join("");

Deno.serve(async (req) => {
  if (req.method !== "POST") return json({ error: "method" }, 405);
  const { data: token } = await db.rpc("release_secret");
  if (!token || req.headers.get("x-release-token") !== token) return json({ error: "forbidden" }, 403);
  const { source, name } = await req.json().catch(() => ({}));
  if (typeof source !== "string" || !/^https:\/\/sb-[a-z0-9]+\.vercel\.run\/[\w.-]+\.apk$/.test(source)) return json({ error: "source" }, 400);
  if (typeof name !== "string" || !/^android\/nour-al-islam-\d+\.\d+\.\d+\.apk$/.test(name)) return json({ error: "name" }, 400);
  const res = await fetch(source);
  if (!res.ok) return json({ error: "download", status: res.status }, 502);
  const bytes = await res.arrayBuffer();
  const sha256 = hex(await crypto.subtle.digest("SHA-256", bytes));
  const { error } = await db.storage.from("downloads").upload(name, bytes, { contentType: "application/vnd.android.package-archive", upsert: false });
  if (error) return json({ error: error.message, sha256, size: bytes.byteLength }, 409);
  return json({ ok: true, name, sha256, size: bytes.byteLength });
});
