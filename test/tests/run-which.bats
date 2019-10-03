#!/usr/bin/env bats

load shared-functions

function setup() {
  unset_nvh_env
  # fixed directory so can reuse the two installs
  export NVH_PREFIX="${TMPDIR:-/tmp}/nvh/test/run-which"
  # beforeAll
  # See https://github.com/bats-core/bats-core/issues/39
  if [[ "${BATS_TEST_NUMBER}" -eq 1 ]] ; then
    # Using --preserve to speed install, as only care about the cached versions.
    nvh install --preserve 4.9.1
    nvh install --preserve lts
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
  [ -d "${NVH_PREFIX}/nvh/versions/node/v4.9.1" ]
}


# nvh which

@test "nvh which 4" {
  run nvh which 4
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node" ]
}


@test "nvh which v4.9.1" {
  run nvh which v4.9.1
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node" ]
}


@test "nvh which argon" {
  run nvh which argon
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node" ]
}


@test "nvh which lts" {
  run nvh which lts
  local LTS_VERSION="$(display_remote_version lts)"
  [ "$status" -eq 0 ]
  [ "$output" = "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node" ]
}


# nvh run

@test "nvh run 4" {
  run nvh run 4 --version
  [ "$status" -eq 0 ]
  [ "$output" = "v4.9.1" ]
}


@test "nvh run lts" {
  run nvh run lts --version
  local LTS_VERSION="$(display_remote_version lts)"
  [ "$status" -eq 0 ]
  [ "$output" = "${LTS_VERSION}" ]
}


# nvh exec

@test "nvh exec v4.9.1 node" {
  run nvh exec v4.9.1 node --version
  [ "$status" -eq 0 ]
  [ "$output" = "v4.9.1" ]
}


@test "nvh exec 4 npm" {
  run nvh exec 4 npm --version
  [ "$status" -eq 0 ]
  [ "$output" = "2.15.11" ]
}


@test "nvh exec lts" {
  run nvh exec lts node --version
  local LTS_VERSION="$(display_remote_version lts)"
  [ "$status" -eq 0 ]
  [ "$output" = "${LTS_VERSION}" ]
}
