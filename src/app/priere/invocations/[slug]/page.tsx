import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Paragraphs } from "@/components/content-view";
import { DhikrCounter } from "@/components/dhikr-counter";
import { FavoriteButton } from "@/components/favorite-button";
import { getPublishedAdhkar } from "@/lib/content";
import { getPreferences } from "@/lib/preferences";
import { getSurahs, getSurahVerses, verseBody } from "@/lib/quran";
import { createClient, getSession } from "@/lib/supabase/server";

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const data = await getPublishedAdhkar((await params).slug);
  return { title: data?.revision.title ?? "Invocations" };
}

const host = (url: string) => new URL(url).hostname.replace(/^www\./, "");

export default async function Page({ params }: Props) {
  const data = await getPublishedAdhkar((await params).slug);
  if (!data) notFound();
  const [{ t, locale }, surahs, session] = await Promise.all([getPreferences(), getSurahs(), getSession()]);
  const favorite = session ? Boolean((await (await createClient()).from("favorites").select("item_id").eq("item_id", data.item.id).maybeSingle()).data) : false;
  const { revision, adhkar } = data;
  // Invocations faites de versets : texte et traduction lus dans le texte coranique verrouille.
  const verses = new Map(await Promise.all(adhkar.filter((d) => d.surah).map(async (d) =>
    [d.id, (await getSurahVerses(d.surah!)).filter((v) => v.number >= d.ayah_from! && v.number <= d.ayah_to!)] as const)));
  const a = t.adhkar;
  const c = t.content;
  const provisional = revision.review_kind === "ai";
  const date = new Date(revision.published_at!).toLocaleDateString(locale === "ar" ? "ar" : "fr-FR", { dateStyle: "long", timeZone: "UTC" });
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <Link href="/priere/invocations" className="inline-flex min-h-11 items-center text-muted underline underline-offset-4">{a.back}</Link>
      <article lang="fr" dir="ltr">
        <h1 className="text-3xl break-words">{revision.title}</h1>
        {provisional ? <p role="note" data-provisional className="mt-3 border-s-2 border-gold ps-3 font-medium">{c.provisional}</p> : null}
        {revision.summary ? <p className="mt-3 font-medium">{revision.summary}</p> : null}
        {session ? <FavoriteButton itemId={data.item.id} initial={favorite} t={t.favorites} /> : null}
        <Paragraphs text={revision.body} />
        <ol className="mt-6 space-y-5">
          {adhkar.map((d, n) => (
            <li key={d.id} className="rounded-lg border border-line p-4" data-dhikr={d.id}>
              <h2 className="text-xl"><span className="text-muted">{n + 1}. </span>{d.title}</h2>
              {d.when_to_say ? <p className="mt-1 text-base text-muted"><span className="font-medium">{a.when} : </span>{d.when_to_say}</p> : null}
              {d.surah ? (
                <div className="mt-3" data-quran={`${d.surah}:${d.ayah_from}-${d.ayah_to}`}>
                  <p className="text-base text-muted">{a.verses.replace("{surah}", `${surahs[d.surah - 1]?.name_translit} (${d.surah})`).replace("{verses}", d.ayah_from === d.ayah_to ? String(d.ayah_from) : `${d.ayah_from} à ${d.ayah_to}`)}</p>
                  {(verses.get(d.id) ?? []).map((v) => (
                    <div key={v.id} className="mt-2" data-verse={`${v.surah}:${v.number}`}>
                      <p lang="ar" dir="rtl" className="quran-text" data-verse-text>{verseBody(v.text_uthmani, v.bismillah_length)} <span className="text-base">({v.number})</span></p>
                      {v.translation ? <p className="mt-1"><span className="font-medium">{a.meaning} : </span>{v.translation.text}</p> : null}
                    </div>
                  ))}
                  <p className="mt-2"><span className="font-medium">{a.transliteration} : </span><span className="italic" data-translit>{d.transliteration}</span></p>
                </div>
              ) : (
                <>
                  <p lang="ar" dir="rtl" className="quran-text mt-3" data-arabic>{d.arabic}</p>
                  <p className="mt-3"><span className="font-medium">{a.transliteration} : </span><span className="italic" data-translit>{d.transliteration}</span></p>
                  <p className="mt-2"><span className="font-medium">{a.meaning} : </span>{d.meaning}</p>
                </>
              )}
              <p className="mt-2 font-medium" data-repeat={d.repeat_count}>{d.repeat_count > 1 ? a.repeat.replace("{n}", String(d.repeat_count)) : a.once}</p>
              {d.repeat_count > 1 ? <DhikrCounter total={d.repeat_count} t={a} /> : null}
              {d.virtue ? <p className="mt-3 border-s-2 border-gold ps-3"><span className="font-medium">{a.virtue} : </span>{d.virtue}</p> : null}
              <p className="mt-3 text-base text-muted" data-source><span className="font-medium">{a.source} : </span>{d.collection}, n° {d.hadith_number}. {a.grade} : {d.grade} ({d.graded_by}).{d.note ? ` ${d.note}` : ""}</p>
              <a href={d.url} rel="noreferrer" target="_blank" className="inline-flex min-h-11 items-center break-all text-emerald underline underline-offset-4" data-source-link>{c.openSource.replace("{site}", host(d.url))}</a>
            </li>
          ))}
        </ol>
      </article>
      <p className="mt-5 text-base text-muted">{a.textNote}</p>
      <p className="mt-3 border-s-2 border-gold ps-3 text-base">{provisional ? c.aiReviewed : `${c.validated} ${revision.reviewer_name}, ${date}.`}</p>
    </main>
  );
}
