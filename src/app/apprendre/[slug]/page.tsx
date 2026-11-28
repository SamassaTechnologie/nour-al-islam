import type { Metadata } from "next";
import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { ArabicVerse } from "@/components/quran-view";
import { Paragraphs, referenceText } from "@/components/content-view";
import { FavoriteButton } from "@/components/favorite-button";
import { LessonQuiz } from "@/components/lesson-quiz";
import { getPublishedContent } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { withExcerpts } from "@/lib/quiz";
import { getSurahs, getSurahVerses, verseBody } from "@/lib/quran";
import { createClient, getSession } from "@/lib/supabase/server";

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const data = await getPublishedContent((await params).slug);
  return { title: data?.revision.title ?? "Contenu" };
}

export default async function PublishedContent({ params }: Props) {
  const data = await getPublishedContent((await params).slug);
  if (!data) notFound();
  if (data.item.section === "adhkar") redirect(`/priere/invocations/${data.item.slug}`);
  const { item, revision, references, opinions } = data;
  const [{ t, locale }, surahs, session, questions] = await Promise.all([getPreferences(), getSurahs(), getSession(), withExcerpts(data.questions)]);
  const c = t.content;
  type Score = { score: number; total: number };
  let best: Score | null = null;
  let favorite = false;
  if (session) {
    const supabase = await createClient();
    const [{ data: attempts }, fav] = await Promise.all([
      questions.length ? supabase.from("quiz_attempts").select("score,total").eq("item_id", item.id).order("created_at", { ascending: false }).limit(50).returns<Score[]>() : Promise.resolve({ data: [] as Score[] }),
      supabase.from("favorites").select("item_id").eq("item_id", item.id).maybeSingle(),
    ]);
    best = (attempts ?? []).reduce<Score | null>((top, row) => (!top || row.score / row.total > top.score / top.total ? row : top), null);
    favorite = Boolean(fav.data);
  }
  const provisional = revision.review_kind === "ai";
  const date = new Date(revision.published_at!).toLocaleDateString(locale === "ar" ? "ar" : "fr-FR", { dateStyle: "long", timeZone: "UTC" });
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/apprendre" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{c.back}</Link>
      <article lang={item.locale} dir={item.locale === "ar" ? "rtl" : "ltr"}>
        <p className="text-muted">{c.kinds[item.kind]}</p>
        <h1 className="text-3xl break-words">{revision.title}</h1>
        {provisional ? <p role="note" data-provisional className="mt-3 border-s-2 border-gold ps-3 font-medium">{c.provisional}</p> : null}
        {revision.summary ? <p className="mt-3 font-medium">{revision.summary}</p> : null}
        {session ? <FavoriteButton itemId={item.id} initial={favorite} t={t.favorites} /> : null}
        <Paragraphs text={revision.body} />
      </article>
      {questions.length ? <LessonQuiz questions={questions} itemId={item.id} revisionId={revision.id} slug={item.slug} signedIn={!!session} best={best} contentLocale={item.locale} uiLocale={locale} t={t.quiz} reviewT={t.review} /> : null}
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
                {ref.url ? <a href={ref.url} rel="noreferrer" target="_blank" className="inline-flex min-h-11 items-center break-all text-emerald underline underline-offset-4" data-source-link>{c.openSource.replace("{site}", new URL(ref.url).hostname.replace(/^www\./, ""))}</a> : null}
              </li>
            );
          }))}
        </ul>
      </section>
      <p className="mt-5 border-s-2 border-gold ps-3 text-base">{provisional ? c.aiReviewed : `${c.validated} ${revision.reviewer_name}, ${date}.`}</p>
    </main>
  );
}
