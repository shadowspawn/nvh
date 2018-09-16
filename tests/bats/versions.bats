#!/usr/bin/env bats

# Get the current values for labels and codenames, like LTS_VERSION
load ../export_test_versions

# labels

@test "nvh lsr lts" {
  run nvh --insecure lsr lts
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LTS_VERSION}" ]
}

@test "nvh ls-remote latest" {
  run nvh --insecure ls-remote latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LATEST_VERSION}" ]
}

@test "nvh list-remote current" {
  run nvh --insecure list-remote current
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LATEST_VERSION}" ]
}

# # codenames

@test "n=1 nvh lsr argon" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr argon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${ARGON_VERSION}" ]
}

@test "n=1 nvh lsr boron" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr boron
  [ "${status}" -eq "0" ]
  [ "${output}" = "${BORON_VERSION}" ]
}

@test "n=1 nvh lsr carbon" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr carbon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

# # partial version

@test "n=1 nvh lsr 8" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr 8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "n=1 nvh lsr v8" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr v8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "nvh lsr 6.2 # multiple matches with header" {
  run nvh --insecure lsr 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "Listing remote... Displaying 20 matches (use --all to see all)." ]
  [ "${lines[1]}" = "v6.2.2" ]
  [ "${lines[2]}" = "v6.2.1" ]
  [ "${lines[3]}" = "v6.2.0" ]
}

@test "n=1 nvh lsr --all 6.2 # --all, multiple matches with no header" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr --all 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "v6.2.2" ]
  [ "${lines[1]}" = "v6.2.1" ]
  [ "${lines[2]}" = "v6.2.0" ]
}

# Checking does not match 8.11
@test "n=1 nvh lsr v8.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr v8.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v8.1.4" ]
}

@test "nvh lsr 6.2.1" {
  run nvh --insecure lsr 6.2.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.2.1" ]
}

@test "nvh lsr v6.2.1" {
  run nvh --insecure lsr v6.2.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.2.1" ]
}

# Nightly

@test "n=1 nvh lsr nightly" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 nvh lsr nightly/" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 nvh lsr nightly/latest" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 nvh lsr nightly/v10.8.1-nightly201808 # partial match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/v10.8.1-nightly201808
  [ "${status}" -eq "0" ]
  [ "${output}" = "v10.8.1-nightly2018081382830a809b" ]
}

@test "n=1 nvh lsr nightly/6" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/6
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.11.1-nightly20170607f7ca483d68" ]
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 nvh lsr nightly/v7.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/v7.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v7.1.1-nightly201611093daf11635d" ]
}

@test "nvh lsr nightly/v6.10.3-nightly2017040479546c0b5a # exact" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure lsr nightly/v6.10.3-nightly2017040479546c0b5a
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.10.3-nightly2017040479546c0b5a" ]
}
