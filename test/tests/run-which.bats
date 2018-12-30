#!/usr/bin/env bats

load ../export_test_versions

function setup() {
  export NVH_PREFIX="${TMPDIR}/nvh/test/run"
  # See https://github.com/bats-core/bats-core/issues/39
  # beforeAll
  if [[ "${BATS_TEST_NUMBER}" -eq 1 ]] ; then
    nvh --insecure install argon
    nvh --insecure install lts
  fi
}

function teardown() {
  # afterAll
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "${BATS_TEST_NUMBER}" ]] ; then
    rm -rf "${NVH_PREFIX}"
  fi
}


@test "setupAll for run/which/exec # (2 installs)" {
  # Dummy test so setupAll displayed while running first setup
  [ -d "${NVH_PREFIX}/nvh/versions/node/${ARGON_VERSION}" ]
  [ -d "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
}

@test "nvh which 4" {
  run nvh --insecure which 4
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${ARGON_VERSION}/bin/node" ]
}

@test "nvh which lts" {
  run nvh --insecure which lts
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]
}

@test "nvh run 4" {
  run nvh --insecure run 4 --version
  [ "$output" = "${ARGON_VERSION}" ]
}

@test "nvh run lts" {
  run nvh --insecure run lts --version
  [ "$output" = "${LTS_VERSION}" ]
}

@test "nvh exec 4 node" {
  run nvh --insecure exec 4 node --version
  [ "$output" = "${ARGON_VERSION}" ]
}

@test "nvh exec 4 npm" {
  run nvh --insecure exec 4 npm --version
  [ "$output" = "2.15.11" ]
}

@test "nvh exec lts" {
  run nvh --insecure exec lts node --version
  [ "$output" = "${LTS_VERSION}" ]
}
