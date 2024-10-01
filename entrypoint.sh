#!/bin/sh
set -e

_term() {
  echo "SIGTERM signal received, shutdown in progress..."
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

while ! ./main.sh; do
  echo "main.sh failed with a non-zero exit code. Retrying..."
  sleep 2
done

/usr/sbin/crond -f -l 8 &
wait "$!"