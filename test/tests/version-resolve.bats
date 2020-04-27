#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999

load shared-functions


# auto

function setup() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/n/test/run-version-resolve"
  mkdir -p "${MY_DIR}"
}

@test "auto, missing file" {
  cd "${MY_DIR}"
  rm -f .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -ne 0 ]
}

@test "auto, no eol" {
  cd "${MY_DIR}"
  printf "101.0.1" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v101.0.1" ]
}

@test "auto, unix eol" {
  cd "${MY_DIR}"
  printf "101.0.2\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v101.0.2" ]
}

@test "auto, Windows eol" {
  cd "${MY_DIR}"
  printf "101.0.3\r\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v101.0.3" ]
}

@test "auto, leading v" {
  cd "${MY_DIR}"
  printf "v101.0.4\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v101.0.4" ]
}

@test "auto, first line only" {
  cd "${MY_DIR}"
  printf "101.0.5\nmore text\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v101.0.5" ]
}

@test "auto, lookup" {
  # Check normal resolving, which is allowed but not required for MVP .nvh-node-version
  cd "${MY_DIR}"
  printf "4.9\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "$output" = "v4.9.1" ]
}

# node support aliases

@test "display_latest_resolved_version active" {
  local TARGET_VERSION="$(display_remote_version latest)"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION active
  [ "$status" -eq 0 ]
  [ "$output" = "${TARGET_VERSION}" ]
}

@test "display_latest_resolved_version lts_active" {
  local TARGET_VERSION="$(display_remote_version lts)"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION lts_active
  [ "$status" -eq 0 ]
  [ "$output" = "${TARGET_VERSION}" ]
}

@test "display_latest_resolved_version lts_latest" {
  local TARGET_VERSION="$(display_remote_version lts)"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION lts_latest
  [ "$status" -eq 0 ]
  [ "$output" = "${TARGET_VERSION}" ]
}

@test "display_latest_resolved_version lts" {
  local TARGET_VERSION="$(display_remote_version lts)"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION lts
  [ "$status" -eq 0 ]
  [ "$output" = "${TARGET_VERSION}" ]
}

@test "display_latest_resolved_version current" {
  local TARGET_VERSION="$(display_remote_version latest)"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION current
  [ "$status" -eq 0 ]
  [ "$output" = "${TARGET_VERSION}" ]
}
