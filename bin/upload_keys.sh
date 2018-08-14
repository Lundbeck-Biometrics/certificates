#!/usr/bin/env bash

set -eu

BASEPATH=$(readlink -f $(dirname $0))/..
cd ${BASEPATH}


for c in ${BASEPATH}/keys/*; do
    FILENAME=$(basename "${c}")
    kubectl delete --ignore-not-found=true secret ${FILENAME}
    kubectl create secret generic ${FILENAME} --from-file=${c}
done
