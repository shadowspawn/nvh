#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

function setup() {
  unset_nvh_env
  setup_tmp_prefix
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


@test "nvh uninstall (of lts)" {
  nvh install lts
  [ -f "${NVH_PREFIX}/bin/node" ]
  [ -f "${NVH_PREFIX}/bin/npm" ]
  [ -f "${NVH_PREFIX}/lib/node_modules/npm/package.json" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm lts
  output="$(find "${NVH_PREFIX}" -not -type d)"
  assert_equal "$output" ""
}


@test "nvh uninstall (of nightly/latest)" {
  nvh install nightly/latest
  [ -f "${NVH_PREFIX}/bin/node" ]
  [ -f "${NVH_PREFIX}/bin/npm" ]
  [ -f "${NVH_PREFIX}/lib/node_modules/npm/package.json" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm nightly/latest
  run find "${NVH_PREFIX}" -not -type d
  assert_equal "$output" ""
}
