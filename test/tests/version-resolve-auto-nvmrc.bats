#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'


# auto

function setup_file() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/nvh/test/version-resolve-auto-nvmrc"
  mkdir -p "${MY_DIR}"

  # Output looks likes:
  ##        found : .nvmrc
  ##         read : 101.0.1
  ## v101.0.1
}

function setup() {
  rm -f "${MY_DIR}/.nvmrc"
}

function teardown_file() {
  rm -rf "${MY_DIR}"
}

@test "auto .nvmrc, numeric" {
  cd "${MY_DIR}"
  printf "102.0.1\n" > .nvmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v102.0.1"
}

@test "auto .nvmrc, numeric with leading v" {
  cd "${MY_DIR}"
  printf "v102.0.2\n" > .nvmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v102.0.2"
}

@test "auto .nvmrc, node" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  printf "node\n" > .nvmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "${TARGET_VERSION}"
}

@test "auto .nvmrc, lts/*" {
  local TARGET_VERSION="$(display_remote_version lts)"
  cd "${MY_DIR}"
  printf "lts/*\n" > .nvmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "${TARGET_VERSION}"
}

@test "auto .nvmrc, lts/argon" {
  local TARGET_VERSION="$(display_remote_version lts)"
  cd "${MY_DIR}"
  printf "lts/argon\n" > .nvmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v4.9.1"
}

@test "auto .nvmrc, sub directory" {
  cd "${MY_DIR}"
  printf "v102.0.3\n" > .nvmrc
  mkdir -p sub-npmrc
  cd sub-npmrc
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v102.0.3"
}
