#!/usr/bin/env bats

load ../export_test_versions

@test "nvh run argon, nvh run ${ARGON_VERSION}, nvh run 4" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  run nvh --insecure i argon
  [ "$status" -eq 0 ]

  [[ "$(nvh --insecure run argon --version)" = "${ARGON_VERSION}" ]]
  [[ "$(nvh --insecure run ${ARGON_VERSION} --version)" = "${ARGON_VERSION}" ]]
  [[ "$(nvh --insecure run 4 --version)" = "${ARGON_VERSION}" ]]

  rm -rf "${TMP_PREFIX}"
}

@test "nvh which lts, nvh which ${LTS_VERSION}" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  run nvh --insecure i lts
  [ "$status" -eq 0 ]

  [[ "$(nvh --insecure which lts)" = "${TMP_PREFIX}/nvh/versions/node/bin/${LTS_VERSION}" ]]
  [[ "$(nvh --insecure which ${LTS_VERSION})" = "${TMP_PREFIX}/nvh/versions/node/bin/${LTS_VERSION}" ]]

  rm -rf "${TMP_PREFIX}"
}
