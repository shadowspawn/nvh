#!/usr/bin/env bash

waitproxy() {
    while ! nc -z localhost 8080 ; do sleep 1 ; done
}

mitmdump -w versions.dump &> /dev/null &
mitm_process="$!"
waitproxy

export https_proxy=localhost:8080
set -x
curl --insecure --silent https://nodejs.org/dist/ > /dev/null
curl --insecure --silent https://nodejs.org/dist/latest-carbon/ > /dev/null
curl --insecure --silent https://nodejs.org/dist/latest-v7.x/ > /dev/null
set +x

kill "${mitm_process}"
