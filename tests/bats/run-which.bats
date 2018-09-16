#!/usr/bin/env bats

load ../export_test_versions

@test "nvh run argon, nvh run ${ARGON_VERSION}, nvh run 4" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  run nvh --insecure i argon
  [ "$status" -eq 0 ]

  run nvh --insecure run argon --version
  [ "$status" -eq 0 ]
  [ "$output" = "${ARGON_VERSION}" ]

  run nvh --insecure run "${ARGON_VERSION}" --version
  [ "$status" -eq 0 ]
  [ "$output" = "${ARGON_VERSION}" ]

  run nvh --insecure run 4 --version
  [ "$status" -eq 0 ]
  [ "$output" = "${ARGON_VERSION}" ]

  rm -rf "${TMP_PREFIX}"
}

@test "nvh which lts, nvh which ${LTS_VERSION}" {
  readonly TMP_PREFIX="$(mktemp -d)"
  export NVH_PREFIX="${TMP_PREFIX}"

  run nvh --insecure i lts
  [ "$status" -eq 0 ]

  run nvh --insecure which lts
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]

  run nvh --insecure which "${LTS_VERSION}"
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]

  rm -rf "${TMP_PREFIX}"
}
