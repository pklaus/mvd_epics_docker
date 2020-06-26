#!/bin/bash

set -ex

export DOCKER_BUILDKIT=1
docker build --pull --progress=plain --tag pklaus/mvd_epics:debian-jessie .
