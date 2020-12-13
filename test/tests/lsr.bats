#!/usr/bin/env bats

load shared-functions
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'


function setup() {
  unset_nvh_env
}


# labels

@test "nvh lsr lts" {
  local output=$(nvh lsr lts)
  assert_equal "${output}" "$(display_remote_version lts)"
}

@test "nvh ls-remote latest" {
  local output=$(nvh ls-remote latest)
  assert_equal "${output}" "$(display_remote_version latest)"
}

@test "nvh list-remote current" {
  local output=$(nvh list-remote current)
  assert_equal "${output}" "$(display_remote_version latest)"
}


# codenames

@test "n=1 nvh lsr argon" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr argon)
  assert_equal "${output}" "v4.9.1"
}

@test "n=1 nvh lsr Argon # case" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr Argon)
  assert_equal "${output}" "v4.9.1"
}


# numeric versions

@test "n=1 nvh lsr 4" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr 4)
  assert_equal "${output}" "v4.9.1"
}

@test "n=1 nvh lsr v4" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr v4)
  assert_equal "${output}" "v4.9.1"
}

@test "n=1 nvh lsr 4.9" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr 4.9)
  assert_equal "${output}" "v4.9.1"
}

@test "n=1 nvh lsr 4.9.1" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr 4.9.1)
  assert_equal "${output}" "v4.9.1"
}

@test "n=1 nvh lsr v4.9.1" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr v4.9.1)
  assert_equal "${output}" "v4.9.1"
}

@test "nvh lsr 6.2 # multiple matches with header" {
  local output=$(nvh lsr 6.2)
  assert_equal "${output}" "Listing remote... Displaying 20 matches (use --all to see all).
v6.2.2
v6.2.1
v6.2.0"
}

@test "n=1 nvh lsr --all 6.2 # --all, multiple matches with no header" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr --all 6.2)
  assert_equal "${output}" "v6.2.2
v6.2.1
v6.2.0"
}

# Checking does not match 8.11
@test "n=1 nvh lsr v8.1 # numeric match" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr v8.1)
  assert_equal "${output}" "v8.1.4"
}


# Nightly

@test "n=1 nvh lsr nightly" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly)
  assert_equal "${output}" "$(display_remote_version nightly)"
}

@test "n=1 nvh lsr nightly/" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/)
  assert_equal "${output}" "$(display_remote_version nightly)"
}

@test "n=1 nvh lsr nightly/latest" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/latest)
  assert_equal "${output}" "$(display_remote_version nightly)"
}

@test "n=1 nvh lsr nightly/v10.8.1-nightly201808 # partial match" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/v10.8.1-nightly201808)
  assert_equal "${output}" "v10.8.1-nightly2018081382830a809b"
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 nvh lsr nightly/7.1 # numeric match" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/7.1)
  assert_equal "${output}" "v7.1.1-nightly201611093daf11635d"
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 nvh lsr nightly/v7.1 # numeric match" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/v7.1)
  assert_equal "${output}" "v7.1.1-nightly201611093daf11635d"
}

@test "nvh lsr nightly/v6.10.3-nightly2017040479546c0b5a # exact" {
  local output=$(NVH_MAX_REMOTE_MATCHES=1 nvh lsr nightly/v6.10.3-nightly2017040479546c0b5a)
  assert_equal "${output}" "v6.10.3-nightly2017040479546c0b5a"
}
