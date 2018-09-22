# Tests

## Automated Tests

The tests use `mitmproxy` and Bash Automated Testing System (`bats`). The proxy caching is actually optional, but much improves performance and avoids hammering nodejs server.

Setup:

    # using homebrew (Mac) to install mitmproxy
    brew install mitmproxy
    # using npm to install bats globally
    npm install --global bats

First prepare caching proxy server:

    # create proxy~~.dump, run build again when want fresh cache
    ./scripts/proxy-build 
    ./scripts/proxy-run

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
    # open bash shell for manual testing
    docker-compose run ubuntu-curl
    # run command on containers, and native on host
    export NVH_MAX_REMOTE_MATCHES=3
    nvh lsr rc
    ./run-all-containers nvh lsr rc
    # run tests on (some) containers, and native on host
    ./run-all-bats
