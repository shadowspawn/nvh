# Node Version Helper

Easily install Node.js versions. No profile setup required for default install location.

Requires `bash` (and does not require a working node install).

Forked from [tj/n](https://github.com/tj/n) with changes to command syntax, bug fixes, and feature additions.

## Installation

If you already have `node`, the easiest way to install `nvh` is through `npm`:

    npm install -g @shadowspawn/nvh
    nvh help

`nvh` installs node to `/usr/local` by default, but you may change this location by defining `NVH_PREFIX` (see [environment variables](#optional-environment-variables)). The downloads are written to a stash in subdirectory `nvh/versions`.

One way to bootstrap an install if `npm` is not yet available:

    git clone git@github.com:JohnRGee/nvh.git
    ./nvh/bin/nvh lts
    # Now node and npm are available

## Installing Node Versions

Simply execute `nvh <version>` to download and install a version of `node`. If `<version>` has already been downloaded, `nvh` will install from its stash.

    nvh 4.9.1
    nvh lts

Execute `nvh` on its own to view your downloaded versions. Use the up and down arrow keys to navigate and press enter or the right arrow key to select. Use `q` to exit the selection screen without installing.
If you like vim key bindings during the selection of node versions, you can use `j` and `k` to navigate up or down without using arrows.

    $ nvh

      node/v4.9.1
    ο node/v6.14.3
      node/v8.11.3

## Specifying Node Versions

There are a variety of ways of specifying the target node version for `nvh` commands. Most commands use the latest matching version, and  `nvh ls-remote` lists multiple matching versions.

Numeric version numbers can be complete or incomplete, with an optional leading `v`.

- `4.9.1`
- `8`: 8.x.y versions
- `v6.1`: 6.1.x versions

There are labels for two especially useful versions:

- `lts`: latest Long Term Support official release
- `latest`: latest official release

There is support for release streams:

- `argon`, `boron`, `carbon`: codenames for LTS release streams
- `v6.x`, `7.x`: major version number release streams

The last form is for specifying [other releases](https://nodejs.org/download) available using the name of the remote download folder followed by the complete or incomplete version.

- `chakracore-release/latest`
- `nightly/10`
- `test/v11.0.0-test20180528`
- `rc/v10.0.0-rc.1`

## Using Downloaded Node Versions Without Reinstalling

There are two commands for working directly with your downloaded versions of `node`, without reinstalling.

You can show the path to the downloaded version:

    $ nvh which 6.14.3
    /usr/local/nvh/versions/6.14.3/bin/node

Or run a downloaded `node` version with the `nvh run` command:

    nvh run 8.11.3 --debug some.js

## Preserving npm

A `node` install normally includes `npm` as well, but you may wish to preserve an updated `npm` and `npx` leaving them out of the install:

    $ nvh latest
    installed : v10.6.0
    $ npm --version
    6.1.0
    $ nvh --preserve lts
    installed : v8.11.3
    $ npm --version
    6.1.0

## Miscellaneous

List matching remote versions available for download:

    nvh ls-remote lts
    nvh ls-remote latest
    nvh lsr 6
    nvh lsr --all

List downloaded versions in stash:

    nvh ls

Remove some downloaded versions:

    nvh rm 0.9.4 v0.10.0

Remove all downloaded versions except the current installed version:

    nvh prune

Display diagnostics to help resolve problems:

    nvh doctor

## Coming from `tj/n`

There are a lot of minor changes! Taking advantage of a fresh start.

### Changed

- `n use` and `n as` --> `nvh run`
- `n --lts` --> `nvh lsr lts`
- `n --latest` --> `nvh lsr latest`
- environment variable names and download location
- always install, even if installed version appears to match
- allow removing installed version

### Removed

- `n bin` alias
- `n -` alias
- `stable` version label
- explicit iojs support
- `--download` option
- `--arch` option

## Optional Environment Variables

The `nvh` command downloads and installs to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX`.
To change the location to say `$HOME/.nvh`, add lines like the following to your shell initialization file:

    export NVH_PREFIX=$HOME/.nvh
    export PATH=$NVH_PREFIX/bin:$PATH

Specifying custom node mirror:

- `NVH_NODE_MIRROR`: override default <https://nodejs.org/dist/>
- `NVH_NODE_DOWNLOAD_MIRROR`: override default <https://nodejs.org/download> for nightly et al
- `NVH_NODE_MIRROR_USER`: if custom mirror uses basic authentication
- `NVH_NODE_MIRROR_PASSWORD`: if custom mirror uses basic authentication

Customising behaviour:

- `NVH_MAX_REMOTE_MATCHES`: override default 20 for number of lines to show for ls-remote

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
