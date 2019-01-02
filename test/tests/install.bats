#!/usr/bin/env bats

load shared-functions

function setup() {
  unset_nvh_env
  setup_tmp_prefix
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


@test "nvh install lts" {
  nvh install lts
  local LTS_VERSION="$(display_remote_version lts)"
  [ -d "${NVH_PREFIX}/nvh/versions/node/${LTS_VERSION}" ]
  [ -f "${NVH_PREFIX}/bin/node" ]

  run "${NVH_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]
}

# mostly --preserve, but also variations with i/install and lts/numeric
@test "nvh i 4.9.1; nvh --preserve install lts # (2 installs)" {
  local ARGON_VERSION="v4.9.1"
  local ARGON_NPM_VERSION="2.15.11"
  local LTS_VERSION="$(display_remote_version lts)"

  nvh i ${ARGON_VERSION}
  run "${NVH_PREFIX}/bin/node" --version
  [ "$output" = "${ARGON_VERSION}" ]
  run "${NVH_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]

  nvh --preserve install lts
  run "${NVH_PREFIX}/bin/node" --version
  [ "$output" = "${LTS_VERSION}" ]
  # preserved npm version
  run "${NVH_PREFIX}/bin/npm" --version
  [ "$output" = "${ARGON_NPM_VERSION}" ]
}

@test "nvh install nightly" {
  local NIGHTLY_VERSION="$(display_remote_version nightly)"

  nvh install nightly
  [ -d "${NVH_PREFIX}/nvh/versions/nightly/${NIGHTLY_VERSION}" ]
  [ -f "${NVH_PREFIX}/bin/node" ]

  run "${NVH_PREFIX}/bin/node" --version
  [ "$output" = "${NIGHTLY_VERSION}" ]
}

