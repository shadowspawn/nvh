# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

<!-- markdownlint-disable MD024 -->

## [1.0.0-0] (unreleased)

Changes from upstream [tj/n](https://github.com/tj/n).

### Added

- add support for preserving npm+npx during install (`-p | --preserve`)
    - [upstream PR #513](https://github.com/tj/n/pull/513)
- support for recognition of `arm64` and `aarch64` architectures
    - [upstream PR #448](https://github.com/tj/n/pull/448)
- support codenames (e.g. carbon)
    - [upstream PR #515](https://github.com/tj/n/pull/515)
- added logging to install when no download required
    - [upstream issue #198](https://github.com/tj/n/issues/198)
- support partial version numbers with `which` and `run` (e.g. 8)
    - [upstream issue #252](https://github.com/tj/n/issues/252)
    - (developer) `.gitignore` `.editorconfig` `.markdownling.js`
- `nvh lsr [inexact-version]`, like `nvh lsr lts` or `nvh lsr 6`, to lookup latest downloadable version
- `nvh doctor` to show useful diagnostics

### Changed

- fix `--lts` for mirrors with multiple versions
    - [upstream PR #512](https://github.com/tj/n/pull/512) (and [#360](https://github.com/tj/n/pull/360) for reproduce steps)
- changed error for missing codename with `which` to display numeric version
- removed trailing space from `which` output
    - [upstream issue #456](https://github.com/tj/n/issues/456)
- fixed partial number lookups for install/which/run so 6.1 matches 6.1.0 (not 6.14.3)
- (internal) share lookups for install/which/run so consistent behaviour (such as partial number lookups)
- remove old iojs support from code and help
    - [upstream PR #516](https://github.com/tj/n/pull/516)
- changed N_PREFIX to NVH_PREFIX
- changed base versions directory from `n/versions` to `nvh/versions`
- `NODE_MIRROR` changed to `NVH_NODE_MIRROR`
- `HTTP_USER` changed to `NVH_NODE_MIRROR_USER`
- `HTTP_PASSWORD` changed to `NVH_NODE_MIRROR_PASSWORD`
- `n use` and `n as` changed to `nvh run` (as per `nvm` and `nvs`)
- `nvh ls` lists downloaded versions
- `nvh ls-remote` replaces `n ls`
- error messages to STDERR

### Removed

- removed support for deprecated `stable` version
    - [upstream issue #354](https://github.com/tj/n/issues/354)
- removed support for `PROJECT_NAME` (and `n project`)
- remove support for `PROJECT_VERSION_CHECK`
- `Makefile`
- `n --latest` replaced by `nvh lsr latest`
- `n --lts` replaced by `nvh lsr lts`
- `bin` alias for `n which`
- `-` alias for `n rm`
- `--download`
- `--arch`

[1.0.0-0]: https://github.com/tj/n/compare/8ad6cd3bc76fc674f7faf3d8cf2f4d6e7d1849c3...JohnRGee:develop
