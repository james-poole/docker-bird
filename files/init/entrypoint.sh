#!/bin/bash
set -eu

RET=$(/bin/sh /usr/local/bin/bgp-healthcheck.sh &>/dev/null ; echo $?)

if [ $RET == "0" ]; then
  /usr/sbin/bird -c /etc/bird.conf -f
else
  exit 1
fi
