"use client";

import { useState, useTransition } from "react";
import { toggleFavorite } from "@/app/favorite-actions";

type T = { add: string; remove: string; error: string };

/** Bouton « favori » d'une lecon ou d'une categorie d'invocations (personnes connectees). */
export function FavoriteButton({ itemId, initial, t }: { itemId: string; initial: boolean; t: T }) {
  const [saved, setSaved] = useState(initial);
  const [failed, setFailed] = useState(false);
  const [pending, start] = useTransition();
  return (
    <div className="mt-3">
      <button
        type="button"
        disabled={pending}
        aria-pressed={saved}
        data-favorite={saved ? "1" : "0"}
        onClick={() => start(async () => {
          const result = await toggleFavorite(itemId);
          setFailed(result === null);
          if (result !== null) setSaved(result);
        })}
        className={`inline-flex min-h-11 items-center gap-2 rounded-lg border px-4 font-medium ${saved ? "border-gold text-gold-ink" : "border-line text-muted"}`}
      >
        <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5" fill={saved ? "currentColor" : "none"} stroke="currentColor" strokeWidth="1.6" strokeLinejoin="round">
          <path d="m12 3.5 2.6 5.3 5.9.9-4.3 4.1 1 5.8-5.2-2.7-5.2 2.7 1-5.8-4.3-4.1 5.9-.9Z" />
        </svg>
        {saved ? t.remove : t.add}
      </button>
      {failed ? <p role="alert" className="mt-1 text-base">{t.error}</p> : null}
    </div>
  );
}
