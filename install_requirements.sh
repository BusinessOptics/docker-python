#!/usr/bin/env bash
if [ -e packages.txt ] ; then
  DEBIAN_FRONTEND=noninteractive
  cat packages.txt | apt-get -y --no-install-recommends install
fi
# Allows apps to install custom stuff before pip runs.
if [ -e pre-pip.sh ] ; then
  ./pre-pip.sh
fi
if [ -e requirements.txt ] ; then
  while read r; do
    pip install -U $r
  done < requirements.txt
fi
