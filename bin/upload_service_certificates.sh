#!/usr/bin/env bash

set -eu

BASEPATH=$(readlink -f $(dirname $0))/..
cd ${BASEPATH}


for c in ${BASEPATH}/certificates/server/*; do
    FILENAME=$(basename "${c}")
    kubectl delete --ignore-not-found=true secret ${FILENAME}
    kubectl create secret tls "${FILENAME}" \
    	    --key "${c}"/${FILENAME}-key.pem \
    	    --cert "${c}"/${FILENAME}.pem
done
