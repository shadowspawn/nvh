#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

function setup() {
  unset_nvh_env
}


@test "nvh prefix" {
  output="$(nvh prefix)"
  assert_equal "$output" "/usr/local"
}

@test "NVH_PREFIX=/xyz nvh prefix" {
  output="$(NVH_PREFIX=/xyz nvh prefix)"
  assert_equal "$output" "/xyz"
}

# Check strip trailing slash so get predictable format
@test "NVH_PREFIX=/xyz/ nvh prefix" {
  output="$(NVH_PREFIX=/xyz/ nvh prefix)"
  assert_equal "$output" "/xyz"
}
