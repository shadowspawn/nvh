#!/usr/bin/env bats

load shared_functions

function setup() {
  unset_nvh_env
  setup_tmp_prefix
}

function teardown() {
  rm -rf "${TMP_PREFIX_DIR}"
}


# Using 6.11 so different than non-mirror and will not change

@test "NVH_NODE_MIRROR=https://npm.taobao.org/mirrors/node nvh install 6.11" {
  NVH_NODE_MIRROR="https://npm.taobao.org/mirrors/node" nvh install 6.11

  [ -d "${NVH_PREFIX}/nvh/versions/node/v6.11.5" ]
  [ -f "${NVH_PREFIX}/bin/node" ]
  run "${NVH_PREFIX}/bin/node" --version
  [ "$output" = "v6.11.5" ]
}
