FROM debian:13

ENV DEBIAN_FRONTEND=noninteractive

ARG DISTCC_VERSION=3.4
ARG GCC_VERSION=14

# TODO: install the same version of clang as the server
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
        llvm \
        clang \
        cmake \
        python3-setuptools && \
    rm -rf /var/lib/apt/lists/*

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
RUN ln -sf /usr/include/$(dpkg-architecture -qDEB_HOST_MULTIARCH)/asm /usr/include/asm

ENV PATH=$PATH:/usr/lib/distcc:/usr/local/bin

ENV CC="distcc aarch64-linux-gnu-gcc-${GCC_VERSION}"
ENV CXX="distcc aarch64-linux-gnu-g++-${GCC_VERSION}"

ENV CLANG_CC="distcc clang --target=aarch64-linux-gnu"
ENV CLANG_CXX="distcc clang++ --target=aarch64-linux-gnu"

ENV DISTCC_HOSTS="192.168.0.99/24"
ENV DISTCC_SKIP_LOCAL_RETRY=1
ENV DISTCC_BACKOFF_PERIOD=0
ENV DISTCC_IO_TIMEOUT=3000