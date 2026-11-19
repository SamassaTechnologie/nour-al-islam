import Link from "next/link";
import { ACTION_LABEL, ROLE_LABEL, STATUS_LABEL, formatDate, requireStaff, type AuditEntry, type ContentStatus } from "@/lib/admin";
import type { AppRole } from "@/lib/supabase/server";

export default async function Journal() {
  const { supabase } = await requireStaff();
  const { data } = await supabase.from("audit_log").select("*").order("id", { ascending: false }).limit(100).returns<AuditEntry[]>();
  const value = (entry: AuditEntry) => entry.action === "role_changed" ? `${ROLE_LABEL[entry.from_value as AppRole]} vers ${ROLE_LABEL[entry.to_value as AppRole]}` : STATUS_LABEL[entry.to_value as ContentStatus] ?? "";
  return (
    <main className="py-5">
      <h1 className="text-3xl">Journal</h1>
      <p className="text-muted">Les entrées ne peuvent être ni modifiées ni supprimées.</p>
      {data?.length ? <ol className="mt-4 divide-y divide-line border-y border-line">
        {data.map((entry) => <li key={entry.id} className="py-2"><span className="font-medium">{ACTION_LABEL[entry.action] ?? entry.action}</span> par {entry.actor_name}{value(entry) ? `. ${value(entry)}` : ""}
          <span className="block text-base text-muted">{formatDate(entry.at)}{entry.note ? `. ${entry.note}` : ""}</span>
          {entry.item_id ? <Link href={`/admin/contenus/${entry.item_id}`} className="inline-flex min-h-11 items-center text-emerald underline underline-offset-4">Ouvrir le contenu</Link> : null}</li>)}
      </ol> : <p className="mt-4 text-muted">Aucune action enregistrée.</p>}
    </main>
  );
}
