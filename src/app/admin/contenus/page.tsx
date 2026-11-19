import Link from "next/link";
import { KIND_LABEL, SECTION_LABEL, STATUS_LABEL, formatDate, requireStaff, type ContentKind, type ContentStatus } from "@/lib/admin";

type Row = { id: string; item_id: string; number: number; title: string; status: ContentStatus; author_name: string; updated_at: string; content_items: { kind: ContentKind; section: string } };

export default async function ContentList({ searchParams }: { searchParams: Promise<{ statut?: string }> }) {
  const [{ supabase, role }, { statut }] = await Promise.all([requireStaff(), searchParams]);
  const { data, error } = await supabase.from("content_revisions").select("id,item_id,number,title,status,author_name,updated_at,content_items!content_revisions_item_id_fkey(kind,section)").order("number", { ascending: false }).limit(500);
  if (error) throw new Error(error.message);
  const latest = new Map<string, Row>();
  (data as unknown as Row[]).forEach((row) => { if (!latest.has(row.item_id)) latest.set(row.item_id, row); });
  const rows = [...latest.values()].filter((row) => !statut || row.status === statut).sort((a, b) => b.updated_at.localeCompare(a.updated_at));
  return (
    <main className="py-5">
      <div className="flex items-center justify-between gap-3">
        <h1 className="text-3xl">Contenus</h1>
        {role === "editor" || role === "admin" ? <Link href="/admin/contenus/nouveau" className="inline-flex min-h-11 items-center rounded-lg bg-emerald px-4 font-medium text-on-emerald">Nouveau</Link> : null}
      </div>
      {statut && statut in STATUS_LABEL ? <p className="mt-2 text-muted">Filtre : {STATUS_LABEL[statut as ContentStatus]}. <Link href="/admin/contenus" className="underline underline-offset-4">Tout afficher</Link></p> : null}
      {rows.length ? (
        <ul className="mt-4 divide-y divide-line border-y border-line">
          {rows.map((row) => (
            <li key={row.id}><Link href={`/admin/contenus/${row.item_id}`} className="block py-3">
              <span className="font-medium break-words">{row.title}</span>
              <span className="block text-base text-muted">{STATUS_LABEL[row.status]}, version {row.number}. {KIND_LABEL[row.content_items.kind]}, {SECTION_LABEL[row.content_items.section]}. {row.author_name}, {formatDate(row.updated_at)}</span>
            </Link></li>
          ))}
        </ul>
      ) : <p className="mt-4 text-muted">Aucun contenu ici pour le moment.</p>}
    </main>
  );
}
