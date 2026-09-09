#!/bin/sh
set -e

port="${PORT:-9091}"
host="${HOST:-127.0.0.1}"
gtn_addr="${GTN_ADDR:-http://localhost:8000}"

gtn_url="$gtn_addr/v1/portforward"

if [ -n "$GTN_USERNAME" ] && [ -n "$GTN_PASSWORD" ]; then
    echo "Attempting to retrieve port from Gluetun via username and password..."
    port_number=$(curl --fail --silent --show-error --user "$GTN_USERNAME:$GTN_PASSWORD" "$gtn_url" | jq '.port')
elif [ -n "$GTN_APIKEY" ]; then
    echo "Attempting to retrieve port from Gluetun via api key..."
    port_number=$(curl --fail --silent --show-error --header "X-API-Key: $GTN_APIKEY" "$gtn_url" | jq '.port')
else
    echo "Attempting to retrieve port from Gluetun without authentication..."
    port_number=$(curl --fail --silent --show-error "$gtn_url" | jq '.port')
fi

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