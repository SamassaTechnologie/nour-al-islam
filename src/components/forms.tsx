"use client";

import Link from "next/link";
import { useActionState, type InputHTMLAttributes } from "react";
import { useFormStatus } from "react-dom";
import { signIn, signUp, updateProfile, type AuthState, type ProfileState } from "@/app/actions";
import type { Dictionary } from "@/lib/dictionaries";

export const fieldClass =
  "mt-1 block min-h-12 w-full rounded-lg border border-line bg-page px-3 text-ink outline-none focus:border-emerald";
export const primaryButton =
  "inline-flex min-h-12 w-full items-center justify-center rounded-lg bg-emerald px-5 font-medium text-on-emerald disabled:opacity-60";

export function SubmitButton({ label, pending, className = primaryButton }: { label: string; pending: string; className?: string }) {
  const status = useFormStatus();
  return (
    <button type="submit" disabled={status.pending} className={className}>
      {status.pending ? pending : label}
    </button>
  );
}

function Field({ label, hint, ...props }: InputHTMLAttributes<HTMLInputElement> & { label: string; hint?: string }) {
  return (
    <label className="block">
      <span className="font-medium">{label}</span>
      <input className={fieldClass} {...props} />
      {hint ? <span className="mt-1 block text-base text-muted">{hint}</span> : null}
    </label>
  );
}

export function SignInForm({ t, next, initialError }: { t: Dictionary["auth"]; next: string; initialError?: string }) {
  const [state, action] = useActionState<AuthState, FormData>(signIn, {});
  const message = state.error ? t.errors[state.error] : initialError;
  return (
    <form action={action} className="space-y-4">
      <input type="hidden" name="next" value={next} />
      <Field label={t.email} name="email" type="email" dir="ltr" autoComplete="email" required defaultValue={state.email} key={state.email} />
      <Field label={t.password} name="password" type="password" dir="ltr" autoComplete="current-password" required />
      {message ? <p role="alert" className="text-danger">{message}</p> : null}
      <SubmitButton label={t.signIn} pending={t.pending} />
      <p className="text-center text-muted">
        {t.noAccount} <Link href="/inscription" className="font-medium text-emerald underline underline-offset-4">{t.signUp}</Link>
      </p>
    </form>
  );
}

export function SignUpForm({ t }: { t: Dictionary["auth"] }) {
  const [state, action] = useActionState<AuthState, FormData>(signUp, {});
  if (state.checkEmail) {
    return (
      <div role="status" className="border-s-2 border-gold ps-4">
        <h2 className="text-xl">{t.checkEmailTitle}</h2>
        <p className="mt-2 text-muted">{t.checkEmail}</p>
        <p dir="ltr" className="mt-1 break-all text-start font-medium">{state.email}</p>
      </div>
    );
  }
  return (
    <form action={action} className="space-y-4">
      <Field label={t.name} name="name" autoComplete="name" required minLength={2} maxLength={60} defaultValue={state.name} key={`n${state.name}`} />
      <Field label={t.email} name="email" type="email" dir="ltr" autoComplete="email" required defaultValue={state.email} key={`e${state.email}`} />
      <Field label={t.password} hint={t.passwordHint} name="password" type="password" dir="ltr" autoComplete="new-password" required minLength={8} maxLength={72} />
      {state.error ? <p role="alert" className="text-danger">{t.errors[state.error]}</p> : null}
      <SubmitButton label={t.signUp} pending={t.pending} />
      <p className="text-center text-muted">
        {t.hasAccount} <Link href="/connexion" className="font-medium text-emerald underline underline-offset-4">{t.signIn}</Link>
      </p>
    </form>
  );
}

export function ProfileForm({ t, pending, name }: { t: Dictionary["profile"]; pending: string; name: string }) {
  const [state, action] = useActionState<ProfileState, FormData>(updateProfile, {});
  return (
    <form action={action} className="space-y-3">
      <Field label={t.name} name="name" required minLength={2} maxLength={60} defaultValue={name} autoComplete="name" />
      {state.status === "saved" ? <p role="status" className="text-emerald">{t.saved}</p> : null}
      {state.status === "error" ? <p role="alert" className="text-danger">{t.saveError}</p> : null}
      <SubmitButton label={t.save} pending={pending} />
    </form>
  );
}
