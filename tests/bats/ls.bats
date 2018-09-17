#!/usr/bin/env bats

load ../export_test_versions


@test "nvh ls # just plain node" {
  readonly TMP_PREFIX="$(mktemp -d)"

  # KISS and just make folders rather than do actual installs
  mkdir -p "${TMP_PREFIX}/nvh/versions/node/${ARGON_VERSION}"
  mkdir -p "${TMP_PREFIX}/nvh/versions/node/${LTS_VERSION}"

  NVH_PREFIX="${TMP_PREFIX}" run nvh ls
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[1]}" = "node/${LTS_VERSION}" ]
  [ "${lines[2]}" = "" ]

  rm -rf "${TMP_PREFIX}"
}

@test "nvh list # mixed node and nightly" {
  readonly TMP_PREFIX="$(mktemp -d)"

  # KISS and just make folders rather than do actual installs
  mkdir -p "${TMP_PREFIX}/nvh/versions/nightly/${NIGHTLY_LATEST_VERSION}"
  mkdir -p "${TMP_PREFIX}/nvh/versions/node/${LATEST_VERSION}"

  NVH_PREFIX="${TMP_PREFIX}" run nvh list
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ "${lines[1]}" = "node/${LATEST_VERSION}" ]
  [ "${lines[2]}" = "" ]

  rm -rf "${TMP_PREFIX}"
}

