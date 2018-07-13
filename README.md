# Node Version Helper

Easily install Node.js versions. No profile setup required for default install location.

Requires `bash` (and does not require a working node install).

Forked from [tj/n](https://github.com/tj/n) with changes to command syntax, bug fixes, and feature additions.

## Installation

Since you probably already have `node`, the easiest way to install `nvh` is through `npm`:

    npm install -g @shadowspawn/nvh
    nvh help

The `nvh` command installs node to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX` (see [environment variables](#optional-environment-variables)). The downloads are written to subdirectory `nvh/versions`.

One way to bootstrap an install if `npm` is not yet available:

    git clone git@github.com:JohnRGee/nvh.git
    ./nvh/bin/nvh lts
    # Now node and npm are available
    npm install -g @shadowspawn/nvh
    nvh help

## Installing Node Versions

Simply execute `nvh <version>` to download and install a version of `node`. If `<version>` has already been downloaded, `nvh` will install from its cache.

    nvh 4.9.1
    nvh 6.14.3

Execute `nvh` on its own to view your downloaded versions. Use the up and down arrow keys to navigate and press enter or the right arrow key to select. Use `q` to exit the selection screen without installing.
If you like vim key bindings during the selection of node versions, you can use `j` and `k` to navigate up or down without using arrows.

    $ nvh

      0.8.14
    ο 0.8.17
      0.9.6

Install the latest official release:

    nvh latest

Install the latest LTS official release:

    nvh lts

Install by codename or partial version number:

    nvh carbon
    nvh 8

## Using Node Without Installing

When running multiple versions of `node`, you can target
a downloaded version directly by asking `nvh` for the path:

    $ nvh which 0.9.4
    /usr/local/nvh/versions/0.9.4/bin/node

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

List remote version available for download, or latest available version for a named version or incomplete version:

    nvh ls-remote
    nvh ls-remote lts

List downloaded versions:

    nvh ls

Remove some downloaded versions. Accepts explicit version numbers, and not named versions or incomplete version numbers.

    nvh rm 0.9.4 v0.10.0

Remove all downloaded versions except the installed version:

    nvh prune

Display diagnostics to help resolve problems:

    nvh doctor

## Coming from `tj/n`

There are a lot of minor changes! Taking advantage of a fresh start.

### Changed

- `n use` and `n as` --> `nvh run`
- `n --lts` --> `nvh ls-remote lts`
- `n --latest` --> `nvh ls-remote latest`
- environment variable names and download location
- always install, even if installed version appears to match
- allow removing installed version

### Removed

- `n bin` alias
- `n -` alias
- `stable`
- iojs support
- `--download`
- `--arch` deprecated

## Optional Environment Variables

The `nvh` command downloads and installs to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX`.
To change the location to say `$HOME/.nvh`, add lines like the following to your shell initialization file:

    export NVH_PREFIX=$HOME/.nvh
    export PATH=$NVH_PREFIX/bin:$PATH

Custom node mirror:

- `NVH_NODE_MIRROR`: override default <https://nodejs.org/dist/>
- `NVH_NODE_MIRROR_USER`: if custom mirror uses basic authentication
- `NVH_NODE_MIRROR_PASSWORD`: if custom mirror uses basic authentication
