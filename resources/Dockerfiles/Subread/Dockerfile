# Set the base image to Ubuntu
FROM ubuntu:22.04

# Set the working environnement when calling the docker image
WORKDIR /home

# Update the repository sources list
RUN apt-get update \
    && apt-get install --yes \
        build-essential \
        wget \
        zlib1g-dev \
    && cd /home \
    && wget -q https://downloads.sourceforge.net/project/subread/subread-2.0.6/subread-2.0.6-source.tar.gz \
    && tar -xzf subread-2.0.6-source.tar.gz \
    && cd subread-2.0.6-source/src \
    && make -f Makefile.Linux \
    && cd ../bin \
    && mv utilities/* /usr/local/bin/