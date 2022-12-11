#Dockerfile vars
tor_version=0.4.7.9
tor_major=0.4
tor_minor=0.4.7
zlib_version=1.2.13
libevent_version=2.1.12-stable

#vars
IMAGENAME=tor-client
REPO=dennajort
IMAGEFULLNAME=${REPO}/${IMAGENAME}

.PHONY: build push all

.DEFAULT_GOAL := build

build:
	docker build --pull --build-arg TOR_VERSION=${tor_version} --build-arg ZLIB_VERSION=${zlib_version} --build-arg LIBEVENT_VERSION=${libevent_version} -t ${IMAGEFULLNAME}:${tor_version} .
	docker tag ${IMAGEFULLNAME}:${tor_version} ${IMAGEFULLNAME}:latest

push:
	docker push ${IMAGEFULLNAME}:${tor_version}

push-latest:
	docker push ${IMAGEFULLNAME}:latest

push-minor:
	docker tag ${IMAGEFULLNAME}:${tor_version} ${IMAGEFULLNAME}:${tor_minor}
	docker push ${IMAGEFULLNAME}:${tor_minor}

push-major:
	docker tag ${IMAGEFULLNAME}:${tor_version} ${IMAGEFULLNAME}:${tor_major}
	docker push ${IMAGEFULLNAME}:${tor_major}

push-all: push push-minor push-major
