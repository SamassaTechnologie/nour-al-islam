import Link from "next/link";
import { BookmarkButton, ReaderControls, ReadingTracker } from "@/components/quran-client";
import { getBismillah, getBookmarkIds, getSources, verseBody, type Surah, type Verse } from "@/lib/quran";
import type { Dictionary } from "@/lib/dictionaries";

export function place(t: Dictionary["quran"], surah: Surah) {
  return surah.revelation_place === "Meccan" ? t.meccan : t.medinan;
}

export function ArabicVerse({ text, className = "" }: { text: string; className?: string }) {
  return <p lang="ar" dir="rtl" className={`quran-text ${className}`}>{text}</p>;
}

export async function SourceNote({ t }: { t: Dictionary["quran"] }) {
  const sources = await getSources();
  const text = sources.find((s) => s.kind === "text");
  const translation = sources.find((s) => s.kind === "translation");
  return (
    <footer className="mt-10 border-t border-line pt-4 text-base text-muted">
      {text ? <p>{t.textSource} : <a href={text.source_url} className="underline underline-offset-4">{text.publisher}</a>, version {text.version}</p> : null}
      {translation ? <p>{t.translationSource} : {translation.author}, <a href={translation.source_url} className="underline underline-offset-4">{translation.publisher}</a>, version {translation.version}</p> : null}
      <Link href="/coran/sources" className="inline-flex min-h-11 items-center underline underline-offset-4">{t.sourcesLink}</Link>
    </footer>
  );
}

export async function VerseList({ verses, surahs, t, trackSurah, showHeadings = false }: {
  verses: Verse[];
  surahs: Surah[];
  t: Dictionary["quran"];
  trackSurah?: number;
  showHeadings?: boolean;
}) {
  const [bismillah, bookmarks] = await Promise.all([
    getBismillah(),
    getBookmarkIds(verses[0].id, verses[verses.length - 1].id),
  ]);
  return (
    <>
      <ReaderControls t={t} />
      {trackSurah && bookmarks ? <ReadingTracker surah={trackSurah} /> : null}
      <ol className="mt-2">
        {verses.map((verse) => {
          const surah = surahs[verse.surah - 1];
          return (
            <li key={verse.id} id={`v${verse.surah}-${verse.number}`} data-ayah-id={verse.id} className="scroll-mt-14 border-b border-line py-5">
              {showHeadings && verse.number === 1 ? (
                <h2 className="mb-4 text-center text-xl">{surah.name_translit} <span lang="ar" dir="rtl">{surah.name_ar}</span></h2>
              ) : null}
              {verse.bismillah_length > 0 ? <ArabicVerse text={bismillah} className="mb-5 text-center" /> : null}
              <div className="flex items-center justify-between">
                <Link href={`/coran/${verse.surah}#v${verse.surah}-${verse.number}`} aria-label={`${t.verse} ${verse.surah}:${verse.number}`} className="inline-flex min-h-11 items-center gap-2 text-base font-medium text-emerald">
                  {verse.surah}:{verse.number}
                </Link>
                {bookmarks ? <BookmarkButton ayahId={verse.id} initial={bookmarks.has(verse.id)} t={t} /> : null}
              </div>
              <ArabicVerse text={verseBody(verse.text_uthmani, verse.bismillah_length)} />
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
