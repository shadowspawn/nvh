# Node Version Helper

Easily install Node.js versions. No profile setup required for default install location.

Requires `bash` (but does not require a working node install).

Forked from [tj/n](https://github.com/tj/n)

<!-- ## Installation

Since you probably already have `node`, the easiest way to install `nvh` is through `npm`:

    npm install -g @shadowspawn/nvh

**[WORK IN PROGRESS]** 

Once installed, `n` installs `node` versions to subdirectory `n/versions` of the directory specified in environment variable `N_PREFIX`, which defaults to `/usr/local`; the _active_ `node`/`iojs` version is installed directly in `N_PREFIX`.
To change the default to, say, `$HOME`, prefix later calls to `n` with `N_PREFIX=$HOME` or add `export N_PREFIX=$HOME` to your shell initialization file.

## Installing/Activating Versions

Simply execute `n <version>` to install a version of `node`. If `<version>` has already been installed (via `n`), `n` will activate that version.

    n 4.9.1
    n 6.14.3
    n 8.1.3

Execute `n` on its own to view your currently installed versions. Use the up and down arrow keys to navigate and press enter or the right arrow key to select. Use ^C (control + C) to exit the selection screen.
If you like vim key bindings during the selection of node versions, you can use `j` and `k` to navigate up or down without using arrows.

    $ n

      0.8.14
    ο 0.8.17
      0.9.6

Use or install the latest official release:

    n latest

Use or install the latest LTS official release:

    n lts

Use or install release streams by codename or partial version number:

    n carbon
    n 8

## Removing Versions

Remove some versions:

    n rm 0.9.4 v0.10.0

Alternatively, you can use `-` in lieu of `rm`:

    n - 0.9.4

Removing all versions except the current version:

    n prune

## Binary Usage

When running multiple versions of `node`, we can target
them directly by asking `n` for the binary path:

    $ n bin 0.9.4
    /usr/local/n/versions/0.9.4/bin/node

Or by using a specific version through `n`'s `use` sub-command:

    n use 0.9.4 some.js

Flags also work here:

    n as 0.9.4 --debug some.js

Output can also be obtained from `n --help`.


## Working with `npm`

A node install normally includes npm as well, which might be a downgrade if you have upgraded npm separately. You can preserve your current npm and exclude it from the install:

    n --preserve-npm 6.1.0

## Usage


## Custom source

If you would like to use a project other than the official Node.js project, you can use the special `n project [command]` which allows you to control the behavior of `n` using environment variables.

NODE_MIRROR

Optional Variables:

* `HTTP_USER`: The username if the `PROJECT_URL` is protected by basic authentication
* `HTTP_PASSWORD`: The password if the `PROJECT_URL` is protected by basic authentication
* `PROJECT_VERSION_CHECK`: Many custom projects keep the same version number as the Node.js release they are based on, and maintain their own separate version in process. This allows you to define a JavaScript variable that will be used to check for the version of the process, for example: `process.versions.node`

## Custom architecture

By default `n` picks the binaries matching your system architecture, e.g. `n` will download 64 bit binaries for a 64 bit system. You can override this by using the `-a` or `--arch` option.

Download and use latest 32 bit version of `node`:

    n --arch x86 latest

Download and use 64 bit LTS version of `node` for older Mac Intel Core 2 Duo systems (x86 image is no longer available but x64 runs fine):

    n --arch x64 lts

## Additional Details

`n` installs versions to `/usr/local/n/versions` by default. Here, it can see what versions are currently installed and activate previously installed versions accordingly when `n <version>` is invoked again.

Activated versions are then installed to the prefix `/usr/local`, which may be altered via the __`N_PREFIX`__ environment variable.

To alter where `n` operates, simply `export N_PREFIX`.
 -->
