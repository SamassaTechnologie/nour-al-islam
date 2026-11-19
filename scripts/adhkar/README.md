# Textes arabes des invocations

Les textes arabes des invocations ne sont jamais saisis à la main. `extract.py` les découpe
dans les recueils de hadiths de la base libre de droits hadith-api (fawazahmed0, licence Unlicense),
qui reprend le texte et la numérotation de sunnah.com.

1. Télécharger les éditions arabes et anglaises complètes dans `/tmp/h` (`full-ara-<recueil>.json`, `full-eng-<recueil>.json`)
   depuis `https://raw.githubusercontent.com/fawazahmed0/hadith-api/1/editions/`.
2. `python3 extract.py` écrit `/tmp/h/adhkar.json` (texte exact, recueil, numéro, jugements).
3. Le test `tests/adhkar.mjs` compare le texte affiché dans l'application au texte de la source.
