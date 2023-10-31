#Dockerfile vars
tor_version=0.4.8.7
tor_major=0.4
tor_minor=0.4.8
zlib_version=1.3
libevent_version=2.1.12-stable

#vars
IMAGENAME=tor-client
REPO=ghcr.io/jbgosselin
IMAGEFULLNAME=${REPO}/${IMAGENAME}

.PHONY: build-amd64 build-arm64v8 push-amd64 push-arm64v8 push-version push-major push-minor push-latest

build-amd64:
	docker build --pull \
		--file Containerfile \
		--platform linux/amd64 \
		--build-arg TOR_VERSION=${tor_version} \
		--build-arg ZLIB_VERSION=${zlib_version} \
		--build-arg LIBEVENT_VERSION=${libevent_version} \
		-t ${IMAGEFULLNAME}:${tor_version}-amd64 .

build-arm64v8:
	docker build --pull \
		--file Containerfile \
		--platform linux/arm64/v8 \
		--build-arg TOR_VERSION=${tor_version} \
		--build-arg ZLIB_VERSION=${zlib_version} \
		--build-arg LIBEVENT_VERSION=${libevent_version} \
		-t ${IMAGEFULLNAME}:${tor_version}-arm64v8 .

push-amd64:
	docker push ${IMAGEFULLNAME}:${tor_version}-amd64

push-arm64v8:
	docker push ${IMAGEFULLNAME}:${tor_version}-arm64v8

push-version:
	docker manifest create \
		${IMAGEFULLNAME}:${tor_version} \
		${IMAGEFULLNAME}:${tor_version}-amd64 \
		${IMAGEFULLNAME}:${tor_version}-arm64v8
	docker manifest push --purge ${IMAGEFULLNAME}:${tor_version}

push-minor:
	docker manifest create \
		${IMAGEFULLNAME}:${tor_minor} \
		${IMAGEFULLNAME}:${tor_version}-amd64 \
		${IMAGEFULLNAME}:${tor_version}-arm64v8
	docker manifest push --purge ${IMAGEFULLNAME}:${tor_minor}

push-major:
	docker manifest create \
		${IMAGEFULLNAME}:${tor_major} \
		${IMAGEFULLNAME}:${tor_version}-amd64 \
		${IMAGEFULLNAME}:${tor_version}-arm64v8	
	docker manifest push --purge ${IMAGEFULLNAME}:${tor_major}

push-latest:
	docker manifest create \
		${IMAGEFULLNAME}:latest \
		${IMAGEFULLNAME}:${tor_version}-amd64 \
		${IMAGEFULLNAME}:${tor_version}-arm64v8	
	docker manifest push --purge ${IMAGEFULLNAME}:latest
