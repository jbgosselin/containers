# docker-tor-client

Simple tor client for connecting to tor-network via proxy or host onion services.

`docker pull dennajort/tor-client:latest`

This image exposes these ports:
- `9050/tcp` for SOCKS5 proxy
- `9051/tcp` for control

This image has these volumes:
- `/var/lib/tor` known as DataDirectory used by tor to save generated keys
- `/etc/tor/torrc.d` can contains custom configuration if necessary, will accept any `*.conf` file

This image is based on `gcr.io/distroless/base-debian11` so it does not contain a shell
nor other softwares except the ones built for tor in order to reduce risks.
