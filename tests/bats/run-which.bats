#!/usr/bin/env bats

load ../export_test_versions


@test "nvh run argon, nvh run ${ARGON_VERSION}, nvh run 4" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  nvh --insecure i argon

  run nvh --insecure run argon --version
  [ "$output" = "${ARGON_VERSION}" ]

  run nvh --insecure run "${ARGON_VERSION}" --version
  [ "$output" = "${ARGON_VERSION}" ]

  run nvh --insecure run 4 --version
  [ "$output" = "${ARGON_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

@test "nvh which lts, nvh which ${LTS_VERSION}" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  nvh --insecure i lts

  run nvh --insecure which lts
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]

  run nvh --insecure which "${LTS_VERSION}"
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]

  rm -rf "${TMP_PREFIX}"
}
