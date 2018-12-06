#!/usr/bin/env bats

load ../export_test_versions


@test "NVH_MODE_MIRROR=https://npm.taobao.org/mirrors/node nvh install 6" {
  readonly TMP_PREFIX="$(mktemp -d)"

  NVH_PREFIX="${TMP_PREFIX}" NVH_MODE_MIRROR="https://npm.taobao.org/mirrors/node" nvh --insecure install 6

  # KISS and assuming lts version on mirror is same as nodejs.org.
  [ -d "${TMP_PREFIX}/nvh/versions/node/${TAOBAO_6_VERSION}" ]
  [ -f "${TMP_PREFIX}/bin/node" ]

  run "${TMP_PREFIX}/bin/node" --version
  [ "$output" = "${TAOBAO_6_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}
