FROM ubuntu:22.04

RUN RUN apt-get update && apt-get install -y \
        wget \
    && cd /home \
    && wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.7/sratoolkit.3.0.7-ubuntu64.tar.gz \
    && tar -vxzf sratoolkit.tar.gz \ 
    && rm sratoolkit.tar.gz

ENV PATH="$PATH:home/sratoolkit.3.0.7-ubuntu64/bin"
