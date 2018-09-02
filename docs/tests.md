# Tests

Work in progress.

## Versions

Running `lookup-versions.sh` creates `versions_export.tmp` with content like:

    export LATEST_VERSION="v10.9.0"
    export LTS_VERSION="v8.11.4"
    export BORON_VERSION="v6.14.4"

to use via `source versions_export.tmp`

## Proxy

To speed up tests, can optionally run local caching proxy. Support scripts in `test/proxy`.

Running `record-versions.sh` does the curl commands covering the requests made by the version tests, creating `versions.dump`.

Spin up proxy server, and use it while running tests:

    mitmdump --server-replay-nopop --server-replay versions.dump

    # In another window
    export https_proxy=localhost:8080
    source versions_export.tmp
    bats bats
