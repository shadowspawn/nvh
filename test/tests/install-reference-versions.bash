#!/usr/bin/env bash

# These are the versions installed and hence cached by proxy-build.

nvh install 4.9.1
nvh install nightly/latest
nvh install lts
NVH_NODE_MIRROR=https://npm.taobao.org/mirrors/node nvh install 6.11
