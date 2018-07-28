# Environment Variables

`NVH_PREFIX` is covered in the [README](../README.md#optional-environment-variables)

If you are using `sudo` for the install, by default the command you run does not have access to your exported environment variables. You can use `sudo -E` to preserve (pass) the existing environment variables.

## Custom Node Mirror

- `NVH_NODE_MIRROR`: overrides default <https://nodejs.org/dist/>
- `NVH_NODE_DOWNLOAD_MIRROR`: overrides default <https://nodejs.org/download>
  
If the custom mirror requires basic authentication, you can url-encode the username and password directly in the URL:

    NVH_NODE_MIRROR='https://user:password@host/path'

 or if you prefer, and no need to url-encode special characters:
 
    NVH_NODE_MIRROR='https://host/path'
    NVH_USER='user'
    NVH_PASSWORD='password'

Note: in both cases, the username and password will be visible to anyone who runs `ps` while a download is running.

## Proxy Server

To keep things simple, this description assumes you are comfortable using plain `http` between your computer and the proxy server, and then `https` between the proxy server and the mode mirror. Using `http` for the local part of the connection implies we trust it and the local network, and avoids complications with the man-in-the-middle certificates offered by the proxy server.

The standard environment variable for specifying the proxy for https is  `https_proxy`, and can include the url-encoded username and password:

     https_proxy=http://user:password@host:port/path

 or if you prefer, and no need to url-encode special characters:

    https_proxy=http://host:port/path
    NVH_PROXY_USER='user'
    NVH_PROXY_PASSWORD='password'

Note: in the second case, the username and password will be visible to anyone who runs `ps` while a download is running.

(If you have defined a custom node mirror which uses http, then you would define `http_proxy` rather than `https_proxy`.)

## Other Settings

`nvh ls-remote` defaults to a showing a maximum of 20 matching versions, but you can change this. e.g.

    NVH_MAX_REMOTE_MATCHES=3

