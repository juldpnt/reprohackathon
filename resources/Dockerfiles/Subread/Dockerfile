# Dockerfile to build a container for Subread

# Import the base image
FROM ubuntu:22.04

WORKDIR /home

# add PATH to .bashrc


# Update the package list, and install the required packages to build Subread
RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends \
	build-essential \
	software-properties-common \
    && cd /home \
    && wget -O subread_source.tar.gz https://downloads.sourceforge.net/project/subread/subread-2.0.6/subread-2.0.6-source.tar.gz \
    && tar -xzf subread_source.tar.gz \
    && cd subread_source/src \
    && make -f Makefile.Linux \
    && cd /home \
    && rm subread_source.tar.gz \
    && export PATH=$PATH:/home/subread-2.0.6-Linux-x86_64/bin \
    && source ~/.bashrc
