#!/bin/sh

# function is_numeric_version() {
#   # e.g. 6, v7.1, 8.11.3
#   [[ "$1" =~ ^[v]{0,1}[0-9]+(\.[0-9]+){0,2}$ ]]
# }

is_numeric_version() {
  printf "%s" "$1" | grep -E '^v{0,1}[0-9]+(\.[0-9]+){0,2}$' >/dev/null
}

if is_numeric_version "$1"; then
  echo Numeric
else
  echo not
fi
