# Environment Variables

`NVH_PREFIX` is covered in the [README](../README.md#optional-environment-variables)

If you are using `sudo` for the install, by default the command you run does not have access to your exported environment variables. You can use `sudo -E` to preserve (pass) the existing environment variables.

## Custom Node Mirror

- `NVH_NODE_MIRROR`: overrides default <https://nodejs.org/dist/>
- `NVH_NODE_DOWNLOAD_MIRROR`: overrides default <https://nodejs.org/download>
  
If the custom mirror requires basic authentication, you can url-encode the username and password directly in the URL:

    export NVH_NODE_MIRROR='https://user:password@host/path'

 or if you prefer, and no need to url-encode special characters:

    export NVH_NODE_MIRROR='https://host/path'
    export NVH_USER='user'
    export NVH_PASSWORD='password'

Note: in both cases, the username and password will be visible (via `ps`) to other users on your computer while a download is running.

## Proxy Server

You need to define the proxy server in an environment variable.
This is a standard variable name which is read directly by `curl` and `wget`.
You can url-encode the username and password in the URL. e.g.

    export https_proxy='http://user:password@host:port/path'

Or if you prefer you can use separate environment variables for the authentication, and no need to url-encode special characters. Note:  the username and password will be visible (via `ps`) to other users on your computer while a download is running.

    export https_proxy='http://host:port/path'
    export NVH_PROXY_USER='user'
    export NVH_PROXY_PASSWORD='password'

If you have defined a custom node mirror which uses http, then you would define `http_proxy` rather than `https_proxy`.

### More Proxy Options

While the above setting are enough for a proxy server that allows an SSL tunnel and does not inspect the traffic,
you may well need need more configuration for your proxy setup.

To allow the proxy server to supply its own ssl certificates for remote sites (man-in-the-middle), you can turn off certificate checking
with `--insecure`. e.g.

    nvh --insecure install lts

Another possible work-around for certificate problems is to use plain http by specifying a custom node mirror:

    export NVH_NODE_MIRROR=http://nodejs.org/dist
    export http_proxy='http://host:port/path'

### Trouble-shooting

To experiment and find what settings you need you can use `curl` (or `wget`) directly and see the error messages. e.g.

    export https_proxy='http://host:port/path'
    curl --head https://nodejs.org/dist/
    curl --head --insecure https://nodejs.org/dist/
    export http_proxy='http://host:port/path'
    curl --head http://nodejs.org/dist/

## Other Settings

`nvh ls-remote` defaults to a showing a maximum of 20 matching versions, but you can change this. e.g.

    NVH_MAX_REMOTE_MATCHES=3
