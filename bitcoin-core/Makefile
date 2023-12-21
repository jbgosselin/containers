#Dockerfile vars
bitcoin_version=26.0

#vars
IMAGENAME=bitcoin-core
REPO=ghcr.io/jbgosselin
IMAGEFULLNAME=${REPO}/${IMAGENAME}

.PHONY: build-amd64 build-arm64v8 push-amd64 push-arm64v8 push-version push-latest

build-amd64:
	docker build --pull \
		--platform=linux/amd64 \
		--build-arg BITCOIN_VERSION=${bitcoin_version} \
		--build-arg BITCOIN_BUILD_HOST=x86_64-pc-linux-gnu \
		--tag ${IMAGEFULLNAME}:${bitcoin_version}-amd64 .

build-arm64v8:
	docker build --pull \
		--platform=linux/arm64/v8 \
		--build-arg BITCOIN_VERSION=${bitcoin_version} \
		--build-arg BITCOIN_BUILD_HOST=aarch64-linux-gnu \
		--tag ${IMAGEFULLNAME}:${bitcoin_version}-arm64v8 .

push-amd64:
	docker push ${IMAGEFULLNAME}:${bitcoin_version}-amd64

push-arm64v8:
	docker push ${IMAGEFULLNAME}:${bitcoin_version}-arm64v8

push-version:
	docker manifest create \
		${IMAGEFULLNAME}:${bitcoin_version} \
		${IMAGEFULLNAME}:${bitcoin_version}-amd64 \
		${IMAGEFULLNAME}:${bitcoin_version}-arm64v8
	docker manifest push --purge ${IMAGEFULLNAME}:${bitcoin_version}

push-latest:
	docker manifest create \
		${IMAGEFULLNAME}:latest \
		${IMAGEFULLNAME}:${bitcoin_version}-amd64 \
		${IMAGEFULLNAME}:${bitcoin_version}-arm64v8	
	docker manifest push --purge ${IMAGEFULLNAME}:latest
