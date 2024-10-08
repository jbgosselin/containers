FROM docker.io/debian:12 as build

WORKDIR /build

# TINI
ARG TARGETARCH
ARG TINI_VERSION=0.19.0
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static-${TARGETARCH} /build/out/tini
RUN chmod +x /build/out/tini

RUN apt-get update && apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 curl bison flex cmake

# BITCOIN-CORE
ARG BITCOIN_VERSION
ADD https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}.tar.gz .
RUN tar xzf bitcoin-${BITCOIN_VERSION}.tar.gz

WORKDIR bitcoin-${BITCOIN_VERSION}

RUN make -C depends NO_QT=1 NO_QR=1

RUN ./autogen.sh && \
    CONFIG_SITE=$PWD/depends/$(./depends/config.guess)/share/config.site LDFLAGS="-static-libgcc -static-libstdc++" ./configure \
    --prefix= --disable-man --with-gui=no --with-libs=no --disable-bench --disable-tests  \
    && make && make DESTDIR=/build/out install

RUN mkdir -p /build/out/var/lib/bitcoin

# Build output image
FROM gcr.io/distroless/base-debian12

COPY --from=build /build/out /

ENV BITCOIN_DATA=/var/lib/bitcoin
VOLUME /var/lib/bitcoin
EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/tini", "--", "/bin/bitcoind"]
