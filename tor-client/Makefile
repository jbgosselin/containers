#Dockerfile vars
tor_version=0.4.8.10
tor_major=0.4
tor_minor=0.4.8
zlib_version=1.3.1
libevent_version=2.1.12-stable

#vars
IMAGENAME=tor-client
REPO=ghcr.io/jbgosselin
IMAGEFULLNAME=${REPO}/${IMAGENAME}
IMAGEAUTHORS=https://github.com/jbgosselin
IMAGESOURCE=https://github.com/jbgosselin/containers/tree/main/tor-client
IMAGEDOC=https://github.com/jbgosselin/containers/tree/main/tor-client/README.md

.PHONY: build-amd64 build-arm64v8 push-amd64 push-arm64v8 push-version push-major push-minor push-latest

build-amd64:
	docker build --pull \
		--platform linux/amd64 \
		--build-arg "TOR_VERSION=${tor_version}" \
		--build-arg "ZLIB_VERSION=${zlib_version}" \
		--build-arg "LIBEVENT_VERSION=${libevent_version}" \
		--label "org.opencontainers.image.authors=${IMAGEAUTHORS}" \
		--label "org.opencontainers.image.source=${IMAGESOURCE}" \
		--label "org.opencontainers.image.documentation=${IMAGEDOC}" \
		-t "${IMAGEFULLNAME}:${tor_version}-amd64" .

build-arm64v8:
	docker build --pull \
		--platform linux/arm64/v8 \
		--build-arg "TOR_VERSION=${tor_version}" \
		--build-arg "ZLIB_VERSION=${zlib_version}" \
		--build-arg "LIBEVENT_VERSION=${libevent_version}" \
		--label "org.opencontainers.image.authors=${IMAGEAUTHORS}" \
		--label "org.opencontainers.image.source=${IMAGESOURCE}" \
		--label "org.opencontainers.image.documentation=${IMAGEDOC}" \
		-t "${IMAGEFULLNAME}:${tor_version}-arm64v8" .

build-all: build-amd64 build-arm64v8

push-amd64:
	docker push "${IMAGEFULLNAME}:${tor_version}-amd64"

push-arm64v8:
	docker push "${IMAGEFULLNAME}:${tor_version}-arm64v8"

push-version:
	docker manifest create \
		"${IMAGEFULLNAME}:${tor_version}" \
		"${IMAGEFULLNAME}:${tor_version}-amd64" \
		"${IMAGEFULLNAME}:${tor_version}-arm64v8"
	docker manifest push --purge "${IMAGEFULLNAME}:${tor_version}"

push-minor:
	docker manifest create \
		"${IMAGEFULLNAME}:${tor_minor}" \
		"${IMAGEFULLNAME}:${tor_version}-amd64" \
		"${IMAGEFULLNAME}:${tor_version}-arm64v8"
	docker manifest push --purge "${IMAGEFULLNAME}:${tor_minor}"

push-major:
	docker manifest create \
		"${IMAGEFULLNAME}:${tor_major}" \
		"${IMAGEFULLNAME}:${tor_version}-amd64" \
		"${IMAGEFULLNAME}:${tor_version}-arm64v8"	
	docker manifest push --purge "${IMAGEFULLNAME}:${tor_major}"

push-latest:
	docker manifest create \
		"${IMAGEFULLNAME}:latest" \
		"${IMAGEFULLNAME}:${tor_version}-amd64" \
		"${IMAGEFULLNAME}:${tor_version}-arm64v8"	
	docker manifest push --purge "${IMAGEFULLNAME}:latest"

push-all: push-amd64 push-arm64v8 push-version push-minor push-major push-latest
