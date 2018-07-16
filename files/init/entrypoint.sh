#!/bin/bash
set -eu

echo "Running health check before starting bird:"
RET=$(/bin/sh /usr/local/bin/bgp-healthcheck.sh &>/dev/null ; echo $?)

if [ $RET == "0" ]; then
  echo "Health check passed, starting bird."
  /usr/sbin/bird -c /etc/bird.conf -f
else
  echo "Health check failed, dieing."
  exit 1
fi
