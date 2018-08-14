#!/usr/bin/env bash

set -eu
BASEDIR=$(dirname $(readlink -f $0))/..
cd "${BASEDIR}"

mkdir -p certificates/bundle
cfssl bundle -cert=certificates/ca/ca.pem
