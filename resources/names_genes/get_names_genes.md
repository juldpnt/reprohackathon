## Tirer les noms des gènes

## Gene names via AureoWiki

Sur https://aureowiki.med.uni-greifswald.de/download_gene_specific_information on spécifie la souche utilisée pour notre génome de référence (ici NCTC8325 (NCBI,PMID 27035918,UniProt 2016-08-03) et on selectionne les colonnes que l'ont souhaite télécharger (ici en priorité la variable `locus tag` et la variable `pan gene symbol`).

On télécharge au format .tsv pour plus utiliser moins de mémoire.

## Gene roles via KEGG

On utilise l'API de KEGG pour obtenir directement les locus associé à des fonctions spécifiques.

Depuis la base de données BRITE :
Pour obtenir les codes de ces fonctions, on recherche https://rest.kegg.jp/list/brite/sao (avec sao notre souche d'intérêt ici).
Pour obtenir les genes associés aux fonctions de TRANSCRIPTION, on recherche :
https://rest.kegg.jp/link/sao/br:sao03000 avec sao03000 ici le code associé à la fonction "Transcription factors - Staphylococcus aureus subsp. aureus NCTC8325"
https://rest.kegg.jp/link/sao/br:sao03021 avec sao03021 ici le code associé à la fonction "Transcription machinery - Staphylococcus aureus subsp. aureus NCTC8325"

Pour obtenir les genes associés aux fonctions de TRADUCTION, on recherche :
https://rest.kegg.jp/link/sao/br:sao03009 avec sao03009 ici le code associé à la fonction "Ribosome biogenesis - Staphylococcus aureus subsp. aureus NCTC8325"
https://rest.kegg.jp/link/sao/br:sao03011 avec sao03011 ici le code associé à la fonction "Ribosome - Staphylococcus aureus subsp. aureus NCTC8325"
https://rest.kegg.jp/link/sao/br:sao03012 avec sao03012 ici le code associé à la fonction "Translation factors - Staphylococcus aureus subsp. aureus NCTC8325"

Depuis la base de données PATHWAYS :
Pour obtenir les codes de ces fonctions, on recherche https://rest.kegg.jp/list/pathway/sao (avec sao notre souche d'intérêt ici).
Pour obtenir les genes associés aux fonctions d'intérêt, on recherche :
https://rest.kegg.jp/link/sao/path:sao03010 avec sao03000 ici le code associé à la voie "Ribosome - Staphylococcus aureus subsp. aureus NCTC8325"
https://rest.kegg.jp/link/sao/path:sao00970 avec sao03021 ici le code associé à la voie "Aminoacyl-tRNA biosynthesis - Staphylococcus aureus subsp. aureus NCTC8325"

