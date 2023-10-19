# Set the base image to alpine
FROM alpine:3.14

# Set the working environnement when calling the docker image
WORKDIR /home

# Install required packages to use DESeq2
RUN apk add --no-cache \
    build-base \
    R=4.3.0-r0 \
    R-dev=4.3.0-r0 \
    R-doc=4.3.0-r0 \
    && Rscript -e "install.packages('BiocManager')" \
    && Rscript -e "BiocManager::install('DESeq2')"