import type { Metadata } from "next";
import Link from "next/link";
import { requireStaff } from "@/lib/admin";

export const metadata: Metadata = { title: "Administration", robots: { index: false, follow: false } };

const link = "inline-flex min-h-11 items-center whitespace-nowrap px-2 font-medium text-emerald";

export default async function AdminLayout({ children }: { children: React.ReactNode }) {
  const { role } = await requireStaff({ mfa: false });
  return (
    <div lang="fr" dir="ltr" className="mx-auto max-w-3xl px-4 pt-3">
      <nav aria-label="Administration" className="-mx-2 flex overflow-x-auto border-b border-line">
        <Link href="/admin" className={link}>Tableau de bord</Link>
        <Link href="/admin/contenus" className={link}>Contenus</Link>
        <Link href="/admin/journal" className={link}>Journal</Link>
        {role === "admin" ? <Link href="/admin/utilisateurs" className={link}>Utilisateurs</Link> : null}
        <Link href="/admin/securite" className={link}>Sécurité</Link>
      </nav>
      {children}
    </div>
  );
}
