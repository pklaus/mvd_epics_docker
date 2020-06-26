#!/bin/bash

set -x
set -e

docker build --squash --tag pklaus/mvd_epics:debian-jessie .
