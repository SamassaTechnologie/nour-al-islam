// Rappels : test de bout en bout du serveur d'envoi (fonction Edge « push » + minuterie pg_cron).
// Un faux service de notifications ecoute sur PORT ; son adresse publique est PUBLIC_URL.
// L'abonnement est place a une longitude ou le dhuhr vient de passer : la minuterie doit envoyer le rappel,
// une seule fois, chiffre pour notre cle ; un point d'envoi qui repond 410 doit etre supprime.
// npm i adhan@4.4.6 http_ece@1.2.0 ; placer prayer-times.ts a cote ; node --experimental-strip-types.
import http from "node:http";
import crypto from "node:crypto";
import ece from "http_ece";
import { computeTimes, localDate } from "./prayer-times.ts";

const { PUBLIC_URL, PORT = "3000", SUPABASE_URL, SUPABASE_KEY } = process.env;
const FN = `${SUPABASE_URL}/functions/v1/push`;
let failed = 0;
const check = (label, ok, detail = "") => { if (!ok) failed++; console.log(`${ok ? "OK   " : "ECHEC"} ${label}${detail ? ` : ${detail}` : ""}`); };
const call = async (body) => { const r = await fetch(FN, { method: body ? "POST" : "GET", headers: { "Content-Type": "application/json", apikey: SUPABASE_KEY }, body: body && JSON.stringify(body) }); return [r.status, await r.json()]; };

// Cles du « navigateur » de test.
const ecdh = crypto.createECDH("prime256v1");
ecdh.generateKeys();
const authSecret = crypto.randomBytes(16);
const b64u = (b) => Buffer.from(b).toString("base64url");
const received = [];
let goneHits = 0;
const server = http.createServer((req, res) => {
  const chunks = [];
  req.on("data", (c) => chunks.push(c));
  req.on("end", () => {
    if (req.url.startsWith("/gone")) { goneHits++; res.writeHead(410).end(); return; }
    received.push({ url: req.url, headers: req.headers, body: Buffer.concat(chunks) });
    res.writeHead(201).end();
  });
});
await new Promise((r) => server.listen(Number(PORT), r));

// Ni la minuterie ni personne d'autre ne peut declencher l'envoi sans le jeton.
const [forbidden] = await call({ action: "tick" });
check("envoi sans jeton refusé", forbidden === 403, String(forbidden));
const [keyStatus, keyBody] = await call();
check("clé publique disponible", keyStatus === 200 && typeof keyBody.publicKey === "string" && keyBody.publicKey.length > 60);
const [bad] = await call({ action: "subscribe", subscription: { endpoint: "http://x", keys: {} }, settings: {} });
check("abonnement invalide refusé", bad === 400, String(bad));

// Longitude ou le dhuhr (UTC) est passe depuis 1 a 2 minutes.
const now = new Date();
let lng = null;
for (let x = -179; x <= 179; x += 0.05) {
  const t = computeTimes({ lat: 10, lng: x }, localDate(now, "UTC"), "MuslimWorldLeague", "standard").dhuhr;
  const late = now.getTime() - t.getTime();
  if (late > 50_000 && late < 120_000) { lng = Math.round(x * 100) / 100; break; }
}
check("lieu de test trouvé", lng !== null, String(lng));
const settings = { lat: 10, lng, tz: "UTC", method: "MuslimWorldLeague", asr: "standard", prayers: true, adhkar: false, locale: "fr" };
const endpoint = `${PUBLIC_URL}/push/${crypto.randomUUID()}`;
const [okStatus] = await call({ action: "subscribe", subscription: { endpoint, keys: { p256dh: b64u(ecdh.getPublicKey()), auth: b64u(authSecret) } }, settings });
check("abonnement enregistré", okStatus === 200, String(okStatus));
const goneEndpoint = `${PUBLIC_URL}/gone/${crypto.randomUUID()}`;
await call({ action: "subscribe", subscription: { endpoint: goneEndpoint, keys: { p256dh: b64u(ecdh.getPublicKey()), auth: b64u(authSecret) } }, settings });

// Attendre la minuterie (au plus ~75 s).
for (let i = 0; i < 40 && (received.length === 0 || goneHits === 0); i++) await new Promise((r) => setTimeout(r, 2500));
check("rappel reçu de la minuterie", received.length === 1, String(received.length));
if (received[0]) {
  const h = received[0].headers;
  check("en-têtes Web Push (aes128gcm, VAPID, durée de vie)", h["content-encoding"] === "aes128gcm" && /^vapid t=.+, k=/.test(h.authorization ?? "") && Number(h.ttl) > 0, `${h["content-encoding"]} ${String(h.authorization).slice(0, 12)} ttl=${h.ttl}`);
  const plain = ece.decrypt(received[0].body, { version: "aes128gcm", privateKey: ecdh, authSecret: b64u(authSecret) });
  const msg = JSON.parse(plain.toString("utf8"));
  check("contenu déchiffré : rappel du Dhuhr, lien vers les horaires", msg.title.startsWith("Dhuhr ·") && msg.body.includes("Dhuhr") && msg.url === "/priere/horaires" && msg.tag === "dhuhr", JSON.stringify(msg));
}
check("point d'envoi expiré (410) contacté", goneHits >= 1, String(goneHits));

// Pas de double envoi a la minute suivante.
await new Promise((r) => setTimeout(r, 65_000));
check("aucun second envoi pour la même prière", received.length === 1, String(received.length));

// Desabonnement.
const [un] = await call({ action: "unsubscribe", endpoint });
check("désabonnement accepté", un === 200);
console.log("NOTE verifier en base : 0 abonnement de test restant (point expire supprime, desabonnement efface)");
server.close();
console.log("ECHECS", failed);
process.exit(failed ? 1 : 0);
