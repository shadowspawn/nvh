#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999
# Not testing all the permutations on both files, as know they are currenly implemented using same code!

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'


# auto

function setup_file() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/nvh/test/version-resolve-auto-file"
  mkdir -p "${MY_DIR}"

  # Output looks likes:
  ##        found : .nvh-node-version
  ##         read : 101.0.1
  ## v101.0.1
}

function setup() {
  rm -f "${MY_DIR}/.nvh-node-version"
  rm -f "${MY_DIR}/.node-version"
}

function teardown_file() {
  rm -rf "${MY_DIR}"
}

@test "auto, missing file" {
  cd "${MY_DIR}"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -ne 0 ]
}

@test "auto .nvh-node-version, no eol" {
  cd "${MY_DIR}"
  printf "101.0.1" > .nvh-node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.1"
}

@test "auto .nvh-node-version, unix eol" {
  cd "${MY_DIR}"
  printf "101.0.2\n" > .nvh-node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.2"
}

@test "auto .nvh-node-version, Windows eol" {
  cd "${MY_DIR}"
  printf "101.0.3\r\n" > .nvh-node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.3"
}

@test "auto .nvh-node-version, leading v" {
  cd "${MY_DIR}"
  printf "v101.0.4\n" > .nvh-node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.4"
}

@test "auto .nvh-node-version, first line only" {
  cd "${MY_DIR}"
  printf "101.0.5\nmore text\n" > .nvh-node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.5"
}

@test "auto .nvh-node-version, from sub directory" {
  cd "${MY_DIR}"
  printf "101.0.6\nmore text\n" > .nvh-node-version
  mkdir -p sub6
  cd sub6
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.6"
}

@test "auto .node-version, partial version lookup" {
  # Check normal resolving
  cd "${MY_DIR}"
  printf "4.9\n" > .node-version
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v4.9.1"
}

@test "auto .node-version, from sub directory" {
  cd "${MY_DIR}"
  printf "101.0.7\nmore text\n" > .nvh-node-version
  mkdir -p sub7
  cd sub7
  output="$(nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto)"
  assert_equal "${output}" "v101.0.7"
}

