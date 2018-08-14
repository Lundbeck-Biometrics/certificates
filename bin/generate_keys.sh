#!/usr/bin/env bash

BASEPATH=$(readlink -f $(dirname $0))/..
cd ${BASEPATH}

for c in ${BASEPATH}/config/keys/*; do
    FILENAME=$(basename "${c}")
    OUTPATH=${BASEPATH}/keys/${FILENAME%%.json}/id_rsa
    if [ -f "${OUTPATH}" ]; then
	continue
    fi
    OUTDIR=$(dirname "${OUTPATH}")
    mkdir -p "${OUTDIR}"
    ssh-keygen -q -P '' -t rsa -f "${OUTPATH}"
done
