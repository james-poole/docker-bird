#!/bin/bash
set -eu

RET=$(/bin/sh /usr/local/bin/bgp-healthcheck.sh &>/dev/null ; echo $?)

if [ $RET == "0" ]; then
  for inf in $(find /tmp/loopback-aliases/ -type f -name "ifcfg-lo.[0-9]*" -printf "%f\n") ; do
    inf_alias=$(echo $inf | sec 's/\./:/g')
    cp /tmp/loopback-aliases/$inf /etc/sysconfig/network-scripts/$inf_alias
    echo "Starting $inf_alias"
    ifup $inf_alias
  done
  /usr/sbin/bird -c /etc/bird.conf -f
else
  exit 1
fi
