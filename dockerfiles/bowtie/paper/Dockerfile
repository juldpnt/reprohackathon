FROM ubuntu:22.04

# We specify the version of Bowtie we want to install
# Paper version is 0.12.7, latest version used is 1.2.2
ARG VERSION=0.12.7

RUN apt update && \
    apt install -y wget unzip bzip2 tar gcc make libbz2-dev zlib1g zlib1g-dev liblzma5 liblzma-dev libncurses5 libncurses5-dev && \
    # Then we download Bowtie
    wget https://sourceforge.net/projects/bowtie-bio/files/bowtie/${VERSION}/bowtie-${VERSION}-linux-x86_64.zip && \
    unzip bowtie-${VERSION}-linux-x86_64.zip && \
    # Then we remove the zip file to make the image lighter
    rm -f bowtie-${VERSION}-linux-x86_64.zip

# We add Bowtie to the PATH
ENV PATH="$PATH:/bowtie-${VERSION}"

RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    bzip2 -d samtools-1.9.tar.bz2 && \
    tar -xf samtools-1.9.tar && \
    rm -rf samtools-1.9.tar && \
    cd samtools-1.9 && \
    ./configure && \
    make && \
    make install && \
    cd /usr/local && \
    rm -rf /usr/local/samtools-1.9

# We add samtools to the PATH
# ENV PATH="$PATH:/bowtie-${VERSION}"