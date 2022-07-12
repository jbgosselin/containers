FROM debian:11 as build
ARG TOR_VERSION
ARG ZLIB_VERSION
ARG LIBEVENT_VERSION

RUN apt-get update && apt-get install -y gcc make libssl-dev

WORKDIR /build

# ZLIB
ADD https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz .
RUN tar xzf zlib-${ZLIB_VERSION}.tar.gz && cd zlib-${ZLIB_VERSION} && \
    ./configure --prefix=/build/deps --static && make && make install

# LIBEVENT
ADD https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz .
RUN tar xzf libevent-${LIBEVENT_VERSION}.tar.gz && cd libevent-${LIBEVENT_VERSION} && \
    ./configure --prefix=/build/deps \
    --enable-static --disable-shared \
    --disable-samples --disable-libevent-regress \
    && make && make install

# TOR
ADD https://dist.torproject.org/tor-${TOR_VERSION}.tar.gz .
RUN tar xzf tor-${TOR_VERSION}.tar.gz && cd tor-${TOR_VERSION} && \
    ./configure \
    --prefix=/tor \
    --enable-static-libevent --with-libevent-dir=/build/deps \
    --enable-static-zlib --with-zlib-dir=/build/deps \
    --disable-asciidoc --disable-manpage --disable-html-manual --disable-unittests \
    --disable-seccomp --disable-libscrypt --disable-lzma --disable-zstd --disable-systemd \
    --disable-module-relay --disable-module-dirauth \
    && make && make install

RUN mkdir /tor/data && mkdir /tor/torrc.d

# Build output image
FROM gcr.io/distroless/base-debian11

COPY --from=build /tor /tor
COPY torrc /tor/etc/tor/torrc

VOLUME /tor/data /tor/torrc.d
EXPOSE 9050/tcp 9051/tcp

CMD ["/tor/bin/tor"]