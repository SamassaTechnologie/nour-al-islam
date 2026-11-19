import { cache } from "react";
import { notFound, redirect } from "next/navigation";
import { createClient, getSession, type AppRole } from "@/lib/supabase/server";

export type ContentStatus = "draft" | "source_check" | "in_review" | "changes_requested" | "published" | "superseded" | "withdrawn";
export type ContentKind = "lesson" | "explanation" | "legal_opinion";
export type ReviewKind = "ai" | "scholar" | null;

export type Reference = {
  id: string; revision_id: string; kind: "quran" | "hadith" | "book"; surah: number | null; ayah_from: number | null; ayah_to: number | null;
  collection: string | null; edition: string | null; hadith_number: string | null; grade: string | null; graded_by: string | null;
  source_title: string | null; author: string | null; locator: string | null; url: string | null; note: string | null;
  verified_name?: string | null; verified_at?: string | null;
};
export type Opinion = { id: string; holder: string; opinion: string; source: string };
export type Revision = {
  id: string; item_id: string; number: number; title: string; summary: string; body: string; ai_assisted: boolean; status: ContentStatus;
  author_id: string | null; author_name: string; source_checked_name: string | null; source_checked_at: string | null;
  reviewer_name: string | null; published_at: string | null; content_hash: string | null; updated_at: string; review_kind: ReviewKind;
};
export type Item = { id: string; slug: string; kind: ContentKind; section: string; locale: "fr" | "ar"; published_revision_id: string | null };
export type AuditEntry = { id: number; at: string; actor_name: string; action: string; item_id: string | null; from_value: string | null; to_value: string | null; note: string | null; target_user: string | null };

export const STATUS_LABEL: Record<ContentStatus, string> = {
  draft: "Brouillon", source_check: "Vérification des sources", in_review: "Relecture religieuse", changes_requested: "Corrections demandées",
  published: "Publié", superseded: "Remplacé", withdrawn: "Retiré",
};
export const AI_REVIEWED = "Relu par l’IA, en attente des savants";
export const statusKey = (row: { status: ContentStatus; review_kind: ReviewKind }) => (row.status === "published" && row.review_kind === "ai" ? "ai" : row.status);
export const statusText = (status: ContentStatus, kind: ReviewKind) => (status === "published" && kind === "ai" ? AI_REVIEWED : STATUS_LABEL[status]);
export const KIND_LABEL: Record<ContentKind, string> = { lesson: "Leçon", explanation: "Explication de savant", legal_opinion: "Avis juridique" };
export const SECTION_LABEL: Record<string, string> = {
  aqida: "Croyance (Aqida)", purification: "Purification", priere: "Prière", jeune: "Jeûne", zakat: "Zakat", hajj: "Pèlerinage", fiqh: "Fiqh",
  sira: "Sira", hadith: "Hadith", tafsir: "Tafsir", tajwid: "Tajwid", arabe: "Lecture de l’arabe", adab: "Comportement", famille: "Famille",
};
export const ROLE_LABEL: Record<AppRole, string> = { user: "Utilisateur", editor: "Éditeur", reviewer: "Réviseur religieux", admin: "Administrateur" };
export const ACTION_LABEL: Record<string, string> = {
  created: "Création", new_version: "Nouvelle version", submit: "Envoi à la vérification", reference_verified: "Référence vérifiée", reference_unverified: "Vérification annulée",
  confirm_sources: "Sources confirmées", ai_review: "Relecture par l’assistant IA", ai_corrected: "Corrections par l’assistant IA", validate: "Validation par un réviseur", request_changes: "Corrections demandées", publish: "Publication", withdraw: "Retrait", role_changed: "Rôle modifié",
};
export const formatDate = (value: string) => new Date(value).toLocaleString("fr-FR", { dateStyle: "short", timeStyle: "short", timeZone: "UTC" }) + " UTC";

export const getAal = cache(async () => {
  const supabase = await createClient();
  const [{ data: level }, { data: factors }] = await Promise.all([supabase.auth.mfa.getAuthenticatorAssuranceLevel(), supabase.auth.mfa.listFactors()]);
  return { current: level?.currentLevel ?? "aal1", verified: factors?.totp ?? [] };
});

/** Refuse tout compte hors equipe ; administrateurs et reviseurs doivent avoir valide leur second facteur. */
export async function requireStaff(options: { mfa?: boolean } = {}) {
  const session = await getSession();
  if (!session) redirect("/connexion?suivant=/admin");
  const role = session.profile?.role ?? "user";
  if (role === "user") notFound();
  const aal = await getAal();
  if ((options.mfa ?? true) && (role === "admin" || role === "reviewer") && aal.current !== "aal2") redirect("/admin/securite");
  return { session, role, aal, userId: session.user.id, supabase: await createClient() };
}
