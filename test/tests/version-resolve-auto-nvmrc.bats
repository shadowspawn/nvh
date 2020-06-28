#!/usr/bin/env bats

# Note: full semver is resolved without lookup, so can use arbitrary versions for testing like 999.999.999

load shared-functions


# auto

function setup() {
  unset_nvh_env
  tmpdir="${TMPDIR:-/tmp}"
  export MY_DIR="${tmpdir}/nvh/test/version-resolve-auto-nvmrc"
  mkdir -p "${MY_DIR}"
  rm -f "${MY_DIR}/.nvmrc"

  # Output looks likes:
  ##        found : .nvmrc
  ##         read : 101.0.1
  ## v101.0.1
  # so payload to check is on line #2.
  PAYLOAD_LINE=2
}

@test "auto .nvmrc, numeric" {
  cd "${MY_DIR}"
  printf "102.0.1\n" > .nvmrc
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v102.0.1" ]
}

@test "auto .nvmrc, numeric with leading v" {
  cd "${MY_DIR}"
  printf "v102.0.2\n" > .nvmrc
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v102.0.2" ]
}

@test "auto .nvmrc, node" {
  local TARGET_VERSION="$(display_remote_version latest)"
  cd "${MY_DIR}"
  printf "node\n" > .nvmrc
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "${TARGET_VERSION}" ]
}

@test "auto .nvmrc, lts/*" {
  local TARGET_VERSION="$(display_remote_version lts)"
  cd "${MY_DIR}"
  printf "lts/*\n" > .nvmrc
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "${TARGET_VERSION}" ]
}

@test "auto .nvmrc, lts/argon" {
  local TARGET_VERSION="$(display_remote_version lts)"
  cd "${MY_DIR}"
  printf "lts/argon\n" > .nvmrc
  run nvh NVH_TEST_DISPLAY_LATEST_RESOLVED_VERSION auto
  [ "$status" -eq 0 ]
  [ "${lines[${PAYLOAD_LINE}]}" = "v4.9.1" ]
}
