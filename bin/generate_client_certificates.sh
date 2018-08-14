#!/usr/bin/env bash

BASEPATH=$(readlink -f $(dirname $0))/..
cd ${BASEPATH}

rm -rf "${BASEPATH}/certificates/client"

for c in ${BASEPATH}/config/client/*.json; do
    FILENAME=$(basename "${c}")
    OUTPATH=${BASEPATH}/certificates/client/${FILENAME%%.json}/${FILENAME%%.json}
    OUTDIR=$(dirname "${OUTPATH}")
    mkdir -p "${OUTDIR}"
    cfssl gencert \
	  -ca=certificates/ca/ca.pem \
	  -ca-key=certificates/ca/ca-key.pem \
	  -config=config/ca-config.json \
	  -profile=client \
	  "${c}" | cfssljson -bare "${OUTPATH}"
done
