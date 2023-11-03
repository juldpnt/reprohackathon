
instructions utilisation bowtie pour mapping

conda create -n "bowtie_test" python=3.7.1
	- crée l'environnement avec la bonne version de Python (sinon erreur)

conda activate bowtie_test
conda env list
	- vérifie que l'environnement est bien crée, actif, et qu'on est dedans

conda install -c bioconda bowtie

bowtie-build reference.fasta nom_de_l_index
	- création de l'index à partir du génome de référence
	- renvoie 6 fichiers au format .ebwt
	- /!\ le nb de fichiers qui constituent l'index est tjrs 6 ; aucun lien a priori avec nos 6 accessions
	- Output files: "nom_de_l_index.*.ebwt"
	- /!\ quand on veut ensuite appeler l'index, on n'appelle jamais un des 6 fichiers à part, on 
	appelle uniquement l'index tel qu'on l'a nommé {nom_de_l_index}

bowtie --no-unal --threads 1 --sam nom_de_l_index SRR10379721_4kl.fastq output.sam
	- mapping : alignement des séquences sur le génome de référence
	- --no-unal indique que les séquences qui ne s'alignent pas ne sont pas mises dans l'output
	- --threads doit être spécifié à 1 sinon erreur
