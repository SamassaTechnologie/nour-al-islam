import Link from "next/link";
import { ROLE_LABEL, STATUS_LABEL, requireStaff, type ContentStatus } from "@/lib/admin";

const ORDER: ContentStatus[] = ["in_review", "source_check", "changes_requested", "draft", "published"];

export default async function AdminHome() {
  const { supabase, role, session } = await requireStaff();
  const [{ data }, { count: reviewers }] = await Promise.all([
    supabase.from("content_revisions").select("status"),
    role === "admin" ? supabase.from("profiles").select("id", { count: "exact", head: true }).eq("role", "reviewer") : Promise.resolve({ count: null }),
  ]);
  const counts = new Map<string, number>();
  (data ?? []).forEach((row) => counts.set(row.status, (counts.get(row.status) ?? 0) + 1));
  return (
    <main className="py-5">
      <h1 className="text-3xl">Administration</h1>
      <p className="text-muted">{session.profile?.display_name}, {ROLE_LABEL[role]}</p>
      {role === "admin" && reviewers === 0 ? (
        <p role="status" className="mt-4 border-s-2 border-gold ps-3">Aucun réviseur religieux n’est désigné : rien ne peut être publié pour l’instant. <Link href="/admin/utilisateurs" className="font-medium text-emerald underline underline-offset-4">Attribuer ce rôle</Link></p>
      ) : null}
      <ul className="mt-5 divide-y divide-line border-y border-line">
        {ORDER.map((status) => (
          <li key={status}><Link href={`/admin/contenus?statut=${status}`} className="flex min-h-12 items-center justify-between"><span>{STATUS_LABEL[status]}</span><span className="font-medium">{counts.get(status) ?? 0}</span></Link></li>
        ))}
      </ul>
      {role === "editor" || role === "admin" ? <Link href="/admin/contenus/nouveau" className="mt-5 inline-flex min-h-11 items-center rounded-lg bg-emerald px-4 font-medium text-on-emerald">Nouveau contenu</Link> : null}
    </main>
  );
}
