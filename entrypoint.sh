#!/bin/sh
set -e

ruby /usr/src/app/qbt_port_forwarder.rb
/usr/sbin/crond -f -l 8