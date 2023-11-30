# Set the base image to ubuntu
FROM ubuntu:22.04

ARG VERSION=1.4.6-p3

RUN apt-get update &&\
    apt-get install -y wget &&\
    wget https://downloads.sourceforge.net/project/subread/subread-${VERSION}/subread-${VERSION}-Linux-x86_64.tar.gz &&\
    tar xzf subread-${VERSION}-Linux-x86_64.tar.gz &&\
    rm -rf subread-${VERSION}-Linux-x86_64.tar.gz

ENV PATH="$PATH:/subread-${VERSION}-Linux-x86_64/bin"
