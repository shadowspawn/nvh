#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

function setup() {
  unset_nvh_env
  setup_tmp_prefix
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


@test "nvh ls # just plain node" {
  # KISS and just make folders rather than do actual installs
  mkdir -p "${NVH_PREFIX}/nvh/versions/node/v4.9.1"
  mkdir -p "${NVH_PREFIX}/nvh/versions/node/v10.15.0"

  local output=$(nvh ls)
  assert_equal "${output}" "node/v4.9.1
node/v10.15.0"
}


@test "nvh list # mixed node and nightly" {
  local NIGHTLY_VERSION="v12.0.0-nightly201812104aabd7ed64"
  # KISS and just make folders rather than do actual installs
  mkdir -p "${NVH_PREFIX}/nvh/versions/nightly/${NIGHTLY_VERSION}"
  mkdir -p "${NVH_PREFIX}/nvh/versions/node/v10.15.0"

  local output=$(nvh list)
  assert_equal "${output}" "nightly/${NIGHTLY_VERSION}
node/v10.15.0"
}

