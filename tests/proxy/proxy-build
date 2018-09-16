#!/usr/bin/env bash

waitproxy() {
    while ! nc -z localhost 8080 ; do sleep 1 ; done
}

mitmdump -w proxy~~.dump &> /dev/null &
mitm_process="$!"
waitproxy

# nvh setuo
readonly NVH_PREFIX="$(mktemp -d)"
export NVH_PREFIX

# Go through proxy so it can record traffic
export https_proxy="localhost:8080"
set -x
# KISS and record nvh to make it easy to get lts and latest
nvh --insecure lsr latest
nvh --insecure lsr nightly/latest
set +x

rm -rf "${NVH_PREFIX}"
kill "${mitm_process}"

