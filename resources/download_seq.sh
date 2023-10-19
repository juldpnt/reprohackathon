echo " "
echo "Le script va télécharger les différents fichiers de séquences"
echo "Copier coller l'accession de la séquence à télécharger via le doc récapitulatif"
echo "Par exemple, l'accession SRR10379721"
echo "Ou bien aller sur le site https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA586837&o=acc_s%3Aa"
echo " "
echo "Accession : "
read accession
echo " "
echo "Nombre de lignes à préextraire ?"
read nb_lignes
echo " "
echo "Patientez pendant le téléchargement ..."
wget -O $accession.fastq.gz https://www.be-md.ncbi.nlm.nih.gov/Traces/sra-reads-be/fastq?acc=$accession
zcat $accession.fastq.gz | head -n nb_lignes > ${accession}_partiel.fastq