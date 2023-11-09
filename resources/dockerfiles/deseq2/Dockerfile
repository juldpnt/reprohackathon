# Set the base image to alpine
FROM mambaorg/micromamba:1.5-alpine

# Install required packages to use DESeq2
RUN micromamba install -y -n base -c bioconda -c conda-forge r-base r-essentials bioconductor-deseq2