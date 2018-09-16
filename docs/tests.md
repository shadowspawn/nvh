# Tests

Work in progress.

## Unit Tests

First spin up caching proxy server to speed up tests and avoid hammering server:

    cd test/proxy
    ./proxy-build # first time, and then to update if desired
    ./proxy-run

Create file with values for versions of labels and codenames:

    cd tests
    https_proxy=localhost:8080 ./loopup-versions

Run all tests:

    cd tests
    https_proxy="$(hostname):8080"
    bats bats

## Docker Containers

To try a command across multiple containers with different versions of Linux and some with `wget` as well as `curl`:

    cd tests
    # export any env to be used by docker containers
    ./run-all-containers <command>
