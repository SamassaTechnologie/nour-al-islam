import { MfaPanel } from "@/components/admin-form";
import { requireStaff } from "@/lib/admin";

export default async function Security() {
  const { aal, role } = await requireStaff({ mfa: false });
  const factor = aal.verified[0]?.id ?? null;
  const strong = aal.current === "aal2";
  return (
    <main className="py-5">
      <h1 className="text-3xl">Double authentification</h1>
      {strong ? (
        <p role="status" className="mt-2 font-medium text-emerald">Votre session est protégée. Téléphones enregistrés : {aal.verified.length}.</p>
      ) : factor ? (
        <p className="mt-2">Entrez le code de votre application d’authentification pour continuer.</p>
      ) : (
        <p className="mt-2">{role === "editor" ? "Elle est recommandée pour votre compte." : "Elle est obligatoire pour les administrateurs et les réviseurs."} Après le mot de passe, un code temporaire de votre téléphone sera demandé.</p>
      )}
      <MfaPanel factorId={strong ? null : factor} canAdd={strong} />
      <p className="mt-5 text-base text-muted">Enregistrez un second téléphone si possible : sans téléphone, l’accès à l’administration sera bloqué.</p>
    </main>
  );
}
