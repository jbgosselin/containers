#Dockerfile vars
gpodder2go_version=0.2.0

#vars
IMAGENAME=gpodder2go
REPO=ghcr.io/jbgosselin
IMAGEFULLNAME=${REPO}/${IMAGENAME}
IMAGEAUTHORS=https://github.com/jbgosselin
IMAGESOURCE=https://github.com/jbgosselin/containers/tree/main/gpodder2go
IMAGEDOC=https://github.com/jbgosselin/containers/tree/main/gpodder2go/README.md

.PHONY: build push-version push-latest

build:
	docker buildx build --pull \
		--platform=linux/arm64,linux/amd64 \
		--output=type=image \
		--provenance=false \
		--build-arg "GPODDER2GO_VERSION=${gpodder2go_version}" \
		--label "org.opencontainers.image.authors=${IMAGEAUTHORS}" \
		--label "org.opencontainers.image.source=${IMAGESOURCE}" \
		--label "org.opencontainers.image.documentation=${IMAGEDOC}" \
		--tag "${IMAGEFULLNAME}:${gpodder2go_version}" \
		--tag "${IMAGEFULLNAME}:latest" \
		.

push-version:
	docker push "${IMAGEFULLNAME}:${gpodder2go_version}"

push-latest:
	docker push "${IMAGEFULLNAME}:latest"

push-all: push-version push-latest
