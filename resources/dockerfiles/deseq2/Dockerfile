# Set the base image to alpine
FROM alpine:3.18.4

# Set the working environnement when calling the docker image
WORKDIR /home

# Install required packages to use DESeq2
RUN apk add --no-cache \
    build-base \
    R=4.3.0-r0 \
    && Rscript -e  'install.packages("BiocManager", repos = c(CRAN = "https://cran.rstudio.com/"))' \
    && Rscript -e 'BiocManager::install(c("DESeq2"))'