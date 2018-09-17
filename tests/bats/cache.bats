#!/usr/bin/env bats

load ../export_test_versions

g_tmp=

function setup() {
  g_tmp_prefix="$(mktemp -d)"
  export NVH_PREFIX="${g_tmp_prefix}"
  mkdir -p "${g_tmp_prefix}/nvh/versions/node/${ARGON_VERSION}"
  mkdir -p "${g_tmp_prefix}/nvh/versions/node/${LTS_VERSION}"
  mkdir -p "${g_tmp_prefix}/nvh/versions/nightly/${NIGHTLY_LATEST_VERSION}"
}

function teardown() {
  rm -rf "${g_tmp_prefix}"
}

@test "nvh cache ls # albeit cache ls is undocumented" {
  run nvh cache ls
  [ "${lines[0]}" = "nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ "${lines[1]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[2]}" = "node/${LTS_VERSION}" ]
  [ "${lines[3]}" = "" ]
}

@test "nvh rm lts" {
  nvh --insecure rm lts

  run nvh cache ls
  [ "${lines[0]}" = "nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ "${lines[1]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[2]}" = "" ]
}

@test "nvh remove nightly/${NIGHTLY_LATEST_VERSION}" {
  nvh --insecure remove "nightly/${NIGHTLY_LATEST_VERSION}"

  run nvh cache ls
  [ "${lines[0]}" = "node/${ARGON_VERSION}" ]
  [ "${lines[1]}" = "node/${LTS_VERSION}" ]
  [ "${lines[2]}" = "" ]
}

@test "nvh cache rm 4 # albeit cache rm is undocumented" {
  nvh --insecure cache rm 4

  run nvh cache ls
  [ "${lines[0]}" = "nightly/${NIGHTLY_LATEST_VERSION}" ]
  [ "${lines[1]}" = "node/${LTS_VERSION}" ]
  [ "${lines[2]}" = "" ]
}

@test "nvh cache clear" {
  nvh --insecure cache clear

  run nvh cache ls
  [ "$output" = "" ]
}

@test "nvh cache prune" {
  # Remove fake directory and install real lts
  nvh rm "${LTS_VERSION}"
  nvh --insecure install lts
  # Modify PATH so nvh sees LTS as active version of node
  PATH="${NVH_PREFIX}/bin:${PATH}" nvh cache prune

  run nvh cache ls
  [ "${lines[0]}" = "node/${LTS_VERSION}" ]
  [ "${lines[1]}" = "" ]
}
