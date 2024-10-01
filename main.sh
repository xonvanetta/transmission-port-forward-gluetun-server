#!/bin/sh
set -e

port="${PORT:-9091}"
host="${HOST:-127.0.0.1}"
gtn_addr="${GTN_ADDR:-http://localhost:8000}"

port_number=$(curl --fail --silent --show-error $gtn_addr/v1/openvpn/portforwarded | jq '.port')
if [ ! "$port_number" ] || [ "$port_number" = "0" ]; then
    echo "Could not get current forwarded port from gluetun, exiting..."
    exit 1
fi

echo "Updating port to $port_number"

if transmission-remote "$host:$port" --auth "$USERNAME:$PASSWORD" -p "$port_number"; then
    echo "Successfully updated port"
else
    echo "Error: Failed to update port"
    exit 1
fi