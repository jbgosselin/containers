# docker-tor-client

Simple tor client for connecting to tor-network via proxy or host onion services.

`docker pull dennajort/tor-client:latest`

This image exposes these ports:
- `9050/tcp` for SOCKS5 proxy
- `9051/tcp` for control with `not-so-secure` as a password

This image has these volumes:
- `/tor/data` used by tor to save generated keys
- `/tor/torrc.d` can contains custom configuration if necessary, will accept any `*.conf` file

This image is based on `gcr.io/distroless/base-debian11` so it does not contain a shell
nor other softwares in order to reduce risks.
