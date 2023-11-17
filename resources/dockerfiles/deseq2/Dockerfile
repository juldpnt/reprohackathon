
# Use the Ubuntu 22.04 base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Update the package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    r-base \
    r-base-dev \
    libssl-dev \
    libcurl4-openssl-dev

# Install BiocManager package manager for Bioconductor
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'

# Install DESeq2 package from Bioconductor
RUN R -e 'BiocManager::install("DESeq2")'
