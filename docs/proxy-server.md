# Proxy Server

Under the hood, `nvh` uses `curl` or `wget` for the downloads. `curl` is used if available, and `wget` otherwise. Both `curl` and `wget` support using environment variables or startup files to set up the proxy.

## Using Environment Variable

You can define the proxy server using an environment variable, which is read by multiple commands including `curl` and `wget`:

    export https_proxy='http://host:port/path'

If your proxy requires authentication you can [url-encode](https://urlencode.org) the username and password in the URL. e.g.

    export https_proxy='http://user:password@host:port/path'

If you have defined a custom node mirror which uses http, then you would define `http_proxy` rather than `https_proxy`.

## Certificate Checks

Your proxy server may supply its own ssl certificates for remote sites (as a man-in-the-middle). If you can not arrange to trust the proxy in this role, you can turn off (all) certificate checking with `--insecure`. e.g.

    nvh --insecure install lts

Another possible work-around for certificate problems is to use plain http by specifying a custom node mirror:

    export NVH_NODE_MIRROR='http://nodejs.org/dist'
    export http_proxy='http://host:port/path'

## Startup Files

An alternative to using an environment variable for the proxy settings is to configure a startup file for the command.

Example `~/.curlrc` ([documentation](https://ec.haxx.se/cmdline-configfile.html))

    proxy = http://host:port/path
    proxy-user = user:password
    # If need to disable certificate checks
    --insecure

Example `~/.wgetrc` ([documentation](https://www.gnu.org/software/wget/manual/html_node/Wgetrc-Commands.html#Wgetrc-Commands))

    https_proxy = http://host:port/path
    proxy_user = user
    proxy_password = password
    # If need to disable certificate checks
    check_certificate = off

## Troubleshooting

To experiment and find what settings you need you can use `curl` (or `wget`) directly with the node mirror and check the error messages.

    export https_proxy='http://host:port/path'
    curl --head https://nodejs.org/dist/
    curl --head --insecure --verbose https://nodejs.org/dist/
    export http_proxy='http://host:port/path'
    curl --head http://nodejs.org/dist/

For curl, two options of note for debugging are:

    -v, --verbose
    Makes curl verbose during the operation. Useful for debugging
    and seeing what's going on "under the hood". ...

    -q, --disable
    If used as the first parameter on the command line,
    the curlrc config file will not be read and used. ...
