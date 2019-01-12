# Node Version Helper

[![npm version](https://img.shields.io/npm/v/@shadowspawn/nvh.svg)](https://www.npmjs.com/package/@shadowspawn/nvh)

Easily install Node.js versions. No profile setup required for default install location.

Requires `bash` (and does not require a working node install).

Forked from [tj/n](https://github.com/tj/n) with [changes to command syntax](docs/coming-from-n.md), bug fixes, and new features.

- [Node Version Helper](#node-version-helper)
    - [Installation](#installation)
    - [Installing Node Versions](#installing-node-versions)
    - [Specifying Node Versions](#specifying-node-versions)
    - [Using Downloaded Node Versions Without Reinstalling](#using-downloaded-node-versions-without-reinstalling)
    - [Preserving npm](#preserving-npm)
    - [Miscellaneous](#miscellaneous)
    - [Optional Environment Variables](#optional-environment-variables)
    - [How It Works](#how-it-works)
    - [Alternatives to `nvh`](#alternatives-to-nvh)

## Installation

If you already have `node`, the easiest way to install `nvh` is through `npm`:

    npm install -g @shadowspawn/nvh
    nvh help

`nvh` installs node to `/usr/local` by default, but you may change this location by defining `NVH_PREFIX` (see [environment variables](#optional-environment-variables)). The downloads are written to a cache in subdirectory `nvh/versions`.

One way to bootstrap an install if `npm` is not yet available:

    curl -L https://github.com/JohnRGee/nvh/raw/master/bin/nvh -o nvh
    bash nvh install lts
    # Now node and npm are available

## Installing Node Versions

Execute `nvh install <version>` to download and install a version of `node`. If `<version>` has already been downloaded, `nvh` will install from its cache.

    nvh install 4.9.1
    nvh i lts

Execute `nvh` on its own to view your downloaded versions, and install the selected version.

    $ nvh

      node/v4.9.1
    ο node/v6.14.3
      node/v8.11.3

    Use up/down arrow keys to select a version, return key to install, q to quit

(You can also use `j` and `k` to navigate up or down without using arrows.)

## Specifying Node Versions

There are a variety of ways of specifying the target node version for `nvh` commands. Most commands use the latest matching version, and  `nvh ls-remote` lists multiple matching versions.

Numeric version numbers can be complete or incomplete, with an optional leading `v`.

- `4.9.1`
- `8`: 8.x.y versions
- `v6.1`: 6.1.x versions

There are labels for two especially useful versions:

- `lts`: newest Long Term Support official release
- `latest`, `current`: newest official release

There is support for release streams:

- `argon`, `boron`, `carbon`: codenames for LTS release streams

The last form is for specifying [other releases](https://nodejs.org/download) available using the name of the remote download folder optionally followed by the complete or incomplete version.

- `chakracore-release/latest`
- `nightly`
- `test/v11.0.0-test20180528`
- `rc/10`

## Using Downloaded Node Versions Without Reinstalling

There are three commands for working directly with your downloaded versions of `node`, without reinstalling.

You can show the path to the downloaded version:

    $ nvh which 6.14.3
    /usr/local/nvh/versions/6.14.3/bin/node

Or run a downloaded `node` version with the `nvh run` command:

    nvh run 8.11.3 --debug some.js

Or execute a command with `PATH` modified so `node` and `npm` will be from the downloaded `node` version.
(NB: this `npm` will be working with a different and empty global node_modules directory, and you should not install global
modules this way.)

    nvh exec 10 my-script --fast test

## Preserving npm

A `node` install normally includes `npm` as well, but you may wish to preserve an updated `npm` and `npx` leaving them out of the install:

    $ nvh install latest
    installed : v10.6.0
    $ npm --version
    6.1.0
    $ nvh install --preserve v8.0.0
    installed : v8.0.0
    $ npm --version
    6.1.0

## Miscellaneous

Remove the installed version of node and npm:

    nvh uninstall

List matching remote versions available for download:

    nvh ls-remote lts
    nvh ls-remote latest
    nvh lsr 6
    nvh lsr --all

List downloaded versions in cache:

    nvh ls

Remove some downloaded versions:

    nvh rm 0.9.4 v0.10.0

Remove all downloaded versions except the version matching the installed version, or all:

    nvh cache prune
    nvh cache clear

Display diagnostics to help resolve problems:

    nvh doctor

## Optional Environment Variables

The `nvh` command downloads and installs to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX`.
To change the location to say `$HOME/.nvh`, add lines like the following to your shell initialization file:

    export NVH_PREFIX=$HOME/.nvh
    export PATH=$NVH_PREFIX/bin:$PATH

See [Environment Variables](docs/environment-variables.md) for more about these settings:

    NVH_NODE_MIRROR
    NVH_NODE_DOWNLOAD_MIRROR
    NVH_MAX_REMOTE_MATCHES

See [Proxy Server](docs/proxy-server.md) for variables and advice for using a proxy server.

    https_proxy

## How It Works

`nvh` downloads a prebuilt `node` package and installs to a single prefix (e.g. `/usr/local`). This overwrites the previous version. The `bin` folder in this location should be in your `PATH` (e.g. `/usr/local/bin`).

The downloads are kept in a cache folder to be used for reinstalls. The downloads are also available for limited use using `nvh which` and `nvh run` and `nvh exec`.

The global `npm` packages are not changed by the install, with the
exception of `npm` itself which by default is part of the `node` install.

## Alternatives to `nvh`

`nvh` is a fork from [tj/n](https://github.com/tj/n), so the original is an alternative!

`nvh` does not:

- manage the global npm modules per version of node
- dynamically change the available node as navigate in shell
- run natively on Windows (although there is now the Windows Subsystem for Linux on Windows 10)

Three alternatives offering different feature sets are:

- [nvs](https://github.com/jasongin/nvs) Node Version Switcher
- [nvm](https://github.com/creationix/nvm) Node Version Manager
- [nave](https://github.com/isaacs/nave) Virtual Environments for Node
