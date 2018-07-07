# Changelog

<!-- markdownlint-disable MD024 -->

## 1.0.0-0

Changes from upstream [tj/n](https://github.com/tj/n).

### Added

- add support for preserving npm+npx during install (`-p | --preserve-npm`)
  - [upstream PR #513](https://github.com/tj/n/pull/513)
- turn `stable` into an alias for `lts`
  - [upstream PR #467](https://github.com/tj/n/pull/467)
- support for recognition of `arm64` and `aarch64` architectures
  - [upstream PR #448](https://github.com/tj/n/pull/448)
- support codenames (e.g. carbon)
  - [upstream PR #515](https://github.com/tj/n/pull/515)
- added logging to install when no download required, saying activated or unchanged
  - [upstream issue #198](https://github.com/tj/n/issues/198)
- support partial version numbers with `bin` and `use` (e.g. 8)
  - [upstream issue #252](https://github.com/tj/n/issues/252)

### Changed

- fix `--lts` for mirrors with multiple versions
  - [upstream PR #512](https://github.com/tj/n/pull/512) (and [#360](https://github.com/tj/n/pull/360) for reproduce steps)
- changed error for missing codename with bin to display numeric version
- removed trailing space from `bin` output
  - [upstream issue #456](https://github.com/tj/n/issues/456)
- fixed partial number lookups for install/bin/use so 6.1 matches 6.1.0 (not 6.14.3)
- (internal) share lookups for install/bin/use so consistent behaviour (such as partial number lookups)
- minor changes to error messages for invalid versions
- remove old iojs support from code and help
  - [upstream PR #516](https://github.com/tj/n/pull/516)

### Removed
