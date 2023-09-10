# docker-tor-client

Simple tor client for connecting to tor-network via proxy or host onion services.

`docker pull ghcr.io/jbgosselin/tor-client:latest`

This image exposes these ports:
- `9050/tcp` for SOCKS5 proxy
- `9051/tcp` for control

This image has these volumes:
- `/var/lib/tor` tor will create it's own `data` subdirectory with proper permission configured as DataDirectory
- `/etc/tor/torrc.d` can contains custom configuration if necessary, will accept any `*.conf` file

By default, this image will not listen on the control port.

This image is based on `gcr.io/distroless/base-debian12` so it does not contain a shell
nor other softwares except the ones built for tor in order to reduce attack factor.
It is built with statically compiled zlib and libevent.
