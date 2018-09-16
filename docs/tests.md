# Tests

Work in progress.

## Unit Tests

First spin up caching proxy server to speed up tests and avoid hammering server:

    cd test/proxy
    ./proxy-build # first time, then optional
    ./proxy-run

Create file with values for cached versions of labels and codenames:

    cd tests
    https_proxy=localhost:8080 ./loopup-versions

Run all tests using caching proxy:

    cd tests/bats
    export https_proxy=localhost:8080
    bats .

## Docker Containers

Run a command across multiple containers with different versions of Linux including some with `wget` rather than `curl`.
Environment variables used by nvh are passed through, such as NVH_NODE_MIRROR and https_proxy.

    cd tests
    # export any env to be used by docker containers
    ./run-all-containers <command>
