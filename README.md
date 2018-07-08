# Node Version Helper

Easily install Node.js versions. No profile setup required for default install location.

Requires `bash` (and does not require a working node install).

Forked from [tj/n](https://github.com/tj/n) with changes to command syntax, bug fixes, and feature additions.

## Installation

Since you probably already have `node`, the easiest way to install `nvh` is through `npm`:

    npm install -g @shadowspawn/nvh
    nvh --help

The `nvh` command installs node to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX` (see [environment variables](#optional-environment-variables)). The downloads are written to subdirectory `nvh/versions`.

One way to bootstrap an install if `npm` is not yet available:

    git clone git@github.com:JohnRGee/nvh.git
    ./nvh/bin/nvh lts
    # Now node and npm are available
    npm install -g @shadowspawn/nvh
    nvh --help

## Installing Node Versions

Simply execute `nvh <version>` to download and install a version of `node`. If `<version>` has already been downloaded, `nvh` will activate that version.

    nvh 4.9.1
    nvh 6.14.3

Execute `nvh` on its own to view your downloaded versions. Use the up and down arrow keys to navigate and press enter or the right arrow key to select. Use `q` to exit the selection screen.
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

## Removing Downloaded Node Versions

Remove some downloaded versions:

    nvh rm 0.9.4 v0.10.0

Remove all versions except the installed version:

    nvh prune

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
    activated : v10.6.0
    $ npm --version
    6.1.0
    $ nvh --preserve lts
    activated : v8.11.3
    $ npm --version
    6.1.0

## Custom Architecture

By default `nvh` picks the binaries matching your system architecture, e.g. `nvh` will download 64 bit binaries for a 64 bit system. You can override this by using the `-a` or `--arch` option. (Note: `nvh` does not track the architecture of downloads, so this does not allow switching between architectures with same version.)

Install latest 32 bit version of `node`:

    nvh --arch x86 latest

## Optional Environment Variables

The `nvh` command downloads and installs to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX`. 
To change the location to say `$HOME/.nvh`, add lines like the following to your shell initialization file:

    export NVH_PREFIX=$HOME/.nvh
    export PATH=$NVH_PREFIX/bin:$PATH

Custom node mirror:

- `NVH_NODE_MIRROR`: overide default <https://nodejs.org/dist/>
- `NVH_NODE_MIRROR_USER`: if custom mirror uses basic authentication
- `NVH_NODE_MIRROR_PASSWORD`: if custom mirror uses basic authentication

