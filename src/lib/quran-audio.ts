import { unstable_cache } from "next/cache";

export type Recitation = { id: number; name: string; style: string | null };
export type AudioFile = { number: number; url: string };

export class AudioUnavailable extends Error {
  constructor(public readonly status: number, step: string) {
    super(`Quran Foundation ${step} : ${status}`);
  }
}

const AUDIO_HOST = "https://verses.quran.foundation/";
const DAY = 86400;

function config() {
  const clientId = process.env.QF_CLIENT_ID;
  const clientSecret = process.env.QF_CLIENT_SECRET;
  if (!clientId || !clientSecret) throw new AudioUnavailable(503, "configuration");
  const production = process.env.QF_ENV === "production";
  return {
    clientId,
    clientSecret,
    oauth: production ? "https://oauth2.quran.foundation" : "https://prelive-oauth2.quran.foundation",
    api: production ? "https://apis.quran.foundation" : "https://apis-prelive.quran.foundation",
  };
}

const AUDIO_SCOPES = ["content.audio.read"];
const QURAN_SCOPES = ["content.quran.read", "content"];
const tokens = new Map<string, { value: string; expiresAt: number }>();

async function accessToken(scopes: string[]) {
  const key = scopes.join(" ");
  const known = tokens.get(key);
  if (known && known.expiresAt > Date.now() + 60_000) return known.value;
  const { clientId, clientSecret, oauth } = config();
  let status = 500;
  for (const scope of scopes) {
    const res = await fetch(`${oauth}/oauth2/token`, {
      method: "POST",
      cache: "no-store",
      headers: {
        Authorization: `Basic ${Buffer.from(`${clientId}:${clientSecret}`).toString("base64")}`,
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({ grant_type: "client_credentials", scope }),
    });
    status = res.status;
    if (!res.ok) continue;
    const data = (await res.json()) as { access_token: string; expires_in: number };
    const token = { value: data.access_token, expiresAt: Date.now() + data.expires_in * 1000 };
    tokens.set(key, token);
    return token.value;
  }
  throw new AudioUnavailable(status, "jeton");
}

async function api<T>(path: string, scopes = AUDIO_SCOPES): Promise<T> {
  const { clientId, api: base } = config();
  const res = await fetch(`${base}/content/api/v4${path}`, {
    cache: "no-store",
    headers: { "x-auth-token": await accessToken(scopes), "x-client-id": clientId, Accept: "application/json" },
  });
  if (!res.ok) throw new AudioUnavailable(res.status, "contenu");
  return (await res.json()) as T;
}

export const quranApi = <T>(path: string) => api<T>(path, QURAN_SCOPES);

const PREFERRED = [/sudais/i, /afasy/i, /mu.?aiqly|muaiqly/i, /abdul.?basit|abdulbaset/i, /minshaw/i, /husar|hussar/i];
const rank = (name: string) => {
  const index = PREFERRED.findIndex((re) => re.test(name));
  return index < 0 ? PREFERRED.length : index;
};

export function audioUrl(url: string) {
  if (url.startsWith("//")) return `https:${url}`;
  if (/^https:\/\//.test(url)) return url;
  return new URL(url.replace(/^\/+/, ""), AUDIO_HOST).toString();
}

export const getRecitations = unstable_cache(
  async (): Promise<Recitation[]> => {
    const data = await api<{ recitations: { id: number; reciter_name: string; style: string | null }[] }>("/resources/recitations?language=en");
    return data.recitations
      .map((r) => ({ id: r.id, name: r.reciter_name, style: r.style }))
      .sort((a, b) => rank(a.name) - rank(b.name) || a.name.localeCompare(b.name));
  },
  ["qf-recitations-v1"],
  { revalidate: DAY },
);

export const getAudioFiles = unstable_cache(
  async (recitation: number, surah: number): Promise<AudioFile[]> => {
    const data = await api<{ audio_files: { verse_key: string; url: string }[] }>(`/quran/recitations/${recitation}?chapter_number=${surah}`);
    return data.audio_files
      .map((file) => ({ number: Number(file.verse_key.split(":")[1]), url: audioUrl(file.url) }))
      .sort((a, b) => a.number - b.number);
  },
  ["qf-audio-files-v1"],
  { revalidate: DAY },
);
