"use client";

import Link from "next/link";
import { useState, useTransition } from "react";
import { askAssistant, type AssistantResult } from "@/app/assistant-actions";
import type { Dictionary } from "@/lib/dictionaries";

type T = Dictionary["assistant"];
type Entry = { question: string; result: AssistantResult };

export function AssistantChat({ t }: { t: T }) {
  const [question, setQuestion] = useState("");
  const [entries, setEntries] = useState<Entry[]>([]);
  const [pending, start] = useTransition();

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    const q = question.trim();
    if (q.length < 5 || pending) return;
    start(async () => {
      const result = await askAssistant(q);
      setEntries((list) => [{ question: q, result }, ...list]);
      if (result.ok) setQuestion("");
    });
  };

  return (
    <div data-assistant>
      <form onSubmit={submit} className="mt-4">
        <label htmlFor="assistant-q" className="font-medium">{t.label}</label>
        <textarea id="assistant-q" value={question} onChange={(e) => setQuestion(e.target.value)} maxLength={500} rows={3} placeholder={t.placeholder}
          className="mt-1 w-full rounded-lg border border-line bg-page p-3 outline-none focus:border-emerald" data-question />
        <div className="mt-1 flex items-center justify-between text-base text-muted"><span>{question.length}/500</span></div>
        <button type="submit" disabled={pending || question.trim().length < 5} className="mt-2 min-h-12 w-full rounded-lg bg-emerald px-4 font-medium text-on-emerald" data-ask>
          {pending ? t.thinking : t.ask}
        </button>
      </form>
      <ol className="mt-6 space-y-6">
        {entries.map((entry, i) => (
          <li key={entries.length - i} data-answer={entry.result.ok ? "ok" : entry.result.error}>
            <p className="font-medium">{entry.question}</p>
            {entry.result.ok ? (
              <div className="mt-2 rounded-lg bg-tint p-4">
                <p className="whitespace-pre-line" data-answer-text>{entry.result.answer}</p>
                {entry.result.sources.length ? (
                  <>
                    <p className="mt-3 font-medium">{t.sources}</p>
                    <ul className="mt-1 space-y-1" data-sources>
                      {entry.result.sources.map((s) => (
                        <li key={s.n}><Link href={s.href} className="text-emerald underline underline-offset-4" data-source={s.href}>[{s.n}] {s.title}</Link></li>
                      ))}
                    </ul>
                  </>
                ) : null}
                <p className="mt-3 text-base text-muted" data-remaining={entry.result.remaining}>{t.remaining.replace("{n}", String(entry.result.remaining))}</p>
              </div>
            ) : <p className="mt-2 rounded-lg border border-line p-4" role="alert">{t.errors[entry.result.error]}</p>}
          </li>
        ))}
      </ol>
    </div>
  );
}
