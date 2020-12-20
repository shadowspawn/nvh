#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

function setup() {
  unset_nvh_env
  setup_tmp_prefix
  # Faking it!
  ARGON_VERSION="v4.9.1"
  LTS_VERSION="$(display_remote_version lts)"
  NIGHTLY_VERSION="$(display_remote_version nightly)"
  mkdir -p "${NVH_PREFIX}/nvh/versions/node/${ARGON_VERSION}"
  mkdir -p "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}"
  mkdir -p "${NVH_PREFIX}/nvh/versions/nightly/${NIGHTLY_VERSION}"
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


# nvh cache ls

@test "nvh cache ls # albeit cache ls is undocumented" {
  local output=$(nvh cache ls)
  assert_equal "${output}" "nightly/${NIGHTLY_VERSION}
node/${ARGON_VERSION}
node/${LTS_VERSION}"
}


# nvh rm
## short alias, multiple, vNumeric

@test "nvh rm lts v4.9.1" {
  nvh rm lts v4.9.1

  local output=$(nvh cache ls)
  assert_equal "${output}" "nightly/${NIGHTLY_VERSION}"
}


## long alias, nightly explicit

@test "nvh remove nightly/${NIGHTLY_VERSION}" {
  nvh remove "nightly/${NIGHTLY_VERSION}"

  local output=$(nvh cache ls)
  assert_equal "${output}" "node/${ARGON_VERSION}
node/${LTS_VERSION}"
}


## cache flavour, partial numeric

@test "nvh cache rm 4 # albeit cache rm is undocumented" {
  nvh cache rm 4

  local output=$(nvh cache ls)
  assert_equal "${output}" "nightly/${NIGHTLY_VERSION}
node/${LTS_VERSION}"
}


# nvh cache clear

@test "nvh cache clear" {
  nvh cache clear

  local output=$(nvh cache ls)
  assert_equal "${output}" ""
}


# nvh cache prune

@test "nvh cache prune # (1 install)" {
  # Remove fake directory and install real lts
  nvh rm "${LTS_VERSION}"
  nvh install lts
  nvh cache prune

  local output=$(nvh cache ls)
  assert_equal "${output}" "node/${LTS_VERSION}"
}
