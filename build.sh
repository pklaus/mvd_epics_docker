#!/bin/bash

set -ex

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=auto # auto plain ...
export DOCKER_CLI_EXPERIMENTAL=enabled

PLATFORMS=linux/amd64,linux/386,linux/arm/v7,linux/arm64/v8

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# if you want to start with a clean builder, run:
#docker buildx rm epics_builder || true

docker buildx inspect epics_builder || \
  docker buildx create --name epics_builder
docker buildx use epics_builder
docker buildx inspect --bootstrap epics_builder

docker buildx build --pull --push --platform $PLATFORMS --tag pklaus/mvd_epics:1-0-1 .
