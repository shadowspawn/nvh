#!/usr/bin/env bash

# These are the versions installed and hence cached by proxy-build.

nvh --insecure install 4.9.1
nvh --insecure install nightly/latest
nvh --insecure install lts
NVH_NODE_MIRROR=https://npm.taobao.org/mirrors/node nvh --insecure install 6.11
