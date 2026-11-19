"use client";

import { useState } from "react";

type Labels = { tap: string; tapLabel: string; done: string; reset: string; progress: string };

/** Compteur de répétitions : un toucher compte une répétition, jusqu'au nombre indiqué par le hadith. */
export function DhikrCounter({ total, t }: { total: number; t: Labels }) {
  const [count, setCount] = useState(0);
  const finished = count >= total;
  const fill = (text: string) => text.replace("{done}", String(count)).replace("{n}", String(total));
  return (
    <div className="mt-3 flex flex-wrap items-center gap-3" data-counter data-total={total}>
      <button
        type="button"
        onClick={() => setCount((value) => Math.min(value + 1, total))}
        disabled={finished}
        aria-label={fill(t.tapLabel)}
        className="min-h-12 min-w-28 rounded-full bg-emerald px-5 font-medium text-on-emerald disabled:opacity-70"
        data-count={count}
      >
        {finished ? t.done : t.tap}
      </button>
      <span aria-live="polite" className="font-medium tabular-nums" data-progress>{fill(t.progress)}</span>
      {count > 0 ? <button type="button" onClick={() => setCount(0)} className="min-h-11 text-muted underline underline-offset-4" data-reset>{t.reset}</button> : null}
    </div>
  );
}
