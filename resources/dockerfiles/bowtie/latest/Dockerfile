FROM ubuntu:22.04

# We specify the version of Bowtie we want to install
# Paper version is 0.12.7, latest version used is 1.2.2
ARG VERSION=1.2.2

RUN apt update && \
    apt install -y wget unzip && \
    # Then we download Bowtie
    wget https://sourceforge.net/projects/bowtie-bio/files/bowtie/${VERSION}/bowtie-${VERSION}-linux-x86_64.zip && \
    unzip bowtie-${VERSION}-linux-x86_64.zip && \
    # Then we remove the zip file to make the image lighter
    rm -f bowtie-${VERSION}-linux-x86_64.zip

# We add Bowtie to the PATH
ENV PATH="$PATH:/bowtie-${VERSION}-linux-x86_64/"