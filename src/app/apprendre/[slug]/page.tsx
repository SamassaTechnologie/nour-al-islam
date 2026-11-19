import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ArabicVerse } from "@/components/quran-view";
import { Paragraphs, referenceText } from "@/components/content-view";
import { getPublishedContent } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { getSurahs, getSurahVerses, verseBody } from "@/lib/quran";

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const data = await getPublishedContent((await params).slug);
  return { title: data?.revision.title ?? "Contenu" };
}

export default async function PublishedContent({ params }: Props) {
  const data = await getPublishedContent((await params).slug);
  if (!data) notFound();
  const [{ t, locale }, surahs] = await Promise.all([getPreferences(), getSurahs()]);
  const c = t.content;
  const { item, revision, references, opinions } = data;
  const date = new Date(revision.published_at!).toLocaleDateString(locale === "ar" ? "ar" : "fr-FR", { dateStyle: "long", timeZone: "UTC" });
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/apprendre" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{c.back}</Link>
      <article lang={item.locale} dir={item.locale === "ar" ? "rtl" : "ltr"}>
        <p className="text-muted">{c.kinds[item.kind]}</p>
        <h1 className="text-3xl break-words">{revision.title}</h1>
        {revision.summary ? <p className="mt-3 font-medium">{revision.summary}</p> : null}
        <Paragraphs text={revision.body} />
      </article>
      {opinions.length ? (
        <section className="mt-7">
          <h2 className="text-xl">{c.opinions}</h2>
          <p className="text-muted">{c.opinionsNote}</p>
          <ul className="mt-2 space-y-3">{opinions.map((o) => <li key={o.id} className="border-s-2 border-gold ps-3"><p className="font-medium">{o.holder}</p><p>{o.opinion}</p><p className="text-base text-muted">{o.source}</p></li>)}</ul>
        </section>
      ) : null}
      <section className="mt-7">
        <h2 className="text-xl">{c.references}</h2>
        <ul className="mt-2 divide-y divide-line border-y border-line">
          {await Promise.all(references.map(async (ref) => {
            const verses = ref.kind === "quran" ? (await getSurahVerses(ref.surah!)).filter((v) => v.number >= ref.ayah_from! && v.number <= ref.ayah_to!) : [];
            return (
              <li key={ref.id} className="py-3">
                {verses.map((v) => <div key={v.id}><ArabicVerse text={verseBody(v.text_uthmani, v.bismillah_length)} />{v.translation ? <p className="mt-1">{v.translation.text}</p> : null}</div>)}
                <p lang="fr" dir="ltr" className="text-start break-words text-base text-muted">{referenceText(ref, surahs)}</p>
                {ref.url ? <a href={ref.url} rel="noreferrer" target="_blank" className="inline-flex min-h-11 items-center break-all text-emerald underline underline-offset-4">{ref.url}</a> : null}
              </li>
            );
          }))}
        </ul>
      </section>
      <p className="mt-5 border-s-2 border-gold ps-3 text-base">{c.validated} {revision.reviewer_name}, {date}.</p>
    </main>
  );
}
