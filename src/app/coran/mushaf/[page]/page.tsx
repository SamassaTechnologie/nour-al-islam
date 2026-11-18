import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Lattice } from "@/components/art";
import { getMushafPage, MUSHAF_PAGES, type MushafPage, type MushafWord } from "@/lib/mushaf";
import { getPreferences } from "@/lib/preferences";

type Props = { params: Promise<{ page: string }> };

const fontUrl = (page: number) => `https://verses.quran.foundation/fonts/quran/hafs/v1/woff2/p${page}.woff2`;
const fontFace = (page: number) => `@font-face{font-family:"qcf-p${page}";src:url("${fontUrl(page)}") format("woff2");font-display:block}`;

async function pageNumber(params: Props["params"]) {
  const { page } = await params;
  const number = Number(page);
  if (!/^\d{1,3}$/.test(page) || number < 1 || number > MUSHAF_PAGES) notFound();
  return number;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  return { title: `Mushaf, page ${await pageNumber(params)}` };
}

function Words({ words }: { words: MushafWord[] }) {
  return words.map((word, index) => <span key={index} data-v={word.verse} data-end={word.end ? "" : undefined} className="mushaf-word">{word.code}</span>);
}

const spoken = (words: MushafWord[]) => words.filter((word) => !word.end).map((word) => word.text).join(" ");

export default async function MushafPageView({ params }: Props) {
  const number = await pageNumber(params);
  const { t } = await getPreferences();
  let data: MushafPage;
  try {
    data = await getMushafPage(number);
  } catch (error) {
    console.error("Mushaf indisponible", error instanceof Error ? error.message : "erreur inconnue");
    return (
      <div role="alert" className="py-16 text-center">
        <p>{t.quran.mushafError}</p>
        <Link href={`/coran/mushaf/${number}`} className="mt-3 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.quran.retry}</Link>
      </div>
    );
  }
  const usesOpening = data.lines.some((line) => line.kind === "bismillah");
  return (
    <article lang="ar" dir="rtl" className="mushaf-page" data-page={number} data-first={data.first} data-last={data.last} style={{ fontFamily: `"qcf-p${number}"` }}>
      <style dangerouslySetInnerHTML={{ __html: fontFace(number) + (usesOpening ? fontFace(1) : "") }} />
      {number < MUSHAF_PAGES ? <link rel="prefetch" as="font" type="font/woff2" crossOrigin="anonymous" href={fontUrl(number + 1)} /> : null}
      <div className="mushaf-lines">
        {data.lines.map((line) => {
          if (line.kind === "surah") {
            return (
              <div key={line.number} className="mushaf-surah" data-surah={line.surah}>
                <Lattice id={`mushaf-${number}-${line.surah}`} className="opacity-60" />
                <span className="mushaf-surah-name">{String(line.surah).padStart(3, "0")}</span>
              </div>
            );
          }
          if (line.kind === "bismillah") return <p key={line.number} className="mushaf-line" data-bismillah aria-label={spoken(data.bismillah)} style={{ fontFamily: '"qcf-p1"' }}>{data.bismillah.map((word, index) => <span key={index} aria-hidden="true">{word.code}</span>)}</p>;
          if (line.kind === "empty") return <div key={line.number} className="mushaf-line" data-empty />;
          return <p key={line.number} className="mushaf-line" data-line={line.number} aria-label={spoken(line.words)}><Words words={line.words} /></p>;
        })}
      </div>
    </article>
  );
}
