#!/usr/bin/env bash
if [ -e packages.txt ] ; then
  DEBIAN_FRONTEND=noninteractive
  while read p; do
    apt-get -y --no-install-recommends install $p
  done < packages.txt
fi
if [ -e requirements.txt ] ; then
  while read r; do
    pip install -U $r
  done < requirements.txt
fi
