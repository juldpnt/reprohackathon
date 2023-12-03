# Use the Ubuntu 22.04 base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Add the CRAN repository to get specific R versions
RUN apt-get update && apt-get install -y \
    software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Update the package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    r-base=4.3.* \
    r-base-dev=4.3.* \
    libssl-dev \
    libcurl4-openssl-dev

# Install BiocManager package manager for Bioconductor
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'

# Install DESeq2 package from Bioconductor
RUN R -e 'BiocManager::install("DESeq2")'

# Install apeglm package from Bioconductor
RUN R -e 'BiocManager::install("apeglm")'

# Install ashr
RUN R -e 'install.packages("ashr", repos="https://cloud.r-project.org/")'

# Install ggrepel
RUN R -e 'install.packages("ggrepel", repos="https://cloud.r-project.org/")'

# Install EnhancedVolcano
RUN R -e 'BiocManager::install("EnhancedVolcano")'

# Install ggplot2
RUN R -e 'install.packages("ggplot2", repos="https://cloud.r-project.org/")'
