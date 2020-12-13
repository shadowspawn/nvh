#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'


# auto

function setup_file() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/nvh/test/version-resolve-auto-engine"
  mkdir -p "${MY_DIR}"

  # Need a version of node and npx available for reading package.json
  export NVH_PREFIX="${MY_DIR}"
  export PATH="${MY_DIR}/bin:${PATH}"
  nvh install lts

  # Output looks likes:
  ##        found : package.json
  ##         read : 101.0.1
  ## v101.0.1

  # Output looks likes:
  ##        found : package.json
  ##       read : 4.8.2 - 4.8.4
  ##  resolving : 4.8.2 - 4.8.4
  ## v4.8.4
}

function setup() {
  rm -f "${MY_DIR}/package.json"
}

function teardown_file() {
  rm -rf "${MY_DIR}"
}

function write_engine() {
  echo '{ "engines" : { "node" : "'"$1"'" } }' > package.json
}

@test "setupAll for auto-engine # (1 install)" {
  # Dummy test so setupAll displayed while running first setup
}

@test "auto engine, 104.0.1" {
  cd "${MY_DIR}"
  write_engine "103.0.1"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v103.0.1"
}

@test "auto engine, v104.0.2" {
  cd "${MY_DIR}"
  write_engine "v104.0.2"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v104.0.2"
}

@test "auto engine, =104.0.3" {
  cd "${MY_DIR}"
  write_engine "=103.0.3"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v103.0.3"
}

@test "auto engine, =v104.0.4" {
  cd "${MY_DIR}"
  write_engine "=v104.0.4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v104.0.4"
}

@test "auto engine, >1" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  write_engine ">1"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "${TARGET_VERSION}"
}

@test "auto engine, >=2" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  write_engine ">=2"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "${TARGET_VERSION}"
}

@test "auto engine, 8" {
  cd "${MY_DIR}"
  write_engine "8"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, 8.x" {
  cd "${MY_DIR}"
  write_engine "8.x"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, 8.X" {
  cd "${MY_DIR}"
  write_engine "8.X"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, 8.*" {
  cd "${MY_DIR}"
  write_engine "8.*"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, ~8.11.0" {
  cd "${MY_DIR}"
  write_engine "~8.11.0"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.4"
}

@test "auto engine, ~8.11" {
  cd "${MY_DIR}"
  write_engine "~8.11"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.4"
}

@test "auto engine, ~8" {
  cd "${MY_DIR}"
  write_engine "~8"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, ^8.11.0" {
  cd "${MY_DIR}"
  write_engine "^8.11.0"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, ^8.x" {
  cd "${MY_DIR}"
  write_engine "^8.x"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.17.0"
}

@test "auto engine, subdir" {
  cd "${MY_DIR}"
  write_engine "8.11.2"
  mkdir -p sub-engine
  cd sub-engine
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.2"
}

@test "auto engine (semver), <8.12" {
  cd "${MY_DIR}"
  write_engine "<8.12"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.4"
}

@test "auto engine (semver), 8.11.1 - 8.11.3" {
  cd "${MY_DIR}"
  write_engine "8.11.1 - 8.11.3"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.3"
}

@test "auto engine (semver), >8.1 <8.12 || >2.1 <3.4" {
  cd "${MY_DIR}"
  write_engine ">8.1 <8.12 || >2.1 <3.4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  assert_line "v8.11.4"
}
