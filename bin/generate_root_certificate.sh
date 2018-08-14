#!/usr/bin/env bash

set -eu
BASEDIR=$(dirname $(readlink -f $0))/..
cd "${BASEDIR}"

if [[ -n "${1:-}" ]]; then
    CONF_FILE=$1
else
    CONF_FILE=${BASEDIR}/config/ca.json
fi

if [[ -n "${2:-}" ]];then
    OUTPUT_DIR=$2
else
    OUTPUT_DIR=${BASEDIR}/certificates/ca/ca
fi

if [ ! -d "${OUTPUT_DIR}" ]; then
    mkdir -p $(dirname "${OUTPUT_DIR}")
fi

cfssl gencert -initca "${CONF_FILE}"  | cfssljson -bare "${OUTPUT_DIR}"
