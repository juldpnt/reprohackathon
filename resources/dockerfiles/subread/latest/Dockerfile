# Set the base image to alpine
FROM alpine:3.14

# Set the version of subread we want to install
# Paper version is 1.4.6-p3, latest version is 2.0.6
ARG VERSION=2.0.6

RUN apk add --no-cache \
        build-base \
        wget \
        zlib-dev \
        bash \
    && cd /home/ \
    # Then we download subread, extract it and compile it from sources
    && wget -q https://downloads.sourceforge.net/project/subread/subread-${VERSION}/subread-${VERSION}-source.tar.gz \
    && tar -xzf subread-${VERSION}-source.tar.gz \
    && cd subread-${VERSION}-source/src \
    && make -f Makefile.Linux \
    #
    # Then move the binaries to the /usr/local/bin/ folder to make them available for our usage
    # Actually we could have used ENV PATH but it's also to learn this alternative
    && cd ../ \
    && mv bin/* /usr/local/bin/ \
    #
    # Then remove the source files and the build dependencies to make the image lighter
    && rm -rf /home/* \
    && apk del build-base \
    && apk del zlib-dev \
    && apk del wget