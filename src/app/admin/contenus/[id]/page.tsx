import { notFound } from "next/navigation";
import { setPosition, addOpinion, addQuestion, addReference, contentAction, newRevision, removeOpinion, removeQuestion, removeReference, saveRevision, verifyReference } from "@/app/admin/actions";
import { AdminForm, inputClass } from "@/components/admin-form";
import { ArabicVerse } from "@/components/quran-view";
import { Paragraphs, referenceText } from "@/components/content-view";
import { ACTION_LABEL, KIND_LABEL, SECTION_LABEL, formatDate, statusText, requireStaff, type AuditEntry, type Dhikr, type Item, type Opinion, type Question, type Reference, type Revision } from "@/lib/admin";
import { withExcerpts } from "@/lib/quiz";
import { getSurahs, getSurahVerses, verseBody } from "@/lib/quran";

const label = "block font-medium";
const hidden = (name: string, value: string) => <input type="hidden" name={name} value={value} />;

async function VerseText({ reference }: { reference: Reference }) {
  const verses = (await getSurahVerses(reference.surah!)).filter((v) => v.number >= reference.ayah_from! && v.number <= reference.ayah_to!);
  return <div className="mt-1">{verses.map((v) => <ArabicVerse key={v.id} text={verseBody(v.text_uthmani, v.bismillah_length)} />)}</div>;
}

export default async function ContentDetail({ params }: { params: Promise<{ id: string }> }) {
  const [{ id }, staff, surahs] = await Promise.all([params, requireStaff(), getSurahs()]);
  if (!/^[0-9a-f-]{36}$/.test(id)) notFound();
  const { supabase, role, userId } = staff;
  const { data: item } = await supabase.from("content_items").select("id,slug,kind,section,locale,published_revision_id,position").eq("id", id).maybeSingle<Item & { position: number | null }>();
  if (!item) notFound();
  const { data: revisions } = await supabase.from("content_revisions").select("*").eq("item_id", id).order("number", { ascending: false }).returns<Revision[]>();
  const rev = revisions?.[0];
  if (!rev) notFound();
  const [{ data: refs }, { data: opinions }, { data: log }, { data: rawQuestions }, { data: adhkar }] = await Promise.all([
    supabase.from("content_references").select("*").eq("revision_id", rev.id).order("ord").returns<Reference[]>(),
    supabase.from("content_opinions").select("id,holder,opinion,source").eq("revision_id", rev.id).order("ord").returns<Opinion[]>(),
    supabase.from("audit_log").select("*").eq("item_id", id).order("id", { ascending: false }).limit(50).returns<AuditEntry[]>(),
    supabase.from("content_questions").select("*").eq("revision_id", rev.id).order("ord").returns<Question[]>(),
    supabase.from("content_adhkar").select("*").eq("revision_id", rev.id).order("ord").returns<Dhikr[]>(),
  ]);
  const questions = await withExcerpts(rawQuestions ?? []);
  const references = refs ?? [];
  const isAuthor = rev.author_id === userId;
  const canWrite = role === "editor" || role === "admin";
  const editable = canWrite && (rev.status === "draft" || rev.status === "changes_requested");
  const canVerify = rev.status === "source_check" && !isAuthor;
  const canReview = rev.status === "in_review" && role === "reviewer" && !isAuthor;
  const awaitingScholar = rev.status === "published" && rev.review_kind === "ai";
  const canValidate = awaitingScholar && role === "reviewer" && !isAuthor;
  const ids = <>{hidden("item", id)}{hidden("revision", rev.id)}</>;
  const action = (name: string) => hidden("action", name);
  const lastNote = log?.find((entry) => entry.action === "request_changes" && rev.status === "changes_requested")?.note;

  return (
    <main className="space-y-7 py-5">
      <header>
        <p className="text-muted">{KIND_LABEL[item.kind]}, {SECTION_LABEL[item.section]}</p>
        <h1 className="text-3xl break-words">{rev.title}</h1>
        <p className="mt-1 font-medium" data-status={rev.status} data-review={rev.review_kind ?? ""}>{statusText(rev.status, rev.review_kind)}, version {rev.number}</p>
        <p className="text-base text-muted">Auteur : {rev.author_name}{rev.ai_assisted ? ". Préparé avec l’aide de l’IA" : ""}</p>
        {item.published_revision_id ? <a href={`/apprendre/${item.slug}`} className="inline-flex min-h-11 items-center font-medium text-emerald underline underline-offset-4">{awaitingScholar ? "Voir la version provisoire" : "Voir la version publique"}</a> : null}
        {awaitingScholar ? <p role="status" className="mt-2 border-s-2 border-gold ps-3">Relu par {rev.reviewer_name}{rev.published_at ? `, ${formatDate(rev.published_at)}` : ""}. Visible seulement par l’équipe tant qu’un réviseur religieux ne l’a pas validé.</p> : null}
      </header>

      {canWrite ? (
        <AdminForm action={setPosition} submit="Enregistrer la place" done="Place enregistrée." tone="plain">
          {hidden("item", id)}
          <label className={label}>Place dans le parcours « {SECTION_LABEL[item.section]} » (vide : à la fin)<input name="position" type="number" min={1} max={999} defaultValue={item.position ?? ""} className={inputClass} /></label>
        </AdminForm>
      ) : item.position ? <p className="text-muted">Place dans le parcours : {item.position}</p> : null}

      {lastNote ? <p role="status" className="border-s-2 border-gold ps-3"><span className="font-medium">Corrections demandées : </span>{lastNote}</p> : null}

      {editable ? (
        <AdminForm action={saveRevision} submit="Enregistrer" done="Enregistré." tone="plain">
          {ids}
          <label className={label}>Titre<input name="title" required maxLength={160} defaultValue={rev.title} className={inputClass} /></label>
          <label className={label}>Résumé<textarea name="summary" rows={2} maxLength={400} defaultValue={rev.summary} className={inputClass} /></label>
          <label className={label}>Texte<textarea name="body" rows={12} maxLength={60000} defaultValue={rev.body} dir={item.locale === "ar" ? "rtl" : "ltr"} className={inputClass} /></label>
          <p className="text-base text-muted">N’écrivez ici ni verset ni hadith de mémoire : ajoutez-les comme références, le verset sera affiché depuis le texte verrouillé.</p>
          <label className="flex min-h-11 items-center gap-2"><input type="checkbox" name="ai_assisted" defaultChecked={rev.ai_assisted} className="h-5 w-5" />Préparé avec l’aide de l’IA</label>
        </AdminForm>
      ) : (
        <section dir={item.locale === "ar" ? "rtl" : "ltr"} lang={item.locale}>
          {rev.summary ? <p className="font-medium">{rev.summary}</p> : null}
          <Paragraphs text={rev.body} />
        </section>
      )}

      <section>
        <h2 className="text-xl">Références</h2>
        {references.length ? (
          <ul className="mt-2 divide-y divide-line border-y border-line">
            {references.map((ref) => (
              <li key={ref.id} className="py-3" data-reference={ref.kind}>
                <p className="break-words">{referenceText(ref, surahs)}</p>
                {ref.kind === "quran" ? <VerseText reference={ref} /> : null}
                {ref.url ? <a href={ref.url} rel="noreferrer" target="_blank" className="inline-flex min-h-11 items-center break-all text-emerald underline underline-offset-4">{ref.url}</a> : null}
                {ref.note ? <p className="text-base text-muted">{ref.note}</p> : null}
                <p className="text-base text-muted">{ref.verified_at ? `Vérifiée par ${ref.verified_name}, ${formatDate(ref.verified_at)}` : "Non vérifiée"}</p>
                {canVerify ? <AdminForm action={verifyReference} submit={ref.verified_at ? "Annuler la vérification" : "Vérifiée dans l’ouvrage d’origine"} tone="plain" className="mt-1">{hidden("item", id)}{hidden("id", ref.id)}{hidden("verified", String(!ref.verified_at))}</AdminForm> : null}
                {editable ? <AdminForm action={removeReference} submit="Retirer" tone="plain" className="mt-1">{hidden("item", id)}{hidden("id", ref.id)}</AdminForm> : null}
              </li>
            ))}
          </ul>
        ) : <p className="mt-1 text-muted">Aucune référence.</p>}
        {editable ? (
          <div className="mt-3 space-y-2">
            <details className="rounded-lg border border-line p-3"><summary className="min-h-8 font-medium">Ajouter un verset</summary>
              <AdminForm action={addReference} submit="Ajouter le verset" tone="plain" className="mt-3">{ids}{hidden("kind", "quran")}
                <label className={label}>Sourate<select name="surah" className={inputClass}>{surahs.map((s) => <option key={s.number} value={s.number}>{s.number}. {s.name_translit}</option>)}</select></label>
                <div className="grid grid-cols-2 gap-3"><label className={label}>Du verset<input name="ayah_from" type="number" min={1} required className={inputClass} /></label><label className={label}>Au verset<input name="ayah_to" type="number" min={1} className={inputClass} /></label></div>
              </AdminForm></details>
            <details className="rounded-lg border border-line p-3"><summary className="min-h-8 font-medium">Ajouter un hadith</summary>
              <AdminForm action={addReference} submit="Ajouter le hadith" tone="plain" className="mt-3">{ids}{hidden("kind", "hadith")}
                {[["collection", "Recueil"], ["edition", "Édition"], ["hadith_number", "Numéro dans cette édition"], ["source_title", "Source consultée"], ["grade", "Degré d’authenticité"], ["graded_by", "Degré établi par"]].map(([name, text]) => <label key={name} className={label}>{text}<input name={name} required className={inputClass} /></label>)}
                <label className={label}>Lien (https, facultatif)<input name="url" type="url" pattern="https://.*" className={inputClass} /></label>
              </AdminForm></details>
            <details className="rounded-lg border border-line p-3"><summary className="min-h-8 font-medium">Ajouter un ouvrage ou un savant</summary>
              <AdminForm action={addReference} submit="Ajouter l’ouvrage" tone="plain" className="mt-3">{ids}{hidden("kind", "book")}
                {[["author", "Auteur ou savant"], ["source_title", "Titre de l’ouvrage"], ["locator", "Tome, page ou chapitre"]].map(([name, text]) => <label key={name} className={label}>{text}<input name={name} required className={inputClass} /></label>)}
                <label className={label}>Lien (https, facultatif)<input name="url" type="url" pattern="https://.*" className={inputClass} /></label>
              </AdminForm></details>
          </div>
        ) : null}
      </section>

      {item.kind === "legal_opinion" || opinions?.length ? (
        <section>
          <h2 className="text-xl">Avis des savants</h2>
          <ul className="mt-2 divide-y divide-line border-y border-line">
            {(opinions ?? []).map((o) => <li key={o.id} className="py-3"><p className="font-medium">{o.holder}</p><p>{o.opinion}</p><p className="text-base text-muted">{o.source}</p>{editable ? <AdminForm action={removeOpinion} submit="Retirer" tone="plain" className="mt-1">{hidden("item", id)}{hidden("id", o.id)}</AdminForm> : null}</li>)}
          </ul>
          {editable ? <details className="mt-3 rounded-lg border border-line p-3"><summary className="min-h-8 font-medium">Ajouter un avis</summary><AdminForm action={addOpinion} submit="Ajouter l’avis" tone="plain" className="mt-3">{ids}
            <label className={label}>Savant ou école<input name="holder" required className={inputClass} /></label><label className={label}>Avis<textarea name="opinion" required rows={3} className={inputClass} /></label><label className={label}>Référence<input name="source" required className={inputClass} /></label></AdminForm></details> : null}
        </section>
      ) : null}

      {adhkar?.length ? (
        <section>
          <h2 className="text-xl">Invocations ({adhkar.length})</h2>
          <p className="text-base text-muted">Texte arabe découpé automatiquement dans le recueil cité (scripts/adhkar), jamais saisi à la main.</p>
          <ol className="mt-2 divide-y divide-line border-y border-line">
            {adhkar.map((d, n) => (
              <li key={d.id} className="py-3" data-dhikr-admin>
                <p className="font-medium">{n + 1}. {d.title}{d.when_to_say ? ` (${d.when_to_say})` : ""}</p>
                {d.surah ? <p className="font-medium">Versets lus dans le texte coranique verrouillé : sourate {d.surah}, versets {d.ayah_from} à {d.ayah_to}</p> : <p lang="ar" dir="rtl" className="quran-text">{d.arabic}</p>}
                <p className="italic">{d.transliteration}</p>
                {d.meaning ? <p>{d.meaning}</p> : null}
                <p className="text-base">Répétitions : {d.repeat_count}{d.virtue ? `. Mérite : ${d.virtue}` : ""}</p>
                <p className="text-base text-muted">{d.collection}, n° {d.hadith_number}. Degré : {d.grade} ({d.graded_by}). <a href={d.url} rel="noreferrer" target="_blank" className="text-emerald underline">{d.url}</a>{d.note ? ` ${d.note}` : ""}</p>
              </li>
            ))}
          </ol>
        </section>
      ) : null}

      <section>
        <h2 className="text-xl">Exercices</h2>
        {questions.length ? (
          <ol className="mt-2 divide-y divide-line border-y border-line">
            {questions.map((q, n) => (
              <li key={q.id} className="py-3" data-question-admin>
                <p className="font-medium">{n + 1}. {q.prompt}</p>
                {q.display ? <p lang="ar" dir="rtl" className="text-4xl">{q.display}</p> : null}
                {q.excerpt ? <><p lang="ar" dir="rtl" className="quran-text" data-excerpt>{q.excerpt.text}</p><p className="text-base text-muted">Extrait du texte verrouillé : sourate {q.excerpt.name} ({q.excerpt.surah}), verset {q.excerpt.ayah}, mots {q.word_from} à {q.word_to}</p></> : null}
                <ul className="mt-1">{q.options.map((option, i) => <li key={i} dir="auto" className={i === q.answer ? "font-medium text-emerald" : ""}>{i === q.answer ? "Bonne réponse : " : ""}{option}</li>)}</ul>
                <p className="text-base text-muted">{q.explanation}</p>
                {editable ? <AdminForm action={removeQuestion} submit="Retirer" tone="plain" className="mt-1">{hidden("item", id)}{hidden("id", q.id)}</AdminForm> : null}
              </li>
            ))}
          </ol>
        ) : <p className="mt-1 text-muted">Aucun exercice.</p>}
        {editable ? (
          <details className="mt-3 rounded-lg border border-line p-3"><summary className="min-h-8 font-medium">Ajouter une question</summary>
            <AdminForm action={addQuestion} submit="Ajouter la question" tone="plain" className="mt-3">{ids}
              <label className={label}>Question<input name="prompt" required maxLength={300} className={inputClass} /></label>
              <label className={label}>Lettre ou mot arabe à afficher (facultatif, jamais un verset)<input name="display" dir="rtl" maxLength={40} className={inputClass} /></label>
              <p className="text-base text-muted">Extrait coranique facultatif : il sera lu dans le texte verrouillé.</p>
              <label className={label}>Sourate<select name="surah" className={inputClass}><option value="">Aucun extrait</option>{surahs.map((s) => <option key={s.number} value={s.number}>{s.number}. {s.name_translit}</option>)}</select></label>
              <div className="grid grid-cols-3 gap-2"><label className={label}>Verset<input name="ayah" type="number" min={1} className={inputClass} /></label><label className={label}>Du mot<input name="word_from" type="number" min={1} className={inputClass} /></label><label className={label}>Au mot<input name="word_to" type="number" min={1} className={inputClass} /></label></div>
              {[1, 2, 3, 4, 5].map((n) => <label key={n} className={label}>Choix {n}{n > 2 ? " (facultatif)" : ""}<input name={`option_${n}`} required={n <= 2} maxLength={200} dir="auto" className={inputClass} /></label>)}
              <label className={label}>Bonne réponse<select name="answer" className={inputClass}>{[1, 2, 3, 4, 5].map((n) => <option key={n} value={n}>Choix {n}</option>)}</select></label>
              <label className={label}>Explication<textarea name="explanation" required rows={2} maxLength={600} className={inputClass} /></label>
            </AdminForm>
          </details>
        ) : null}
      </section>

      <section className="space-y-4">
        <h2 className="text-xl">Étape suivante</h2>
        {editable ? <AdminForm action={contentAction} submit="Envoyer à la vérification des sources">{ids}{action("submit")}</AdminForm> : null}
        {canVerify ? <AdminForm action={contentAction} submit="Confirmer les sources">{ids}{action("confirm_sources")}</AdminForm> : null}
        {rev.status === "source_check" && isAuthor ? <p className="text-muted">Une autre personne doit vérifier vos références.</p> : null}
        {rev.status === "in_review" && !canReview ? <p className="text-muted">{isAuthor && role === "reviewer" ? "Un autre réviseur doit relire votre texte." : "En attente d’un réviseur religieux."}</p> : null}
        {canReview ? <AdminForm action={contentAction} submit="Approuver et publier">{ids}{action("publish")}<p>Sources confirmées par {rev.source_checked_name}. Votre nom sera affiché avec ce contenu.</p></AdminForm> : null}
        {canValidate ? <AdminForm action={contentAction} submit="Valider ce contenu">{ids}{action("validate")}<p>Relu et corrigé par l’assistant IA. Votre validation rendra ce contenu visible par tous, avec votre nom.</p><label className={label}>Remarque (facultatif)<textarea name="note" rows={2} className={inputClass} /></label></AdminForm> : null}
        {awaitingScholar && !canValidate ? <p className="text-muted">En attente de la validation d’un réviseur religieux.</p> : null}
        {canVerify || canReview ? <AdminForm action={contentAction} submit="Renvoyer pour corrections" tone="plain">{ids}{action("request_changes")}<label className={label}>Corrections demandées<textarea name="note" required rows={3} className={inputClass} /></label></AdminForm> : null}
        {rev.status === "published" && (role === "reviewer" || role === "admin") ? <AdminForm action={contentAction} submit="Retirer de la publication" tone="danger">{ids}{action("withdraw")}<label className={label}>Motif du retrait<textarea name="note" required rows={2} className={inputClass} /></label></AdminForm> : null}
        {canWrite && (rev.status === "published" || rev.status === "withdrawn" || rev.status === "superseded") ? <AdminForm action={newRevision} submit="Créer une nouvelle version" tone="plain">{hidden("item", id)}</AdminForm> : null}
      </section>

      <section>
        <h2 className="text-xl">Historique</h2>
        <ol className="mt-2 divide-y divide-line border-y border-line">
          {(log ?? []).map((entry) => <li key={entry.id} className="py-2"><span className="font-medium">{ACTION_LABEL[entry.action] ?? entry.action}</span> par {entry.actor_name}<span className="block text-base text-muted">{formatDate(entry.at)}{entry.note ? `. ${entry.note}` : ""}</span></li>)}
        </ol>
      </section>
    </main>
  );
}
