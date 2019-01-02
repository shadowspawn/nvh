#!/usr/bin/env bats

load shared-functions


function setup() {
  unset_nvh_env
}


# labels

@test "nvh lsr lts" {
  run nvh lsr lts
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version lts)" ]
}

@test "nvh ls-remote latest" {
  run nvh ls-remote latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version latest)" ]
}

@test "nvh list-remote current" {
  run nvh list-remote current
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version latest)" ]
}


# codenames

@test "n=1 nvh lsr argon" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr argon
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "n=1 nvh lsr Argon # case" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr Argon
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}


# numeric versions

@test "n=1 nvh lsr 4" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr 4
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "n=1 nvh lsr v4" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr v4
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "n=1 nvh lsr 4.9" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr 4.9
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "n=1 nvh lsr 4.9.1" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr 4.9.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "n=1 nvh lsr v4.9.1" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr v4.9.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v4.9.1" ]
}

@test "nvh lsr 6.2 # multiple matches with header" {
  run nvh lsr 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "Listing remote... Displaying 20 matches (use --all to see all)." ]
  [ "${lines[1]}" = "v6.2.2" ]
  [ "${lines[2]}" = "v6.2.1" ]
  [ "${lines[3]}" = "v6.2.0" ]
  [ "${lines[4]}" = "" ]
}

@test "n=1 nvh lsr --all 6.2 # --all, multiple matches with no header" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr --all 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "v6.2.2" ]
  [ "${lines[1]}" = "v6.2.1" ]
  [ "${lines[2]}" = "v6.2.0" ]
  [ "${lines[3]}" = "" ]
}

# Checking does not match 8.11
@test "n=1 nvh lsr v8.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr v8.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v8.1.4" ]
}


# Nightly

@test "n=1 nvh lsr nightly" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version nightly)" ]
}

@test "n=1 nvh lsr nightly/" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version nightly)" ]
}

@test "n=1 nvh lsr nightly/latest" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "$(display_remote_version nightly)" ]
}

@test "n=1 nvh lsr nightly/v10.8.1-nightly201808 # partial match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/v10.8.1-nightly201808
  [ "${status}" -eq "0" ]
  [ "${output}" = "v10.8.1-nightly2018081382830a809b" ]
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 nvh lsr nightly/7.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/7.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v7.1.1-nightly201611093daf11635d" ]
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 nvh lsr nightly/v7.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/v7.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v7.1.1-nightly201611093daf11635d" ]
}

@test "nvh lsr nightly/v6.10.3-nightly2017040479546c0b5a # exact" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh lsr nightly/v6.10.3-nightly2017040479546c0b5a
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.10.3-nightly2017040479546c0b5a" ]
}
