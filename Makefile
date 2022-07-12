#Dockerfile vars
tor_version=0.4.7.8
zlib_version=1.2.12
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

push_latest:
		docker push ${IMAGEFULLNAME}:latest
