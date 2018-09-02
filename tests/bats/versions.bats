#!/usr/bin/env bats

function setup() {
    # Use caching proxy instead of hammering node server
    export https_proxy=localhost:8080
}

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

@test "lsr argon" {
  run nvh --insecure ls-remote argon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${ARGON_VERSION}" ]
}

@test "lsr boron" {
  run nvh --insecure ls-remote boron
  [ "${status}" -eq "0" ]
  [ "${output}" = "${BORON_VERSION}" ]
}

@test "lsr carbon" {
  run nvh --insecure ls-remote carbon
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

# # release streams

@test "lsr 8.x" {
  run nvh --insecure ls-remote 8.x
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "lsr v8.x" {
  run nvh --insecure ls-remote v8.x
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

# # partial version

@test "lsr 8 n=1" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote 8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "lsr v8 n=1" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote v8
  [ "${status}" -eq "0" ]
  [ "${output}" = "${CARBON_VERSION}" ]
}

@test "lsr 6.2" {
  run nvh --insecure ls-remote 6.2
  [ "${status}" -eq "0" ]
  [ "${lines[0]}" = "Listing remote... Displaying last 20 matches (use --all to see all)." ]
  [ "${lines[1]}" = "v6.2.0" ]
  [ "${lines[2]}" = "v6.2.1" ]
  [ "${lines[3]}" = "v6.2.2" ]
}

# Checking does not match 8.11
@test "lsr v8.1 n=1" {
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

# Need a way of finding expected versions!

# @test "lsr nightly n=1" {
#   NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly
#   [ "${status}" -eq "0" ]
#   [ "${output}" = "v11.0.0-nightly2018081201a160a05d" ]
# }

# @test "lsr nightly/ n=1" {
#   NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/
#   [ "${status}" -eq "0" ]
#   [ "${output}" = "v11.0.0-nightly2018081201a160a05d" ]
# }

# @test "lsr nightly/10 n=1" {
#   NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/10
#   [ "${status}" -eq "0" ]
#   [ "${output}" = "v10.8.1-nightly20180812fdeace6a02" ]
# }

# @test "lsr nightly/v10 n=1" {
#   NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/v10
#   [ "${status}" -eq "0" ]
#   [ "${output}" = "v10.8.1-nightly20180812fdeace6a02" ]
# }

@test "lsr nightly/v10.8.1-nightly201808 n=1" {
  NVH_MAX_REMOTE_MATCHES=1 run nvh --insecure ls-remote nightly/v10.8.1-nightly201808
  [ "${status}" -eq "0" ]
  [ "${output}" = "v10.8.1-nightly2018081382830a809b" ]
}
