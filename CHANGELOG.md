# Changelog

<!-- markdownlint-disable MD024 -->

## 3.0.0
 
 New features. Some changes which are not fully backwards compatible.

### Added

- support for recognition of `arm64` and `aarch64` architectures
  - [upstream PR #448](https://github.com/tj/n/pull/448)
- support codenames (e.g. carbon)
  - [upstream PR #514](https://github.com/tj/n/pull/514)

### Changed

- fix `--lts` for mirrors with multiple versions
  - [upstream PR #512](https://github.com/tj/n/pull/512) (and [#360](https://github.com/tj/n/pull/360) for reproduce steps)
- changed error for missing codename with bin to display numeric version
- changed error for invalid codename to say codename rather than version
- removed trailing space from `bin` output
  - [upstream issue #456](https://github.com/tj/n/issues/456)

### Removed

## 2.2.0

### Added

- add support for preserving npm+npx during install (`-p | --preserve-npm`)
  - [upstream PR #513](https://github.com/tj/n/pull/513)
- turn `stable` into an alias for `lts`
  - [upstream PR #467](https://github.com/tj/n/pull/467)
