#!/bin/bash
set -eu

function cleanup {
  echo "Received exit code, stopping bird if it's running."
  [ $(pgrep -f '/usr/sbin/bird -c /etc/bird.conf') ] && birdc down
  exit 0
}

trap cleanup EXIT

echo "Running health check before starting bird:"

while true; do
  RET=$(/bin/sh /usr/local/bin/bgp-healthcheck.sh &>/dev/null ; echo $?)
  INTERVAL=${BGP_CHECK_INTERVAL:-5s}
  if [ $RET == "0" ]; then
    if [ $(pgrep -f '/usr/sbin/bird -c /etc/bird.conf') ]; then
      echo "Health check passed and bird is running."
    else
      echo "Health check passed, starting bird."
      /usr/sbin/bird -c /etc/bird.conf
    fi
  else
    if [ $(pgrep -f '/usr/sbin/bird -c /etc/bird.conf') ]; then
      echo "Health check failed and bird is running, stopping bird."
      birdc down
    else
      echo "Health check failed and bird is down."
    fi
  fi
  sleep $INTERVAL
done

