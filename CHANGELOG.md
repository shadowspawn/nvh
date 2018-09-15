# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

<!-- markdownlint-disable MD024 -->

## [6.0.0] (2018-09-15)

### Added

- `nvh cache clear` remove all downloaded versions
- `nvh cache prune` remove all downloaded versions except the installed version (replacing `nvh prune`)

### Changed

- using `index.tab` on mirror rather than scraping html page to find remote versions
- more accurate and informative error messages for failed `curl`/`wget` operations, including
    - show `curl` errors
    - show remote url for failed `curl`/`wget` operations
- narrowing candidate versions to ones matching platform
    - inspired by [upstream issue #463](https://github.com/tj/n/issues/463), and problems with nightly
- change terminology from "stash" to "cache"

### Deprecated

- `nvh prune` (replaced by `nvh cache prune`)

### Removed

- numbered release streams like 'v8.x': instead, use incomplete version like '8'

## [5.0.0] (2018-08-19)

### Removed

- `NVH_USER` and `NVH_PASSWORD`: instead, include in `NVH_NODE_MIRROR`)
- `NVH_PROXY_USER` and `NVH_PROXY_PASSWORD`: instead, include in proxy url or `.curlrc` or `.wgetrc`

## [4.2.1] (2018-08-18) [YANKED]

(These changes should be in a major version change, will be published on npm in 5.0.0)

### Removed

- `NVH_USER` and `NVH_PASSWORD`: instead, include in `NVH_NODE_MIRROR`)
- `NVH_PROXY_USER` and `NVH_PROXY_PASSWORD`: instead, include in proxy url or `.curlrc` or `.wgetrc`

## [4.2.0] (2018-08-11)

### Changed

- refactored documentation and extended proxy tips

### Deprecated

- `NVH_USER` and `NVH_PASSWORD`: instead, include in `NVH_NODE_MIRROR`)
- `NVH_PROXY_USER` and `NVH_PROXY_PASSWORD`: instead, include in proxy url or `.curlrc` or `.wgetrc`

## [4.1.0] (2018-08-04)

### Added

- support for [NO_COLOR](http://no-color.org) and [CLICOLOR=0](https://bixense.com/clicolors)
- more checks in `nvh doctor`
- `--insecure` option, sometimes needed for working through proxy servers

### Changed

- suppress ansi colours when stdout is not a terminal

## [4.0.0] (2018-07-29)

Major changes to install:

- now requiring explicit `install` command like `nvh install lts`
- install implementation is now using `rsync`

### Added

- instructions at bottom of `nvh` version selection
- allow options after command, as well as before
- `current` as alias for `latest`
    - [issue #2](https://github.com/JohnRGee/nvh/issues/2)
    - inspired by [upstream issue #522](https://github.com/tj/n/issues/522)
- docs for using proxy
- environment variables for proxy username and password
    - inspired by [upstream issue #503](https://github.com/tj/n/pull/503)
- autodetect whether to show progress based on whether displaying to a terminal

### Changed

- requiring explicit `nvh install <version>` command, rather than implicit `nvh <version>`
- switched install implementation to `rsync`. This is a significant change and a new dependency for minimal installs, but allows improving some behaviours in a consistent way.
    - fix `--preserve` when there are links in destination (#1)
    - symbolic link below top level [upstream issue #100](https://github.com/tj/n/issues/100)
    - symbolic link at top level [upstream PR #227](https://github.com/tj/n/pull/227)
    - rejected rsync dependency [upstream PR #104](https://github.com/tj/n/pull/104)
- adopting suggestions of `shellcheck` (ongoing work-in-progress)
    - inspired by [upstream PR #465](https://github.com/tj/n/pull/465)
- changed preflight test before download to remove broken code and reduce calls for mirrors using redirects
    - inspired by [upstream PR #479](https://github.com/tj/n/pull/479)
- `--preserve` now works with interactive version selection too
- put single speech mark around supplied argument in error messages
    - inspired by [upstream PR #485](https://github.com/tj/n/pull/485)
- reworked implementation of `curl` and `wget` commands

### Removed

- unimplemented right-arrow from README instructions for interactive version selection
- `--no-check-certificate` for wget, secure by default, matching curl treatment
    - [upstream PR #509](https://github.com/tj/n/pull/509)
    - [upstream PR #475](https://github.com/tj/n/pull/475)
- `--quiet` option

## [3.0.0] (2018-07-15)

Changes from upstream [tj/n](https://github.com/tj/n) 2.1.12

### Added

- add support for preserving npm+npx during install (`-p | --preserve`)
    - [upstream PR #513](https://github.com/tj/n/pull/513)
- support for recognition of `arm64` and `aarch64` architectures
    - [upstream PR #448](https://github.com/tj/n/pull/448)
- support more versions
    - codenames (e.g. `carbon`)
        - [upstream PR #515](https://github.com/tj/n/pull/515)
    - release streams (e.g. `v8.x`)
        - [upstream PR #515](https://github.com/tj/n/pull/515)
    - folders on downloads mirror using syntax `<folder>/<release>`
        - e.g. `nightly` [upstream issue #376](https://github.com/tj/n/issues/376)
        - e.g. `chakracore-release` [upstream issue #480](https://github.com/tj/n/issues/480)
- added logging to install when no download required
    - [upstream issue #198](https://github.com/tj/n/issues/198)
- support partial version numbers with `which` and `run` (e.g. 8)
    - [upstream issue #252](https://github.com/tj/n/issues/252)
- (developer) `.gitignore` `.editorconfig` `.markdownlint.js`
- `nvh ls-remote [version]` to lookup matching downloadable versions
- `nvh doctor` to show useful diagnostics

### Changed

- fix `--lts` for mirrors with multiple versions in release stream folders
    - [upstream PR #512](https://github.com/tj/n/pull/512)
- changed error message for `which` and `run` to include specified and matching version
- removed trailing space from `which` output
    - [upstream issue #456](https://github.com/tj/n/issues/456)
- fixed partial number lookups so 6.1 matches 6.1.0 (not 6.14.3)
- (internal) share lookups for install/which/run/rm so consistent behaviour (such as partial number lookups)
- remove old iojs support from code and help
    - [upstream PR #516](https://github.com/tj/n/pull/516)
- changed environment variable names
    - `N_PREFIX` to `NVH_PREFIX`
    - `NODE_MIRROR` changed to `NVH_NODE_MIRROR`
    - `HTTP_USER` changed to `NVH_NODE_MIRROR_USER`
    - `HTTP_PASSWORD` changed to `NVH_NODE_MIRROR_PASSWORD`
- changed cache versions directory from `n/versions` to `nvh/versions`
- `n use` and `n as` changed to `nvh run` (as per `nvm` and `nvs`)
- `nvh ls` lists downloaded versions
- `nvh ls-remote` replaces `n ls`
- error messages to STDERR
- limit number of versions listed by ls-remote
    - [upstream issue #383](https://github.com/tj/n/issues/383)

### Removed

- removed support for deprecated `stable` version
    - [upstream issue #354](https://github.com/tj/n/issues/354)
    - comments in [upstream PR #322](https://github.com/tj/n/pull/322)
    - [upstream PR #467](https://github.com/tj/n/pull/467)
- removed support for `n project` (and `PROJECT_NAME` and `PROJECT_VERSION_CHECK`)
- `Makefile`
- `n --latest` replaced by `nvh lsr latest`
- `n --lts` replaced by `nvh lsr lts`
- alias of `bin` for `which`
- alias of `-` for `rm`
- `--download` option
- `--arch` option

[Unreleased]: https://github.com/JohnRGee/nvh/compare/master...develop
[6.0.0]: https://github.com/JohnRGee/nvh/compare/v5.0.0...JohnRGee:v6.0.0
[5.0.0]: https://github.com/JohnRGee/nvh/compare/v4.2.0...JohnRGee:v5.0.0
[4.2.1]: https://github.com/JohnRGee/nvh/compare/v4.2.0...JohnRGee:v4.2.1
[4.2.0]: https://github.com/JohnRGee/nvh/compare/v4.1.0...JohnRGee:v4.2.0
[4.1.0]: https://github.com/JohnRGee/nvh/compare/v4.0.0...JohnRGee:v4.1.0
[4.0.0]: https://github.com/JohnRGee/nvh/compare/v3.0.0...JohnRGee:v4.0.0
[3.0.0]: https://github.com/tj/n/compare/8ad6cd3bc76fc674f7faf3d8cf2f4d6e7d1849c3...JohnRGee:v3.0.0
