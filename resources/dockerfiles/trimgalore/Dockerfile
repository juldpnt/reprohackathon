# base image: Ubuntu
FROM ubuntu:22.04
# Set the working environnement when calling the docker image
WORKDIR /opt
# Update the repository sources list, then download the source files, compile it from sources

RUN apt-get update \
&& apt-get --yes install \
   python3-pip \
   libfindbin-libs-perl \
   openjdk-8-jre-headless \
   unzip \
   parallel \
   wget \
   tar \
   gzip \
&& pip install cutadapt==4.2

WORKDIR /opt
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.7.zip \
&& unzip fastqc_v0.11.7.zip \
&& rm -rf fastqc_v0.11.7.zip \
&& chmod +x FastQC/fastqc
ENV PATH "${PATH}":/opt/FastQC/

WORKDIR /opt
RUN wget -O - https://github.com/FelixKrueger/TrimGalore/archive/0.6.10.tar.gz | tar xzf -  \
&& ln -s $(find /opt -name "trim_galore") /usr/bin/

