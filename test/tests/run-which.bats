#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

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
  local output=$(nvh which 4)
  assert_equal "$output" "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node"
}


@test "nvh which v4.9.1" {
  local output=$(nvh which v4.9.1)
  assert_equal "$output" "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node"
}


@test "nvh which argon" {
  local output=$(nvh which argon)
  assert_equal "$output" "${NVH_PREFIX}/nvh/versions/node/v4.9.1/bin/node"
}


@test "nvh which lts" {
  local output=$(nvh which lts)
  local LTS_VERSION="$(display_remote_version lts)"
  assert_equal "$output" "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}/bin/node"
}


# nvh run

@test "nvh run 4" {
  local output=$(nvh run 4 --version)
  assert_equal "$output" "v4.9.1"
}


@test "nvh run lts" {
  local output=$(nvh run lts --version)
  local LTS_VERSION="$(display_remote_version lts)"
  assert_equal "$output" "${LTS_VERSION}"
}


# nvh exec

@test "nvh exec v4.9.1 node" {
  local output=$(nvh exec v4.9.1 node --version)
  assert_equal "$output" "v4.9.1"
}


@test "nvh exec 4 npm" {
  local output=$(nvh exec 4 npm --version)
  assert_equal "$output" "2.15.11"
}


@test "nvh exec lts" {
  local output=$(nvh exec lts node --version)
  local LTS_VERSION="$(display_remote_version lts)"
  assert_equal "$output" "${LTS_VERSION}"
}
