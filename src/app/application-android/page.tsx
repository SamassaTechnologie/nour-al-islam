import type { Metadata } from "next";
import { ANDROID_APP } from "@/lib/android";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Application Android" };

export default async function AndroidPage() {
  const { t } = await getPreferences();
  const a = t.android;
  return (
    <main className="mx-auto max-w-xl px-5 pt-8 pb-16" data-android-page>
      <h1 className="text-3xl">{a.title}</h1>
      <p className="mt-3">{a.intro}</p>
      <a
        href={ANDROID_APP.url}
        download
        data-android-download
        className="mt-6 flex min-h-12 items-center justify-center rounded-lg bg-emerald px-5 text-lg font-medium text-on-emerald"
      >
        {a.download}
      </a>
      <p className="mt-2 text-center text-base text-muted">
        {a.version} {ANDROID_APP.version} · {a.size} {ANDROID_APP.sizeMb} Mo · Android 7.0+
      </p>
      <section className="mt-8">
        <h2 className="text-xl">{a.stepsTitle}</h2>
        <ol className="mt-3 list-decimal space-y-2 ps-6">
          {a.steps.map((step) => <li key={step}>{step}</li>)}
        </ol>
      </section>
      <p className="mt-6 rounded-lg bg-tint p-4 text-base">{a.trial}</p>
      <dl className="mt-6 text-base text-muted">
        <dt>{a.check}</dt>
        <dd dir="ltr" lang="en" className="text-start break-all font-mono text-sm" data-android-sha>{ANDROID_APP.sha256}</dd>
        <dt className="mt-3">{a.signature}</dt>
        <dd dir="ltr" lang="en" className="text-start break-all font-mono text-sm">{ANDROID_APP.certSha256}</dd>
      </dl>
    </main>
  );
}
