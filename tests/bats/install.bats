#!/usr/bin/env bats

load ../export_test_versions

@test "nvh install lts" {
  readonly TMP_PREFIX="$(mktemp -d)"

  NVH_PREFIX="${TMP_PREFIX}" run nvh --insecure install lts
  [ "$status" -eq 0 ]

  [ -d "${TMP_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

# mostly --preserve, but also variations with i/install and codename/numeric
@test "nvh i argon; nvh --preserve install ${LTS_VERSION}" {
  readonly TMP_PREFIX="$(mktemp -d)"
  readonly ARGON_NPM_VERSION="2.15.11"

  NVH_PREFIX="${TMP_PREFIX}" run nvh --insecure i argon
  [ "$status" -eq 0 ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${ARGON_VERSION}" ]

  run "${TMP_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]

  NVH_PREFIX="${TMP_PREFIX}" run nvh --insecure --preserve install "${LTS_VERSION}"
  [ "$status" -eq 0 ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]

  # preserved npm version
  run "${TMP_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}
