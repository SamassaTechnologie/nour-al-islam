import Link from "next/link";
import { AI_REVIEWED, ROLE_LABEL, STATUS_LABEL, requireStaff, statusKey, type ContentStatus, type ReviewKind } from "@/lib/admin";

const ORDER: [string, string][] = [
  ["in_review", STATUS_LABEL.in_review],
  ["source_check", STATUS_LABEL.source_check],
  ["changes_requested", STATUS_LABEL.changes_requested],
  ["draft", STATUS_LABEL.draft],
  ["ai", AI_REVIEWED],
  ["published", "Validés et publiés"],
];

export default async function AdminHome() {
  const { supabase, role, session } = await requireStaff();
  const [{ data }, { count: reviewers }] = await Promise.all([
    supabase.from("content_revisions").select("status,review_kind"),
    role === "admin" ? supabase.from("profiles").select("id", { count: "exact", head: true }).eq("role", "reviewer") : Promise.resolve({ count: null }),
  ]);
  const counts = new Map<string, number>();
  ((data ?? []) as { status: ContentStatus; review_kind: ReviewKind }[]).forEach((row) => counts.set(statusKey(row), (counts.get(statusKey(row)) ?? 0) + 1));
  return (
    <main className="py-5">
      <h1 className="text-3xl">Administration</h1>
      <p className="text-muted">{session.profile?.display_name}, {ROLE_LABEL[role]}</p>
      {role === "admin" && reviewers === 0 ? (
        <p role="status" className="mt-4 border-s-2 border-gold ps-3">Aucun réviseur religieux n’est désigné : les contenus relus par l’IA restent visibles seulement par l’équipe. <Link href="/admin/utilisateurs" className="font-medium text-emerald underline underline-offset-4">Attribuer ce rôle</Link></p>
      ) : null}
      <ul className="mt-5 divide-y divide-line border-y border-line">
        {ORDER.map(([key, label]) => (
          <li key={key}><Link href={`/admin/contenus?statut=${key}`} className="flex min-h-12 items-center justify-between gap-3"><span>{label}</span><span className="font-medium" data-count={key}>{counts.get(key) ?? 0}</span></Link></li>
        ))}
      </ul>
      {role === "editor" || role === "admin" ? <Link href="/admin/contenus/nouveau" className="mt-5 inline-flex min-h-11 items-center rounded-lg bg-emerald px-4 font-medium text-on-emerald">Nouveau contenu</Link> : null}
      <section className="mt-7">
        <h2 className="text-xl">À faire valider par les savants</h2>
        <ul className="mt-2 list-disc space-y-1 ps-5">
          <li><Link href="/admin/contenus?statut=ai" className="text-emerald underline underline-offset-4">Les contenus relus par l’IA</Link></li>
          <li>L’affichage du Mushaf de Médine (police QCF V1)</li>
          <li>La traduction française par défaut (Rachid Maach, QuranEnc 1.0.3)</li>
        </ul>
      </section>
    </main>
  );
}
