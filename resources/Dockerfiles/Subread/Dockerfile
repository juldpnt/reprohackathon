# Set the base image to alpine
FROM alpine:3.14

# Set the working environnement when calling the docker image
WORKDIR /home

# Update the repository sources list, then download the source files, compile it from sources
# then move the binaries to the /usr/local/bin/ folder to make them available for our usage
# then remove the source files and the build dependencies to make the image lighter
RUN apk add --no-cache \
        build-base \
        wget \
        zlib-dev \
    && cd /home \
    && wget -q https://downloads.sourceforge.net/project/subread/subread-2.0.6/subread-2.0.6-source.tar.gz \
    && tar -xzf subread-2.0.6-source.tar.gz \
    && cd subread-2.0.6-source/src \
    && make -f Makefile.Linux \
    && cd ../bin \
    && mv utilities/* /usr/local/bin/ \
    && rm -rf /home/* \
    && apk del build-base \
    && apk del zlib-dev \
    && apk del wget


