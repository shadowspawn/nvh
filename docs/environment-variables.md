# Environment Variables

`NVH_PREFIX` is covered in the [README](../README.md#optional-environment-variables)

If you are using `sudo` for the install, by default the command you run does not have access to your exported environment variables. You can use `sudo -E` to preserve (pass) the existing environment variables.

## Custom Node Mirror

- `NVH_NODE_MIRROR`: overrides default <https://nodejs.org/dist/>
- `NVH_NODE_DOWNLOAD_MIRROR`: overrides default <https://nodejs.org/download>
  
If the custom mirror requires basic authentication, you can [url-encode](https://urlencode.org) the username and password directly in the URL:

    export NVH_NODE_MIRROR='https://user:password@host/path'

Note: the username and password will be visible (via `ps`) to other users on your computer while a download is running.

## Remote Listings

`nvh ls-remote` defaults to a showing a maximum of 20 matching versions, but you can change this. e.g.

    NVH_MAX_REMOTE_MATCHES=3

## Proxy Server

See also `https_proxy` in [Proxy Server](./proxy-server).
