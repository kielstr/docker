#!/bin/bash -e

if [[ $# != 1 ]]; then
  echo usage: $0 filename 1>&2
  exit 1;
fi

cp "$1" "$1.tmp"
tr '\r' '\n' < "$1.tmp" > "$1"
rm -f "$1.tmp"
