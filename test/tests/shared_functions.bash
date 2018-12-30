#!/usr/bin/env bash


# unset the nvh environment variables so tests running from known state.
# Globals:
#   lots

function unset_nvh_env(){
  unset NVH_PREFIX
  unset NVH_NODE_MIRROR
  unset NVH_NODE_DOWNLOAD_MIRROR
  unset NVH_MAX_REMOTE_MATCHES
}


# Create temporary dir and configure nvh to use it.
# Globals:
#   TMP_PREFIX_DIR
#   NVH_PREFIX
#   PATH

function setup_tmp_prefix() {
  TMP_PREFIX_DIR="$(mktemp -d)"
  [ -d "${TMP_PREFIX_DIR}" ] || exit 2
  # return a safer variable to `rm -rf` later than N_PREFIX
  export TMP_PREFIX_DIR

  export NVH_PREFIX="${TMP_PREFIX_DIR}"
  export PATH="${NVH_PREFIX}/bin:${PATH}"
}


# display_remote_version <version>
# Limited support for using index.tab to resolve version into a number.
# Return version number, including leading v.

function display_remote_version() {
  # ToDo: support NODE_MIRROR

  local fetch
  if command -v curl &> /dev/null; then
    fetch="curl --silent --location --fail --insecure"
  else
    # insecure to match current n implementation
    fetch="wget -q -O- --no-check-certificate"
  fi

  local match='xxx'
  local mirror="https://nodejs.org/dist"
  if [[ "$1" = "lts" ]]; then
    match='[^-]$'
  elif [[ "$1" = "latest" ]]; then
    match='.'
  elif [[ "$1" = "nightly" ]]; then
    match='.'
    local mirror="https://nodejs.org/download/nightly"
  fi

  # Using temporary variable as curl complains if pipe closes early (e.g. head).
  # (Not filtering for platform yet.)
  local versions
  versions="$(${fetch} "${mirror}/index.tab" | tail -n +2 | grep -E "${match}" | cut -f -1)"
  echo "${versions}" | head -n 1
}
