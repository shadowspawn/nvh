#!/usr/bin/env bash


# unset the nvh environment variables so tests running from known state.
# Globals:
#   lots

function unset_nvh_env(){
  unset NVH_MAX_REMOTE_MATCHES
  unset NVH_PREFIX
  unset NVH_PRESERVE_NPM
  unset NVH_NODE_DOWNLOAD_MIRROR
  unset NVH_NODE_MIRROR
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


# Display relevant file name (third field of index.tab) for current platform.
# Based on code from nvm rather than nvh for independent approach. Simplified for just common platforms initially.
# See list on https://github.com/nodejs/nodejs-dist-indexer

function display_compatible_file_field() {
  local os="unexpected"
  case "$(uname -a)" in
    Linux\ *) os="linux" ;;
    Darwin\ *) os="osx" ;;
  esac

  local arch="unexpected"
  local uname_m
  uname_m="$(uname -m)"
  case "${uname_m}" in
    x86_64 | amd64) arch="x64" ;;
    i*86) arch="x86" ;;
    aarch64) arch="arm64" ;;
    *) arch="${uname_m}" ;;
  esac

  echo "${os}-${arch}"
}


# display_remote_version <version>
# Limited support for using index.tab to resolve version into a number.
# Return version number, including leading v.

function display_remote_version() {
  # ToDo: support NODE_MIRROR

  local fetch
  if command -v curl &> /dev/null; then
    fetch="curl --silent --location --fail"
  else
    fetch="wget -q -O-"
  fi

  local match='xxx'
  local mirror="${NVH_NODE_MIRROR:-https://nodejs.org/dist}"
  if [[ "$1" = "lts" ]]; then
    match='[^-]$'
  elif [[ "$1" = "latest" ]]; then
    match='.'
  elif [[ "$1" = "nightly" ]]; then
    match='.'
    mirror="${NVH_NODE_DOWNLOAD_MIRROR:-https://nodejs.org/download}/nightly"
  fi

  # Using awk rather than head so do not close pipe early on curl
  ${fetch} "${mirror}/index.tab" \
    | tail -n +2 \
    | grep "$(display_compatible_file_field)" \
    | grep -E "${match}" \
    | cut -f -1 \
    | awk "NR==1"
}
