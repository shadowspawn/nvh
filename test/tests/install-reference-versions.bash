#!/usr/bin/env bash

# These are the versions installed and hence cached by proxy-build.

# Using --preserve to speed install, as only care about the download.

nvh install --preserve 4.9.1
nvh install --preserve nightly/latest
nvh install --preserve lts
NVH_NODE_MIRROR=https://npm.taobao.org/mirrors/node nvh install --preserve 6.11
