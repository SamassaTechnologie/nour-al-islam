"use client";

import { useActionState, useState, type ReactNode } from "react";
import { startMfa, verifyMfa, type AdminState, type MfaState } from "@/app/admin/actions";

export const inputClass = "mt-1 block min-h-11 w-full rounded-lg border border-line bg-page px-3 py-2 font-normal";

export function AdminForm({ action, submit, tone = "primary", className = "", done, children }: {
  action: (state: AdminState, form: FormData) => Promise<AdminState>;
  submit: string;
  tone?: "primary" | "plain" | "danger";
  className?: string;
  done?: string;
  children?: ReactNode;
}) {
  const [state, run, pending] = useActionState(action, {});
  const style = tone === "primary" ? "bg-emerald text-on-emerald" : tone === "danger" ? "border border-danger text-danger" : "border border-line";
  return (
    <form action={run} className={`space-y-3 ${className}`}>
      {children}
      {state.error ? <p role="alert" className="font-medium text-danger">{state.error}</p> : null}
      {state.ok && done ? <p role="status" className="text-emerald">{done}</p> : null}
      <button disabled={pending} className={`min-h-11 rounded-lg px-4 font-medium disabled:opacity-50 ${style}`}>{pending ? "Patientez…" : submit}</button>
    </form>
  );
}

export function MfaPanel({ factorId, canAdd }: { factorId: string | null; canAdd: boolean }) {
  const [enroll, setEnroll] = useState<MfaState>({});
  const [busy, setBusy] = useState(false);
  const [state, run, pending] = useActionState(verifyMfa, {});
  const current = enroll.factorId ?? factorId;
  const begin = async () => {
    setBusy(true);
    setEnroll(await startMfa());
    setBusy(false);
  };
  return (
    <div className="mt-4 space-y-4">
      {enroll.qr ? (
        <ol className="list-decimal space-y-3 ps-5">
          <li>Ouvrez une application d’authentification (Google Authenticator, Microsoft Authenticator ou l’app Mots de passe de l’iPhone).
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src={enroll.qr} alt="Code QR de double authentification" className="mt-2 h-48 w-48 rounded-lg bg-white p-2" />
          </li>
          <li>Sur le téléphone même, saisissez cette clé : <code data-mfa-secret className="break-all">{enroll.secret}</code></li>
          <li>Entrez ci-dessous le code à 6 chiffres affiché.</li>
        </ol>
      ) : null}
      {enroll.error ? <p role="alert" className="font-medium text-danger">{enroll.error}</p> : null}
      {current ? (
        <form action={run} className="space-y-3">
          <input type="hidden" name="factor" value={current} />
          <label className="block font-medium">Code à 6 chiffres
            <input name="code" required inputMode="numeric" autoComplete="one-time-code" pattern="[0-9 ]{6,7}" className={inputClass} />
          </label>
          {state.error ? <p role="alert" className="font-medium text-danger">{state.error}</p> : null}
          <button disabled={pending} className="min-h-11 rounded-lg bg-emerald px-4 font-medium text-on-emerald disabled:opacity-50">{pending ? "Vérification…" : "Valider"}</button>
        </form>
      ) : null}
      {!enroll.qr && (!factorId || canAdd) ? <button type="button" disabled={busy} onClick={begin} className="min-h-11 rounded-lg border border-line px-4 font-medium disabled:opacity-50">{factorId ? "Ajouter un second téléphone" : "Activer la double authentification"}</button> : null}
    </div>
  );
}
