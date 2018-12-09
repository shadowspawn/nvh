#!/usr/bin/env bats

load ../export_test_versions


@test "nvh uninstall (of lts)" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  nvh --insecure install lts
  [ -d "${TMP_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm ${LTS_VERSION}
  run find "${TMP_PREFIX}" -not -type d
  [ "$output" = "" ]

  rm -rf "${TMP_PREFIX}"
}


@test "nvh uninstall (of nightly)" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  nvh --insecure install nightly
  [ -d "${TMP_PREFIX}/nvh/versions/nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm --insecure nightly/${NIGHTLY_LATEST_VERSION}
  run find "${TMP_PREFIX}" -not -type d
  [ "$output" = "" ]

  rm -rf "${TMP_PREFIX}"
}
