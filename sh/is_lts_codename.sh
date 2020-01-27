#!/bin/sh

# function is_lts_codename() {
#   # https://github.com/nodejs/Release/blob/master/CODENAMES.md
#   # e.g. argon, Boron
#   [[ "$1" =~ ^([Aa]rgon|[Bb]oron|[Cc]arbon|[Dd]ubnium|[Ee]rbium|[Ff]ermium|[Gg]allium|[Hh]ydrogen|[Ii]ron)$ ]]
# }

is_lts_codename() {
  printf "%s" "$1" | grep -E '^([Aa]rgon|[Bb]oron|[Cc]arbon|[Dd]ubnium|[Ee]rbium|[Ff]ermium|[Gg]allium|[Hh]ydrogen|[Ii]ron)$' >/dev/null
}

if is_lts_codename "$1"; then
  echo lts
else
  echo not
fi
