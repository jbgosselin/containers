#Dockerfile vars
bitcoin_version=28.0

#vars
IMAGENAME=bitcoin-core
REPO=ghcr.io/jbgosselin
IMAGEFULLNAME=${REPO}/${IMAGENAME}
IMAGEAUTHORS=https://github.com/jbgosselin
IMAGESOURCE=https://github.com/jbgosselin/containers/tree/main/bitcoin-core
IMAGEDOC=https://github.com/jbgosselin/containers/tree/main/bitcoin-core/README.md

.PHONY: build push-version push-latest

build:
	docker buildx build --pull \
		--platform=linux/arm64,linux/amd64 \
		--output=type=image \
		--provenance=false \
		--build-arg "BITCOIN_VERSION=${bitcoin_version}" \
		--label "org.opencontainers.image.authors=${IMAGEAUTHORS}" \
		--label "org.opencontainers.image.source=${IMAGESOURCE}" \
		--label "org.opencontainers.image.documentation=${IMAGEDOC}" \
		--tag "${IMAGEFULLNAME}:${bitcoin_version}" \
		--tag "${IMAGEFULLNAME}:latest" \
		.

push-version:
	docker push "${IMAGEFULLNAME}:${bitcoin_version}"

push-latest:
	docker push "${IMAGEFULLNAME}:latest"

push-all: push-version push-latest
