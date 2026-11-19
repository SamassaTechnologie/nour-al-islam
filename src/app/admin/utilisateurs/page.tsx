import { notFound } from "next/navigation";
import { setRole } from "@/app/admin/actions";
import { AdminForm, inputClass } from "@/components/admin-form";
import { ROLE_LABEL, requireStaff } from "@/lib/admin";
import type { AppRole } from "@/lib/supabase/server";

type Row = { id: string; display_name: string; email: string; role: AppRole; has_mfa: boolean };

export default async function Users() {
  const { supabase, role } = await requireStaff();
  if (role !== "admin") notFound();
  const { data, error } = await supabase.rpc("admin_list_users");
  if (error) throw new Error(error.message);
  const users = (data ?? []) as Row[];
  return (
    <main className="py-5">
      <h1 className="text-3xl">Utilisateurs</h1>
      <p className="mt-1 text-muted">Le réviseur religieux doit être une personne qualifiée, désignée par vous. Lui seul peut publier.</p>
      <ul className="mt-4 divide-y divide-line border-y border-line">
        {users.map((user) => (
          <li key={user.id} className="py-3" data-user={user.email}>
            <p className="font-medium break-words">{user.display_name}</p>
            <p className="break-all text-base text-muted">{user.email}</p>
            <p className="text-base text-muted">Double authentification : {user.has_mfa ? "active" : "non activée"}</p>
            <AdminForm action={setRole} submit="Changer le rôle" tone="plain" done="Rôle mis à jour." className="mt-2">
              <input type="hidden" name="user" value={user.id} />
              <label className="block font-medium">Rôle<select name="role" defaultValue={user.role} className={inputClass}>{Object.entries(ROLE_LABEL).map(([value, label]) => <option key={value} value={value}>{label}</option>)}</select></label>
            </AdminForm>
          </li>
        ))}
      </ul>
    </main>
  );
}
