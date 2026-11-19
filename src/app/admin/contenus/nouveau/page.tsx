import { notFound } from "next/navigation";
import { createContent } from "@/app/admin/actions";
import { AdminForm, inputClass } from "@/components/admin-form";
import { KIND_LABEL, SECTION_LABEL, requireStaff } from "@/lib/admin";

export default async function NewContent() {
  const { role } = await requireStaff();
  if (role !== "editor" && role !== "admin") notFound();
  return (
    <main className="py-5">
      <h1 className="text-3xl">Nouveau contenu</h1>
      <AdminForm action={createContent} submit="Créer le brouillon" className="mt-4">
        <label className="block font-medium">Titre<input name="title" required minLength={3} maxLength={160} className={inputClass} /></label>
        <label className="block font-medium">Type<select name="kind" className={inputClass}>{Object.entries(KIND_LABEL).map(([value, label]) => <option key={value} value={value}>{label}</option>)}</select></label>
        <label className="block font-medium">Rubrique<select name="section" className={inputClass}>{Object.entries(SECTION_LABEL).map(([value, label]) => <option key={value} value={value}>{label}</option>)}</select></label>
        <label className="block font-medium">Langue<select name="locale" className={inputClass}><option value="fr">Français</option><option value="ar">Arabe</option></select></label>
      </AdminForm>
    </main>
  );
}
