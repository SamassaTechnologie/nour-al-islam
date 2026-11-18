import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { MUSHAF_PAGES } from "@/lib/mushaf";

export default async function MushafIndex() {
  const saved = Number((await cookies()).get("nour_mushaf_page")?.value);
  redirect(`/coran/mushaf/${Number.isInteger(saved) && saved >= 1 && saved <= MUSHAF_PAGES ? saved : 1}`);
}
