# Changelog

<!-- markdownlint-disable MD024 -->

## [Unreleased]

### Added

- support for recognition of `arm64` and `aarch64` architectures
  - [upstream PR #448](https://github.com/tj/n/pull/448)

### Changed

- Fix `--lts` for mirrors with multiple versions
  - [upstream PR #512](https://github.com/tj/n/pull/512) (and [#360](https://github.com/tj/n/pull/360) for reproduce steps)

### Removed

## 2.2.0

### Added

- Add support for preserving npm+npx during install (`-p | --preserve-npm`)
  - [upstream PR #513](https://github.com/tj/n/pull/513)
- Turn `stable` into an alias for `lts`
  - [upstream PR #467](https://github.com/tj/n/pull/467)
