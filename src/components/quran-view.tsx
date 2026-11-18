import Link from "next/link";
import { Lattice } from "@/components/art";
import { BookmarkButton, ReaderControls, ReadingTracker } from "@/components/quran-client";
import { getBismillah, getBookmarkIds, getSources, verseBody, type Surah, type Verse } from "@/lib/quran";
import type { Dictionary } from "@/lib/dictionaries";

export function place(t: Dictionary["quran"], surah: Surah) {
  return surah.revelation_place === "Meccan" ? t.meccan : t.medinan;
}

export function ArabicVerse({ text, className = "" }: { text: string; className?: string }) {
  return <p lang="ar" dir="rtl" className={`quran-text ${className}`}>{text}</p>;
}

const arabicNumber = (n: number) => String(n).replace(/\d/g, (d) => "٠١٢٣٤٥٦٧٨٩"[Number(d)]);

export function SurahFrame({ surah, t }: { surah: Surah; t: Dictionary["quran"] }) {
  return (
    <div className="surah-frame mushaf-only relative overflow-hidden border-2 border-gold p-1">
      <div className="relative flex h-14 items-center justify-center overflow-hidden border border-gold">
        <Lattice id={`frame-${surah.number}`} className="opacity-70" />
        <p lang="ar" dir="rtl" className="relative rounded-full border border-gold bg-page px-6 text-2xl leading-10 font-semibold">{t.surahWord} {surah.name_ar}</p>
      </div>
    </div>
  );
}

export async function SourceNote({ t }: { t: Dictionary["quran"] }) {
  const sources = await getSources();
  const text = sources.find((s) => s.kind === "text");
  const translation = sources.find((s) => s.kind === "translation");
  return (
    <footer className="mt-10 border-t border-line pt-4 text-base text-muted">
      {text ? <p>{t.textSource} : <a href={text.source_url} className="underline underline-offset-4">{text.publisher}</a>, version {text.version}</p> : null}
      <p>{t.audioSource} : <a href="https://quran.foundation" className="underline underline-offset-4">Quran Foundation</a></p>
      {translation ? <p>{t.translationSource} : {translation.author}, <a href={translation.source_url} className="underline underline-offset-4">{translation.publisher}</a>, version {translation.version}</p> : null}
      <Link href="/coran/sources" className="inline-flex min-h-11 items-center underline underline-offset-4">{t.sourcesLink}</Link>
    </footer>
  );
}

export async function VerseList({ verses, surahs, t, trackSurah, showHeadings = false, showRub = false }: {
  verses: Verse[];
  surahs: Surah[];
  t: Dictionary["quran"];
  trackSurah?: number;
  showHeadings?: boolean;
  showRub?: boolean;
}) {
  const [bismillah, bookmarks] = await Promise.all([
    getBismillah(),
    getBookmarkIds(verses[0].id, verses[verses.length - 1].id),
  ]);
  return (
    <>
      <ReaderControls t={t} />
      {trackSurah && bookmarks ? <ReadingTracker surah={trackSurah} /> : null}
      <ol className="verse-list mt-2">
        {verses.map((verse, index) => {
          const surah = surahs[verse.surah - 1];
          return (
            <li key={verse.id} id={`v${verse.surah}-${verse.number}`} data-ayah-id={verse.id} data-verse-number={verse.number} className="verse-item scroll-mt-14 border-b border-line py-5">
              {showRub && verses[index - 1]?.rub !== verse.rub ? (
                <p id={`rub-${verse.rub}`} className="verse-block mb-4 scroll-mt-14 border-s-2 border-gold ps-3 font-medium">{t.rub} {verse.rub}/4</p>
              ) : null}
              {showHeadings && verse.number === 1 ? (
                <SurahFrame surah={surah} t={t} />
              ) : null}
              {showHeadings && verse.number === 1 ? (
                <h2 className="verses-only mb-4 text-center text-xl"><span lang="en" dir="ltr">{surah.name_translit}</span> <span lang="ar" dir="rtl" className="surah-name ms-2">{surah.name_ar}</span></h2>
              ) : null}
              {verse.bismillah_length > 0 ? <ArabicVerse text={bismillah} className="verse-block mb-5 text-center" /> : null}
              <div className="verses-only flex items-center justify-between">
                <Link href={`/coran/${verse.surah}#v${verse.surah}-${verse.number}`} aria-label={`${t.verse} ${verse.surah}:${verse.number}`} className="inline-flex min-h-11 items-center gap-2 text-base font-medium text-emerald">
                  {verse.surah}:{verse.number}
                </Link>
                <span className="flex items-center">
                  {trackSurah ? (
                    <button type="button" data-play-verse={verse.number} aria-label={`${t.playVerse} ${verse.surah}:${verse.number}`} className="grid h-11 w-11 place-items-center rounded-md text-muted">
                      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor"><path d="M8 5v14l11-7z" /></svg>
                    </button>
                  ) : null}
                  {bookmarks ? <BookmarkButton ayahId={verse.id} initial={bookmarks.has(verse.id)} t={t} /> : null}
                </span>
              </div>
              <ArabicVerse text={verseBody(verse.text_uthmani, verse.bismillah_length)} className="verse-body" />
              <span className="ayah-mark" role="img" aria-label={`${t.verse} ${verse.number}`}>{"\u00a0"}<span lang="ar" dir="rtl">{arabicNumber(verse.number)}</span></span>
              {verse.translation ? (
                <div className="verse-translation mt-3" lang="fr" dir="ltr">
                  <p>{verse.translation.text}</p>
                  {verse.translation.footnotes ? (
                    <details className="mt-1 text-base text-muted">
                      <summary className="flex min-h-11 cursor-pointer items-center">{t.notes}</summary>
                      <p className="whitespace-pre-line">{verse.translation.footnotes}</p>
                    </details>
                  ) : null}
                </div>
              ) : null}
            </li>
          );
        })}
      </ol>
    </>
  );
}
