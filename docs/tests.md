# Tests

## Automated Tests

The tests use `mitmproxy` and Bash Automated Testing System (`bats`). The proxy caching is actually optional, but much improves performance and avoids hammering nodejs server.

Setup:

    # can install on Mac using homebrew
    brew install mitmproxy
    npm install --global bats

First prepare caching proxy server:

    cd tests/proxy
    ./proxy-build # first time, then optional
    ./proxy-run

Prepare file with expected version values for labels and codenames:

    cd tests
    https_proxy=localhost:8080 ./loopup-versions

Run tests using caching proxy looking for expected versions from above:

    cd tests
    export https_proxy="$(hostname):8080"
    # e.g. run one test natively
    bats bats/lsr.bats
    # run all the tests in containers and natively
    ./run-all-bats

## BATS Development Tips

There is an [issue](https://github.com/bats-core/bats-core/pull/24) affecting bats with bash 3 as used on Mac, that failing tests using `[[ ]]` are not detected. A work-around if the newer tests form is desired:

    [[ "a" = "b ]] || return 2

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
