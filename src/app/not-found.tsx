import Link from "next/link";
import { getPreferences } from "@/lib/preferences";

export default async function NotFound() {
  const { t } = await getPreferences();
  return (
    <main className="mx-auto max-w-md px-5 pt-12">
      <h1 className="text-3xl">{t.notFound.title}</h1>
      <Link href="/" className="mt-4 inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{t.notFound.action}</Link>
    </main>
  );
}
