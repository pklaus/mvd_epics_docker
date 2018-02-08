#!/bin/bash

set -x
set -e

export PYTHONDONTWRITEBYTECODE=1

repo=pklaus/mvd_epics

for tag in $(./docker_template.py list-tags)
do
  ./docker_template.py build --squash --tag $repo:$tag
done
