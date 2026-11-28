import { cache } from "react";
import type { ContentKind, Dhikr, Item, Opinion, Question, Reference, Revision } from "@/lib/admin";
import { createClient } from "@/lib/supabase/server";

const REF_COLUMNS = "id,revision_id,kind,surah,ayah_from,ayah_to,collection,edition,hadith_number,grade,graded_by,source_title,author,locator,url,note";
export type PublishedCard = { id: string; slug: string; kind: ContentKind; section: string; position: number | null; level: number | null; revisionId: string; title: string; summary: string; provisional: boolean };
/** Ordre des rubriques dans Apprendre : on apprend a lire avant le Tajwid. */
const SECTION_ORDER = ["arabe", "tajwid", "aqida", "purification", "priere", "jeune", "zakat", "hajj", "fiqh", "sira", "hadith", "tafsir", "adab", "famille"];
const sectionRank = (section: string) => (SECTION_ORDER.includes(section) ? SECTION_ORDER.indexOf(section) : SECTION_ORDER.length);

/** Rubrique des invocations : affichee dans « Prière », pas dans « Apprendre ». */
export const ADHKAR_SECTION = "adhkar";

const getAllPublished = cache(async (): Promise<PublishedCard[]> => {
  const supabase = await createClient();
  const { data, error } = await supabase.from("content_items")
    .select("id,slug,kind,section,position,level,published_revision_id,content_revisions!content_items_published_revision_id_fkey!inner(title,summary,published_at,review_kind)")
    .not("published_revision_id", "is", null).limit(300);
  if (error) throw new Error(error.message);
  type Row = { id: string; slug: string; kind: ContentKind; section: string; position: number | null; level: number | null; published_revision_id: string; content_revisions: { title: string; summary: string; published_at: string; review_kind: string | null } };
  return (data as unknown as Row[]).sort((a, b) => sectionRank(a.section) - sectionRank(b.section) || a.section.localeCompare(b.section)
      || (a.position ?? 1000) - (b.position ?? 1000) || b.content_revisions.published_at.localeCompare(a.content_revisions.published_at))
    .map((row) => ({ id: row.id, slug: row.slug, kind: row.kind, section: row.section, position: row.position, level: row.level, revisionId: row.published_revision_id, title: row.content_revisions.title, summary: row.content_revisions.summary, provisional: row.content_revisions.review_kind === "ai" }));
});

export const getPublishedList = cache(async () => (await getAllPublished()).filter((item) => item.section !== ADHKAR_SECTION));
export const getAdhkarList = cache(async () => (await getAllPublished()).filter((item) => item.section === ADHKAR_SECTION));

export const getPublishedAdhkar = cache(async (slug: string) => {
  const data = await getPublishedContent(slug);
  if (!data || data.item.section !== ADHKAR_SECTION) return null;
  const { data: adhkar } = await (await createClient()).from("content_adhkar")
    .select("id,revision_id,title,arabic,transliteration,meaning,repeat_count,when_to_say,virtue,collection,hadith_number,grade,graded_by,url,note,surah,ayah_from,ayah_to")
    .eq("revision_id", data.revision.id).order("ord").returns<Dhikr[]>();
  return { ...data, adhkar: adhkar ?? [] };
});

export const getPublishedContent = cache(async (slug: string) => {
  if (!/^[a-z0-9-]{1,80}$/.test(slug)) return null;
  const supabase = await createClient();
  const { data: item } = await supabase.from("content_items").select("id,slug,kind,section,locale,published_revision_id").eq("slug", slug).not("published_revision_id", "is", null).maybeSingle<Item>();
  if (!item?.published_revision_id) return null;
  const rev = item.published_revision_id;
  const [{ data: revision }, { data: references }, { data: opinions }, { data: questions }] = await Promise.all([
    supabase.from("content_revisions").select("id,title,summary,body,reviewer_name,published_at,review_kind").eq("id", rev).single<Pick<Revision, "id" | "title" | "summary" | "body" | "reviewer_name" | "published_at" | "review_kind">>(),
    supabase.from("content_references").select(REF_COLUMNS).eq("revision_id", rev).order("ord").returns<Reference[]>(),
    supabase.from("content_opinions").select("id,holder,opinion,source").eq("revision_id", rev).order("ord").returns<Opinion[]>(),
    supabase.from("content_questions").select("id,revision_id,prompt,display,surah,ayah,word_from,word_to,options,answer,explanation").eq("revision_id", rev).order("ord").returns<Question[]>(),
  ]);
  return revision ? { item, revision, references: references ?? [], opinions: opinions ?? [], questions: questions ?? [] } : null;
});
