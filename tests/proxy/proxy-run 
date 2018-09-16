#!/usr/bin/env bash

echo ""
echo "To make use of proxy server: export https_proxy=\"$(hostname):8080\""
echo ""
echo "Launching proxy server..."
mitmdump --server-replay-nopop --server-replay proxy~~.dump
