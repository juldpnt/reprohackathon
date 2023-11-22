FROM ubuntu:22.04

# We specify the version of SRA toolkit we want to install
# No version was specified in the paper, so we use the latest version
ARG VERSION=3.0.7

RUN apt-get update && apt-get install -y \
        wget \
    # Then we download SRA toolkit and extract it
    && wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VERSION}/sratoolkit.${VERSION}-ubuntu64.tar.gz \
    && tar -vxzf sratoolkit.tar.gz \ 
    # Then we remove the zip file to make the image lighter
    && rm sratoolkit.tar.gz

# We add SRA toolkit to the PATH to use it in the terminal
ENV PATH="$PATH:/sratoolkit.${VERSION}-ubuntu64/bin"
