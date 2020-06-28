#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999

load shared-functions


# auto

function setup() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/nvh/test/version-resolve-auto-engine"
  mkdir -p "${MY_DIR}"
  rm -f "${MY_DIR}/package.json"

  # Output looks likes:
  ##        found : package.json
  ##         read : 101.0.1
  ## v101.0.1
  # so version payload is...
  PAYLOAD_SIMPLE_LINE=2

  # Output looks likes:
  ##        found : package.json
  ##       read : 4.8.2 - 4.8.4
  ##  resolving : 4.8.2 - 4.8.4
  ## v4.8.4
  # so version payload is...
  PAYLOAD_COMPLEX_LINE=3
}

function write_engine() {
  echo '{ "engines" : { "node" : "'"$1"'" } }' > package.json
}

@test "auto engine, 104.0.1" {
  cd "${MY_DIR}"
  write_engine "103.0.1"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v103.0.1" ]
}

@test "auto engine, v104.0.2" {
  cd "${MY_DIR}"
  write_engine "v104.0.2"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v104.0.2" ]
}

@test "auto engine, =104.0.3" {
  cd "${MY_DIR}"
  write_engine "=103.0.3"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v103.0.3" ]
}

@test "auto engine, =v104.0.4" {
  cd "${MY_DIR}"
  write_engine "=v104.0.4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v104.0.4" ]
}

@test "auto engine, >1" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  write_engine ">1"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "${TARGET_VERSION}" ]
}

@test "auto engine, >=2" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  write_engine ">=2"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "${TARGET_VERSION}" ]
}

@test "auto engine, 4" {
  cd "${MY_DIR}"
  write_engine "4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, 4.x" {
  cd "${MY_DIR}"
  write_engine "4.x"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, 4.X" {
  cd "${MY_DIR}"
  write_engine "4.X"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, 4.*" {
  cd "${MY_DIR}"
  write_engine "4.*"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, ~4.8.0" {
  cd "${MY_DIR}"
  write_engine "~4.8.0"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.8.7" ]
}

@test "auto engine, ~4.8" {
  cd "${MY_DIR}"
  write_engine "~4.8"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.8.7" ]
}

@test "auto engine, ~4" {
  cd "${MY_DIR}"
  write_engine "~4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, ^4.8.0" {
  cd "${MY_DIR}"
  write_engine "^4.8.0"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine, ^4.x" {
  cd "${MY_DIR}"
  write_engine "^4.x"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_SIMPLE_LINE}]}" = "v4.9.1" ]
}

@test "auto engine (semver), <4.9" {
  cd "${MY_DIR}"
  write_engine "<4.9"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_COMPLEX_LINE}]}" = "v4.8.7" ]
}

@test "auto engine (semver), 4.8.2 - 4.8.4" {
  cd "${MY_DIR}"
  write_engine "4.8.2 - 4.8.4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_COMPLEX_LINE}]}" = "v4.8.4" ]
}

@test "auto engine (semver), >4.2 <4.9 || >2.1 <3.4" {
  cd "${MY_DIR}"
  write_engine ">4.2 <4.9 || >2.1 <3.4"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_COMPLEX_LINE}]}" = "v4.8.7" ]
}
