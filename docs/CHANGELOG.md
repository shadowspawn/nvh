# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

<!-- markdownlint-disable MD024 -->

## [Unreleased]

REMINDER: experimenting with using rsync for all installs to cope with links better and have consistent behaviour!

### Added

- instructions at bottom of `nvh` version selection
- allow options after command, as well as before

### Changed

- adopting suggestions of `shellcheck` (ongoing work-in-progress)
    - inspired by [upstream PR #465](https://github.com/tj/n/pull/465)
- changed preflight test before download to remove broken code and reduce calls for mirrors using redirects
    - inspired by [upstream PR #479](https://github.com/tj/n/pull/479)
- `--preserve` now works with interactive version selection too
- put single speech mark around supplied argument in error messages
    - inspired by [upstream PR #485](https://github.com/tj/n/pull/485)
- switched install implementation from `tar` to `rsync`. This is a significant change and a new dependency for minimal installs, but allows improving some behaviours in a consistent way.
    - fix `--preserve` when there are links in destination (#1)
    - symbolic link below top level [upstream issue #100](https://github.com/tj/n/issues/100)
    - symbolic link at top level [upstream PR #227](https://github.com/tj/n/pull/227)
    - rejected rsync dependency [upstream PR #104](https://github.com/tj/n/pull/104)
- requiring explicit `nvh install <version>` command, rather than implicit `nvh <version>`

### Removed

- unimplemented right-arrow from README instructions for interactive version selection
- remove `--no-check-certificate` for wget, secure by default, matching curl treatment
    - [upstream PR #509](https://github.com/tj/n/pull/509)
    - [upstream PR #475](https://github.com/tj/n/pull/475)

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
- changed stash versions directory from `n/versions` to `nvh/versions`
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
[3.0.0]: https://github.com/tj/n/compare/8ad6cd3bc76fc674f7faf3d8cf2f4d6e7d1849c3...JohnRGee:v3.0.0
