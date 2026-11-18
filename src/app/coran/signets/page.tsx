import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { ArabicVerse } from "@/components/quran-view";
import { getBookmarks, getSurahs, verseBody } from "@/lib/quran";
import { getPreferences } from "@/lib/preferences";

export const metadata: Metadata = { title: "Signets" };

export default async function BookmarksPage() {
  const bookmarks = await getBookmarks();
  if (!bookmarks) redirect("/connexion?suivant=/coran/signets");
  const [{ t }, surahs] = await Promise.all([getPreferences(), getSurahs()]);
  const q = t.quran;
  return (
    <main className="mx-auto max-w-xl px-5 pt-6">
      <h1 className="text-3xl">{q.bookmarks}</h1>
      {bookmarks.length === 0 ? <p className="mt-3 text-muted">{q.noBookmarks}</p> : null}
      <ul className="mt-3">
        {bookmarks.map(({ ayah_id, ayahs: v }) => (
          <li key={ayah_id} className="border-b border-line py-4">
            <Link href={`/coran/${v.surah}#v${v.surah}-${v.number}`} className="inline-flex min-h-11 items-center font-medium text-emerald">
              {surahs[v.surah - 1].name_translit} {v.surah}:{v.number}
            </Link>
            <ArabicVerse text={verseBody(v.text_uthmani, v.bismillah_length)} />
          </li>
        ))}
      </ul>
    </main>
  );
}
