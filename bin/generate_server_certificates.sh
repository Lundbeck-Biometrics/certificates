#!/usr/bin/env bash

BASEPATH=$(readlink -f $(dirname $0))/..
cd ${BASEPATH}

rm -rf "${BASEPATH}/certificates/server"

for c in ${BASEPATH}/config/server/*.json; do
    FILENAME=$(basename "${c}")
    OUTPATH=${BASEPATH}/certificates/server/${FILENAME%%.json}/${FILENAME%%.json}
    OUTDIR=$(dirname "${OUTPATH}")
    mkdir -p "${OUTDIR}"
    cfssl gencert \
	  -ca=certificates/ca/ca.pem \
	  -ca-key=certificates/ca/ca-key.pem \
	  -config=config/ca-config.json \
	  -profile=server \
	  "${c}" | cfssljson -bare "${OUTPATH}"
done
