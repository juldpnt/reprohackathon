# Projet Reprohackaton (Groupe 8)

## Table des matières

- [Projet Reprohackaton (Groupe 8)](#projet-reprohackaton-groupe-8)
  - [Table des matières](#table-des-matières)
  - [Membres du groupe](#membres-du-groupe)
  - [Outils](#outils)
  - [Architecture du projet](#architecture-du-projet)
  - [Architecture du workflow](#architecture-du-workflow)

## Membres du groupe

- Ambroise BERTIN
- Jules DUPONT
- Julien GIOVANAZZI
- Matthieu VERLYNDE

## Outils

- Docker (version X.X.X)
- Snakemake (version X.X.X)
- SRA Toolkit (version 3.0.7)
- Bowtie (version X.X.X)
- TrimGalore (version X.X.X)
- Subread (version X.X.X)
- DESeq2 (version X.X.X) + R (version X.X.X)

## Architecture du projet

```
Reprohackaton
├── README.md
├── config
├── resources
│   ├── dockerfiles
│   │   ├── readme.md
│   │   ├── bowtie
│   │   ├── deseq2
│   │   ├── subread
│   │   └── trimgalore
├── results
│   └── readme.md
└── workflow
    ├── Snakefile
    └── scripts
```
Note pour plus tard: réalisé avec `tree > fichier.md`
Expliquer la structure sous le format
https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html 

## Architecture du workflow

Ce workflow est composé de X étapes:
![Workflow](rulegraph.png)