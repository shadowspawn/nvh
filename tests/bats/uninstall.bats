#!/usr/bin/env bats

load ../export_test_versions


@test "nvh uninstall (of lts)" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  nvh --insecure install lts
  [ -d "${TMP_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  nvh uninstall
  nvh rm ${LTS_VERSION}
  run find "${TMP_PREFIX}" -not -type d
  [ "$output" = "" ]

  rm -rf "${TMP_PREFIX}"
}
