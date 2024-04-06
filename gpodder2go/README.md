# gpodder2go

gpodder2go statically compiled in a docker container.

`docker pull ghcr.io/jbgosselin/gpodder2go:latest`

This image is built from sources at https://github.com/oxtyped/gpodder2go

This image has this volume:

- `/data` contains the sqlite database and `VERIFIER_SECRET_KEY` if not set in environment

This images listens on port tcp/3005

This image is based on `gcr.io/distroless/base-debian12` so it does not contain a shell nor other softwares except gpodder2go and an entrypoint binary in order to reduce attack factor.

It is built with statically compiled libraries.
