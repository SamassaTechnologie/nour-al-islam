import type { Metadata } from "next";
import { getSources } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Sources du Coran" };

export default async function SourcesPage() {
  const [{ t }, sources] = await Promise.all([getPreferences(), getSources()]);
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{t.quran.sourcesTitle}</h1>
      {sources.map((s) => (
        <section key={s.id} className="mt-6 border-t border-line pt-4">
          <h2 className="text-xl">{s.title}</h2>
          <dl className="mt-2 text-muted">
            {s.author ? <div><dt className="inline">{t.quran.translator} : </dt><dd className="inline">{s.author}</dd></div> : null}
            <div><dt className="inline">{t.quran.publisher} : </dt><dd className="inline">{s.publisher}</dd></div>
            <div><dt className="inline">Version : </dt><dd className="inline">{s.version}</dd></div>
            <div><dt className="inline">{t.quran.license} : </dt><dd className="inline">{s.license}</dd></div>
          </dl>
          <a href={s.source_url} className="inline-flex min-h-11 items-center break-all font-medium text-emerald underline underline-offset-4">{s.source_url}</a>
          {s.notice ? <pre dir="ltr" lang="en" className="mt-2 overflow-x-auto rounded-lg bg-tint p-3 text-xs leading-relaxed whitespace-pre-wrap">{s.notice}</pre> : null}
        </section>
      ))}
      <section className="mt-6 border-t border-line pt-4">
        <h2 className="text-xl">{t.quran.mushaf}</h2>
        <p className="mt-2 text-muted">{t.quran.mushafCredit}</p>
        <a href="https://quran.foundation" className="inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">quran.foundation</a>
      </section>
    </main>
  );
}
