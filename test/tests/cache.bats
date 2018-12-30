#!/usr/bin/env bats

load shared_functions


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
  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "nightly/${NIGHTLY_VERSION}" ]
  [ "${lines[1]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[2]}" = "node/${LTS_VERSION}" ]
  [ "${lines[3]}" = "" ]
}


# nvh rm
## short alias, multiple, vNumeric

@test "nvh rm lts v4.9.1" {
  nvh --insecure rm lts v4.9.1

  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "nightly/${NIGHTLY_VERSION}" ]
  [ "${lines[1]}" = "" ]
}


## long alias, nightly explicit

@test "nvh remove nightly/${NIGHTLY_VERSION}" {
  nvh --insecure remove "nightly/${NIGHTLY_VERSION}"

  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[1]}" = "node/${LTS_VERSION}" ]
  [ "${lines[2]}" = "" ]
}


## cache flavour, partial numeric

@test "nvh cache rm 4 # albeit cache rm is undocumented" {
  nvh --insecure cache rm 4

  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "nightly/${NIGHTLY_VERSION}" ]
  [ "${lines[1]}" = "node/${LTS_VERSION}" ]
  [ "${lines[2]}" = "" ]
}


# nvh cache clear

@test "nvh cache clear" {
  nvh --insecure cache clear

  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "$output" = "" ]
}


# nvh cache prune

@test "nvh cache prune # (1 install)" {
  # Remove fake directory and install real lts
  nvh rm "${LTS_VERSION}"
  nvh --insecure install lts
  nvh cache prune

  run nvh cache ls
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "node/${LTS_VERSION}" ]
  [ "${lines[1]}" = "" ]
}
