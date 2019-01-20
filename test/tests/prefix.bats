#!/usr/bin/env bats

load shared-functions

function setup() {
  unset_nvh_env
}


@test "nvh prefix" {
  run nvh prefix
  [ "${status}" -eq "0" ]
  [ "$output" = "/usr/local" ]
}

@test "NVH_PREFIX=/xyz nvh prefix" {
  NVH_PREFIX=/xyz run nvh prefix
  [ "${status}" -eq "0" ]
  [ "$output" = "/xyz" ]
}

# Check strip trailing slash so get predictable format
@test "NVH_PREFIX=/xyz/ nvh prefix" {
  NVH_PREFIX=/xyz/ run nvh prefix
  [ "${status}" -eq "0" ]
  [ "$output" = "/xyz" ]
}
