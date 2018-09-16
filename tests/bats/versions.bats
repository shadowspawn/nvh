#!/usr/bin/env bats

# Get the current values for labels and codenames, like LTS_VERSION
load ../export_test_versions

# labels

@test "lsr lts" {
  run nvh --insecure ls-remote lts
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LTS_VERSION}" ]
}

@test "lsr latest" {
  run nvh --insecure ls-remote latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LATEST_VERSION}" ]
}

@test "lsr current" {
  run nvh --insecure ls-remote current
  [ "${status}" -eq "0" ]
  [ "${output}" = "${LATEST_VERSION}" ]
}

# # codenames

@test "n=1 lsr argon" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote argon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${ARGON_VERSION}" ]
}

@test "n=1 lsr boron" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote boron
  [ "${status}" -eq "0" ]
  [ "${output}" = "${BORON_VERSION}" ]
}

@test "n=1 lsr carbon" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote carbon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

# # partial version

@test "n=1 lsr 8" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote 8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "n=1 lsr v8" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote v8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "lsr 6.2 # multiple matches" {
  run nvh --insecure ls-remote 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "Listing remote... Displaying 20 matches (use --all to see all)." ]
  [ "${lines[1]}" = "v6.2.2" ]
  [ "${lines[2]}" = "v6.2.1" ]
  [ "${lines[3]}" = "v6.2.0" ]
}

# Checking does not match 8.11
@test "n=1 lsr v8.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote v8.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v8.1.4" ]
}

@test "lsr 6.2.1" {
  run nvh --insecure ls-remote 6.2.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.2.1" ]
}

@test "lsr v6.2.1" {
  run nvh --insecure ls-remote v6.2.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.2.1" ]
}

# Nightly

@test "n=1 lsr nightly" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 lsr nightly/" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 lsr nightly/latest" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/latest
  [ "${status}" -eq "0" ]
  [ "${output}" = "${NIGHTLY_LATEST_VERSION}" ]
}

@test "n=1 lsr nightly/v10.8.1-nightly201808 # partial match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/v10.8.1-nightly201808
  [ "${status}" -eq "0" ]
  [ "${output}" = "v10.8.1-nightly2018081382830a809b" ]
}

@test "n=1 lsr nightly/6" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/6
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.11.1-nightly20170607f7ca483d68" ]
}

# Numeric match should not find v7.10.1-nightly2017050369a8053e8a
@test "n=1 lsr nightly/v7.1 # numeric match" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/v7.1
  [ "${status}" -eq "0" ]
  [ "${output}" = "v7.1.1-nightly201611093daf11635d" ]
}

@test "lsr nightly/v6.10.3-nightly2017040479546c0b5a # exact" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/v6.10.3-nightly2017040479546c0b5a
  [ "${status}" -eq "0" ]
  [ "${output}" = "v6.10.3-nightly2017040479546c0b5a" ]
}
