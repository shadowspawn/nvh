# Tests

## Automated Tests

The tests use `mitmproxy` and Bash Automated Testing System (`bats`). The proxy caching is actually optional, but much improves performance and avoids hammering nodejs server.

Setup:

    # using homebrew (Mac) to install mitmproxy
    brew install mitmproxy
    # install bats locally
    npm install

First prepare caching proxy server. This is optional, but speeds tests and especially rerunning tests.

    # create proxy~~.dump, run build again when want fresh cache
    cd test
    ./bin/proxy-build
    ./bin/proxy-run
    # follow the instructions for configuring environment variables for using proxy, then run tests

Run all the tests across a range of containers and on the host system:

    npm run test

Run all the tests on a single system:

    cd test
    npx bats tests
    docker-compose run ubuntu-curl bats /mnt/test/tests

Run single test on a single system:

    cd test
    npx bats tests/lsr.bats
    docker-compose run ubuntu-curl bats /mnt/test/tests/lsr.bats

Run a single command on more containers:

    cd test
    bin/for-each-container uname -s

## BATS Development Tips

There is an [issue](https://github.com/bats-core/bats-core/pull/24) affecting bats with bash 3 as used on Mac, that failing tests using `[[ ]]` are not detected. A work-around if the newer tests form is desired:

    [[ "a" = "b ]] || return 2

## Docker Tips

Using `docker-compose` in addition to `docker` for convenient mounting of `nvh` script and the tests into the container. Changes to the tests or to `nvh` itself are reflected immediately without needing to rebuild the containers.

`bats` is being mounted directly out of `node_modules` into the container as a manual install based on its own install script. This is a bit of a hack, but avoids needing to install `git` or `npm` for a full remote install of `bats`, and means everything on the same version of `bats`.

The containers each have:

* either curl or wget (or both) installed

Using `docker-compose` adds:

* specified `nvh` script mounted to `/usr/local/bin/nvh`
* `test/tests` mounted to `/mnt/test/tests`
* `node_modules/bats` provides `/usr/local/bin/bats` et al
* curl and wget startup files to suppress certificate checking, to allow proxy usage

So for example:

    cd test
    docker-compose run ubuntu-curl
      # in container
      nvh --version
      bats /mnt/test/tests
