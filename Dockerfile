FROM debian:13

ENV DEBIAN_FRONTEND=noninteractive

ARG DISTCC_VERSION=3.4
ARG GCC_VERSION=14

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        make \
        ca-certificates \
        gcc \
        python3 \
        python3-dev \
        libiberty-dev \
        autoconf \
        automake \
        gcc-${GCC_VERSION}-aarch64-linux-gnu \
        g++-${GCC_VERSION}-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu \
        python3-setuptools && \
    rm -rf /var/lib/apt/lists/*

# copy pre-built LLVM (build llvm with get-llvm.sh)
COPY tmp/llvm/* /usr/

WORKDIR /tmp
RUN git clone --branch v$DISTCC_VERSION https://github.com/distcc/distcc.git && \
    cd distcc && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/distcc

RUN update-distcc-symlinks  
RUN mkdir -p /usr/local/lib && ln -s /usr/lib/distcc /usr/local/lib/distcc

EXPOSE 3632