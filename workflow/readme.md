# Tutoriel workflow

Pour lancer le workflow, il faut au préalable avoir installé Apptainer via l'utilitaire.
Ensuite il faut se place à la racine et exécuter la commande suivante :

```bash
 snakemake --cores \<nbr cores souhaités\> -r -p --use-singularity
```

Pour forcer la reconstruction des fichiers temporaires, il faut ajouter l'option -R.
