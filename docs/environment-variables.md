# Environment Variables

Note: if you are using `sudo` for the install, by default the command you run does not have access to your exported environment variables. You can use `sudo -E` to pass the existing environment variables.

## Custom Install Destination

The `nvh` command downloads and installs to `/usr/local` by default, but you may override this location by defining `NVH_PREFIX`. e.g.

    export NVH_PREFIX=$HOME/.nvh
    export PATH=$NVH_PREFIX/bin:$PATH

## Custom Node Mirror

- `NVH_NODE_MIRROR`: overrides default <https://nodejs.org/dist/>
- `NVH_NODE_DOWNLOAD_MIRROR`: overrides default <https://nodejs.org/download>
  
If the custom mirror requires basic authentication, you can [url-encode](https://urlencode.org) the username and password directly in the URL:

    export NVH_NODE_MIRROR='https://user:password@host/path'

Note: the username and password will be visible (via `ps`) to other users on your computer while a download is running.

## Remote Listings

`nvh ls-remote` defaults to a showing a maximum of 20 matching versions, but you can change this. e.g.

    export NVH_MAX_REMOTE_MATCHES=3

## Preserving npm

By default the `node` install also includes `npm` and `npx`. You can change this by setting `NVH_PRESERVE_NPM` to a non-empty string. This has the same affect as specifying `--preserve` on the command line, and leaves `npm` and `npx` out of the install preserving the current versions.

    export NVH_PRESERVE_NPM=1

You can be explicit to get the desired behaviour whatever the environment variable:

    nvh install --no-preserve latest
    nvh install --preserve nightly

## Proxy Server

See also `https_proxy` in [Proxy Server](proxy-server.md).

## xz Compression

nvh defaults to using xz compressed node tarballs for the download if it is likely tar on the system supports xz decompression.
You can override the automatic choice by setting an environment variable to zero or non-zero:

    export NVH_USE_XZ=0 # to disable
    export NVH_USE_XZ=1 # to enable

You can be explicit to get the desired behaviour whatever the environment variable:

    nvh install --use-xz nightly
    nvh install --no-use-xz latest
