#!/bin/sh
# vi: et sts=2 sw=2

for i in *; do
  # Obviously, we want to avoid stowing the script itself
  if !(echo "$i" | grep -q $(basename "$0")); then
    stow -R $i
  fi
done
