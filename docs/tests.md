# Tests

## Unit Tests

First spin up caching proxy server to speed up tests and avoid hammering server:

    cd test/proxy
    ./proxy-build # first time, then optional
    ./proxy-run

Create file with values for cached versions of labels and codenames:

    cd tests
    https_proxy=localhost:8080 ./loopup-versions

Run all tests using caching proxy:

    cd tests
    export https_proxy=localhost:8080
    # just native
    bats bats
    # containers and native
    ./run-all-bats

## Manual Tests

`nvh` and `tests/` are mounted in all containers. Exported environment variables are passed through: `https_proxy` `NVH_NODE_MIRROR` `NVH_NODE_DOWNLOAD_MIRROR` `NVH_MAX_REMOTE_MATCHES`. This makes it straight forward to try something locally and try same thing across other environments.

    cd tests
    # bash for manual testing
    docker-compose run ubuntu-curl
    # run command on plain containers and native
    export NVH_MAX_REMOTE_MATCHES=3
    nvh lsr rc
    ./run-all-containers nvh lsr rc
    # run tests on bats containers and native (as above)
    ./run-all-bats
