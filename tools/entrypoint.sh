#!/bin/bash

set -o errexit

declare credentials_file="/tmp/.gcp/credentials.json"

if [[ -z ${GCP_TOKEN} ]]; then
    echo "Error: You need declare and export GCP_TOKEN variable"
    exit 1
fi

if [[ -z ${PROJECT} ]]; then
    echo "Error: You need export PROJECT variable"
    exit 1
fi

mkdir -p /tmp/.gcp
echo ${GCP_TOKEN} | jq . > ${credentials_file}

/bin/bash -c "${*}"
