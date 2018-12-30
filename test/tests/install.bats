#!/usr/bin/env bats

load ../export_test_versions


@test "nvh install lts" {
  readonly TMP_PREFIX="$(mktemp -d)"

  NVH_PREFIX="${TMP_PREFIX}" nvh --insecure install lts

  [ -d "${TMP_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

# mostly --preserve, but also variations with i/install and codename/numeric
@test "nvh i argon; nvh --preserve install ${LTS_VERSION} # (2 installs)" {
  readonly TMP_PREFIX="$(mktemp -d)"
  readonly ARGON_NPM_VERSION="2.15.11"

  NVH_PREFIX="${TMP_PREFIX}" nvh --insecure i argon

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${ARGON_VERSION}" ]

  run "${TMP_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]

  NVH_PREFIX="${TMP_PREFIX}" nvh --insecure --preserve install "${LTS_VERSION}"

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]

  # preserved npm version
  run "${TMP_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

@test "nvh install nightly" {
  readonly TMP_PREFIX="$(mktemp -d)"

  NVH_PREFIX="${TMP_PREFIX}" nvh --insecure install nightly

  [ -d "${TMP_PREFIX}/nvh/versions/nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${NIGHTLY_LATEST_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

