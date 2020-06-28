#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999

load shared-functions


# auto

function setup() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/n/test/version-resolve-auto-file"
  mkdir -p "${MY_DIR}"
  rm -f "${MY_DIR}/.nvh-node-version"

  # Output looks likes:
  ##        found : .nvh-node-version
  ##         read : 101.0.1
  ## v101.0.1
  # so payload to check is on line #2.
  PAYLOAD_LINE=2
}

@test "auto, missing file" {
  cd "${MY_DIR}"
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -ne 0 ]
}

@test "auto, no eol" {
  cd "${MY_DIR}"
  printf "101.0.1" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v101.0.1" ]
}

@test "auto, unix eol" {
  cd "${MY_DIR}"
  printf "101.0.2\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v101.0.2" ]
}

@test "auto, Windows eol" {
  cd "${MY_DIR}"
  printf "101.0.3\r\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v101.0.3" ]
}

@test "auto, leading v" {
  cd "${MY_DIR}"
  printf "v101.0.4\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v101.0.4" ]
}

@test "auto, first line only" {
  cd "${MY_DIR}"
  printf "101.0.5\nmore text\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v101.0.5" ]
}

@test "auto, partial version lookup" {
  # Check normal resolving, which is allowed but not required for MVP .nvh-node-version
  cd "${MY_DIR}"
  printf "4.9\n" > .nvh-node-version
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v4.9.1" ]
}
