import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ArabicVerse } from "@/components/quran-view";
import { getBismillah, getSurahs, getSurahVerses, verseBody } from "@/lib/quran";
import { firstEntryByAyah, getSurahTafsir, getTafsirSource, type TafsirKey } from "@/lib/tafsir";
import { getPreferences } from "@/lib/preferences";

type Props = { params: Promise<{ sourate: string }>; searchParams: Promise<{ source?: string }> };

async function load(params: Props["params"]) {
  const { sourate } = await params;
  if (!/^\d{1,3}$/.test(sourate)) notFound();
  const surahs = await getSurahs();
  const surah = surahs[Number(sourate) - 1];
  if (!surah) notFound();
  return { surah, surahs };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { surah } = await load(params);
  return { title: `Tafsir de la sourate ${surah.name_translit}` };
}

/** Types d'entrées d'as-Saʿdī, tels que la source les nomme. */
const SAADI_TITLE = "اسم السورة";
const SAADI_PLACE = "مكان نزول السورة";
const SAADI_PASSAGE = "المقطع";

export default async function TafsirPage({ params, searchParams }: Props) {
  const { surah, surahs } = await load(params);
  const key: TafsirKey = (await searchParams).source === "saadi" ? "saadi" : "fr";
  const [{ t }, verses, entries, source, bismillah] = await Promise.all([
    getPreferences(),
    getSurahVerses(surah.number),
    getSurahTafsir(key, surah.number),
    getTafsirSource(key),
    getBismillah(),
  ]);
  const q = t.quran;
  const previous = surahs[surah.number - 2];
  const next = surahs[surah.number];
  const byNumber = new Map(entries.filter((e) => e.from_ayah > 0).map((e) => [e.from_ayah, e]));
  const anchors = key === "saadi" ? firstEntryByAyah(entries, surah.ayah_count) : null;
  const anchorsAt = new Map<number, number[]>();
  anchors?.forEach((entryId, ayah) => anchorsAt.set(entryId, [...(anchorsAt.get(entryId) ?? []), ayah]));
  const tab = (k: TafsirKey, label: string) => (
    <Link
      href={`/coran/${surah.number}/tafsir${k === "saadi" ? "?source=saadi" : ""}`}
      aria-current={k === key ? "page" : undefined}
      data-tafsir-tab={k}
      className={`inline-flex min-h-11 flex-1 items-center justify-center rounded-lg border px-3 text-center text-base font-medium ${k === key ? "border-emerald bg-emerald text-on-emerald" : "border-line text-emerald"}`}
    >
      {label}
    </Link>
  );

  return (
    <main className="mx-auto max-w-xl px-5 pt-5 pb-16">
      <Link href={`/coran/${surah.number}`} className="inline-flex min-h-11 items-center text-base text-muted underline underline-offset-4">{q.backToSurah}</Link>
      <header className="py-3 text-center">
        <p lang="ar" dir="rtl" className="wordmark text-4xl leading-normal text-emerald">{surah.name_ar}</p>
        <h1 className="text-2xl">{q.tafsirOf} <span lang="en" dir="ltr">{surah.number}. {surah.name_translit}</span></h1>
      </header>
      <nav aria-label={q.tafsir} className="flex gap-2">
        {tab("fr", q.tafsirFr)}
        {tab("saadi", q.tafsirAr)}
      </nav>
      {/* Audio : lecteur officiel de QuranEnc (site externe), en attendant leur accord pour l'integrer. */}
      <a href="https://quranenc.com/ar/audio/player/arabic_mokhtasar" target="_blank" rel="noopener noreferrer" className="mt-3 flex min-h-12 items-center gap-3 rounded-lg border border-line px-4 hover:border-gold" data-tafsir-audio>
        <svg aria-hidden="true" viewBox="0 0 24 24" className="h-6 w-6 shrink-0 text-gold-ink" fill="none" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round"><path d="M4 14v-2a8 8 0 0 1 16 0v2M4 14h3v6H5a1 1 0 0 1-1-1zM20 14h-3v6h2a1 1 0 0 0 1-1z" /></svg>
        <span className="min-w-0 flex-1">
          <span className="block font-medium">{q.tafsirAudio}</span>
          <span className="block text-base text-muted">{q.tafsirAudioNote}</span>
        </span>
        <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 shrink-0 text-muted"><path d="M14 4h6v6M20 4l-9 9M18 14v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h5" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" /></svg>
      </a>

      {key === "fr" ? (
        <ol className="mt-4" data-tafsir="fr">
          {verses.map((verse) => {
            const entry = byNumber.get(verse.number);
            return (
              <li key={verse.id} id={`t${verse.number}`} data-tafsir-verse={verse.number} className="scroll-mt-14 border-b border-line py-5">
                <Link href={`/coran/${surah.number}#v${surah.number}-${verse.number}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{surah.number}:{verse.number}</Link>
                {verse.bismillah_length > 0 ? <ArabicVerse text={bismillah} className="mb-4 text-center" /> : null}
                <ArabicVerse text={verseBody(verse.text_uthmani, verse.bismillah_length)} />
                {entry ? (
                  <div lang="fr" dir="ltr" className="mt-3 rounded-lg bg-tint p-4" data-tafsir-text>
                    <p className="whitespace-pre-line">{entry.text}</p>
                    {entry.footnotes ? <p className="mt-2 text-base whitespace-pre-line text-muted">{entry.footnotes}</p> : null}
                  </div>
                ) : null}
              </li>
            );
          })}
        </ol>
      ) : (
        <div className="mt-4" lang="ar" dir="rtl" data-tafsir="saadi">
          {entries.map((e) => {
            const ids = anchorsAt.get(e.entry_id) ?? [];
            const marks = ids.map((n) => <span key={n} id={`t${n}`} className="block scroll-mt-14" aria-hidden="true" />);
            if (e.entry_type === SAADI_TITLE) return <div key={e.entry_id}>{marks}<h2 className="mt-6 text-center text-xl">{e.text}</h2></div>;
            if (e.entry_type === SAADI_PLACE) return <div key={e.entry_id}>{marks}<p className="text-center text-base text-muted">{e.text}</p></div>;
            if (e.entry_type === SAADI_PASSAGE) {
              return (
                <div key={e.entry_id} data-tafsir-passage={`${e.from_ayah}-${e.to_ayah}`} className="mt-6 border-t border-line pt-4">
                  {marks}
                  <p className="text-base text-muted" dir="ltr" lang="fr">{surah.number}:{e.from_ayah}{e.to_ayah > e.from_ayah ? `-${e.to_ayah}` : ""}</p>
                  <p className="quran-text whitespace-pre-line">{e.text}</p>
                </div>
              );
            }
            return <div key={e.entry_id}>{marks}<p className="arabic-text mt-3 whitespace-pre-line" data-tafsir-text>{e.text}</p></div>;
          })}
        </div>
      )}

      <nav aria-label={q.browse} className="mt-6 flex justify-between gap-3">
        {previous ? <Link href={`/coran/${previous.number}/tafsir${key === "saadi" ? "?source=saadi" : ""}`} className="inline-flex min-h-11 items-center font-medium text-emerald">{q.previous} : {previous.name_translit}</Link> : <span />}
        {next ? <Link href={`/coran/${next.number}/tafsir${key === "saadi" ? "?source=saadi" : ""}`} className="inline-flex min-h-11 items-center text-end font-medium text-emerald">{q.next} : {next.name_translit}</Link> : null}
      </nav>

      {source ? (
        <footer className="mt-10 border-t border-line pt-4 text-base text-muted" data-tafsir-source>
          <p>{q.tafsirSource} : {source.title}{source.author ? `, ${source.author}` : ""}, <a href={source.source_url} className="underline underline-offset-4">{source.publisher}</a>, version {source.version}</p>
          <p className="mt-1">{q.tafsirNotice}</p>
          <Link href="/coran/sources" className="inline-flex min-h-11 items-center underline underline-offset-4">{q.sourcesLink}</Link>
        </footer>
      ) : null}
    </main>
  );
}
