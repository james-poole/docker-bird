#!/bin/bash
set -eu

for inf in $(find /etc/sysconfig/network-scripts/ -type f -name "ifcfg-lo\:[0-9]*" -printf "%f\n") ; do
  echo "Starting $inf"
  ifup $inf
done

/usr/sbin/bird -c /etc/bird.conf -f
