# entrypoint
FROM docker.io/golang:1.22-bookworm AS build-entrypoint

WORKDIR /build
COPY entrypoint.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /build/entrypoint entrypoint.go

# gpodder2go
FROM docker.io/golang:1.22-bookworm as build

WORKDIR /build
ARG GPODDER2GO_VERSION
ADD https://github.com/oxtyped/gpodder2go/archive/refs/tags/v${GPODDER2GO_VERSION}.tar.gz .
RUN tar xzf v${GPODDER2GO_VERSION}.tar.gz
WORKDIR /build/gpodder2go-${GPODDER2GO_VERSION}
RUN CGO_ENABLED=0 GOOS=linux go build -o /build/gpodder2go main.go

# Build output image
FROM gcr.io/distroless/base-debian12

WORKDIR /data
COPY --from=build-entrypoint /build/entrypoint /entrypoint
COPY --from=build /build/gpodder2go /gpodder2go

VOLUME /data
EXPOSE 3005

ENTRYPOINT ["/entrypoint"]
