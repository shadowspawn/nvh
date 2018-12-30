#!/usr/bin/env bats

load shared_functions

function setup() {
  unset_nvh_env
  setup_tmp_prefix
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


@test "nvh uninstall (of lts)" {
  nvh --insecure install lts
  [ -f "${NVH_PREFIX}/bin/node" ]
  [ -f "${NVH_PREFIX}/bin/npm" ]
  [ -f "${NVH_PREFIX}/lib/node_modules/npm/package.json" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm --insecure lts
  run find "${NVH_PREFIX}" -not -type d
  [ "${status}" -eq "0" ]
  [ "$output" = "" ]
}


@test "nvh uninstall (of nightly/latest)" {
  nvh --insecure install nightly/latest
  [ -f "${NVH_PREFIX}/bin/node" ]
  [ -f "${NVH_PREFIX}/bin/npm" ]
  [ -f "${NVH_PREFIX}/lib/node_modules/npm/package.json" ]

  # Check we get all the files if we uninstall and rm cache.
  nvh uninstall
  nvh rm --insecure nightly/latest
  run find "${NVH_PREFIX}" -not -type d
  [ "${status}" -eq "0" ]
  [ "$output" = "" ]
}
