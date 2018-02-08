#!/bin/bash

set -x
set -e


for tag in $(./docker_template.py list-tags)
do
    docker push pklaus/mvd_epics:$tag
done

