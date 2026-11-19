"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient, type AppRole } from "@/lib/supabase/server";

export type AdminState = { error?: string; ok?: boolean };
export type MfaState = AdminState & { factorId?: string; qr?: string; secret?: string };
type DbError = { code?: string; message: string };

const field = (form: FormData, key: string) => {
  const value = form.get(key);
  return typeof value === "string" ? value.trim() : "";
};
const optional = (form: FormData, key: string) => field(form, key) || null;
const number = (form: FormData, key: string) => {
  const value = Number(field(form, key));
  return Number.isInteger(value) && value > 0 ? value : null;
};
const failure = (error: DbError): AdminState => ({
  error: error.code === "P0001" ? error.message
    : error.code === "23505" ? "Cette valeur existe déjà."
    : error.code === "23514" || error.code === "23502" || error.code === "23503" || error.code === "22P02" ? "Un champ obligatoire est manquant ou invalide."
    : error.code === "42501" ? "Vous n’avez pas le droit d’effectuer cette action."
    : "L’opération a échoué. Réessayez.",
});
const slugify = (title: string) => title.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "").slice(0, 60);
const refresh = (item: string) => {
  revalidatePath(`/admin/contenus/${item}`);
  revalidatePath("/admin", "layout");
};

export async function createContent(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const title = field(form, "title");
  const base = slugify(title) || "contenu";
  const call = (slug: string) => supabase.rpc("create_content", { p_slug: slug, p_kind: field(form, "kind"), p_section: field(form, "section"), p_locale: field(form, "locale"), p_title: title });
  let { data, error } = await call(base);
  if (error?.code === "23505") ({ data, error } = await call(`${base}-${crypto.randomUUID().slice(0, 6)}`));
  if (error) return failure(error);
  redirect(`/admin/contenus/${data}`);
}

export async function saveRevision(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { data, error } = await supabase.from("content_revisions").update({
    title: field(form, "title"), summary: field(form, "summary"), body: field(form, "body"), ai_assisted: form.get("ai_assisted") === "on",
  }).eq("id", field(form, "revision")).select("id");
  if (error) return failure(error);
  if (!data?.length) return { error: "Cette version ne peut pas être modifiée." };
  refresh(field(form, "item"));
  return { ok: true };
}

export async function addReference(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const kind = field(form, "kind");
  const from = number(form, "ayah_from");
  const { error } = await supabase.from("content_references").insert({
    revision_id: field(form, "revision"), kind, surah: number(form, "surah"), ayah_from: from, ayah_to: number(form, "ayah_to") ?? from,
    collection: optional(form, "collection"), edition: optional(form, "edition"), hadith_number: optional(form, "hadith_number"), grade: optional(form, "grade"), graded_by: optional(form, "graded_by"),
    source_title: optional(form, "source_title"), author: optional(form, "author"), locator: optional(form, "locator"), url: optional(form, "url"), note: optional(form, "note"),
  });
  if (error) return failure(error);
  refresh(field(form, "item"));
  return { ok: true };
}

async function removeFrom(table: "content_references" | "content_opinions", form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { data, error } = await supabase.from(table).delete().eq("id", field(form, "id")).select("id");
  if (error) return failure(error);
  if (!data?.length) return { error: "Suppression impossible." };
  refresh(field(form, "item"));
  return { ok: true };
}
export async function removeReference(_: AdminState, form: FormData) { return removeFrom("content_references", form); }
export async function removeOpinion(_: AdminState, form: FormData) { return removeFrom("content_opinions", form); }

export async function addOpinion(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { error } = await supabase.from("content_opinions").insert({ revision_id: field(form, "revision"), holder: field(form, "holder"), opinion: field(form, "opinion"), source: field(form, "source") });
  if (error) return failure(error);
  refresh(field(form, "item"));
  return { ok: true };
}

export async function verifyReference(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { error } = await supabase.rpc("verify_content_reference", { p_reference: field(form, "id"), p_verified: field(form, "verified") === "true" });
  if (error) return failure(error);
  refresh(field(form, "item"));
  return { ok: true };
}

export async function contentAction(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { error } = await supabase.rpc("content_action", { p_revision: field(form, "revision"), p_action: field(form, "action"), p_note: optional(form, "note") });
  if (error) return failure(error);
  refresh(field(form, "item"));
  revalidatePath("/apprendre", "layout");
  return { ok: true };
}

export async function newRevision(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { error } = await supabase.rpc("new_content_revision", { p_item: field(form, "item") });
  if (error) return failure(error);
  refresh(field(form, "item"));
  return { ok: true };
}

export async function setRole(_: AdminState, form: FormData): Promise<AdminState> {
  const supabase = await createClient();
  const { error } = await supabase.rpc("admin_set_role", { p_user: field(form, "user"), p_role: field(form, "role") as AppRole });
  if (error) return failure(error);
  revalidatePath("/admin/utilisateurs");
  return { ok: true };
}

export async function startMfa(): Promise<MfaState> {
  const supabase = await createClient();
  const { data: factors, error: listError } = await supabase.auth.mfa.listFactors();
  if (listError) return { error: "La double authentification est indisponible." };
  for (const factor of factors.all.filter((item) => item.status === "unverified")) await supabase.auth.mfa.unenroll({ factorId: factor.id });
  const { data, error } = await supabase.auth.mfa.enroll({ factorType: "totp", issuer: "NOUR AL-ISLAM", friendlyName: `Téléphone ${crypto.randomUUID().slice(0, 4)}` });
  if (error) return { error: "L’activation a échoué. Réessayez." };
  return { factorId: data.id, qr: data.totp.qr_code, secret: data.totp.secret };
}

export async function verifyMfa(_: MfaState, form: FormData): Promise<MfaState> {
  const supabase = await createClient();
  const factorId = field(form, "factor");
  const { error } = await supabase.auth.mfa.challengeAndVerify({ factorId, code: field(form, "code").replace(/\s/g, "") });
  if (error) return { error: "Code incorrect ou expiré.", factorId, qr: field(form, "qr") || undefined, secret: field(form, "secret") || undefined };
  redirect("/admin");
}
