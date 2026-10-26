#!/usr/bin/env bash
set -u

mkdir -p /var/log
if /opt/airmur04/bootstrap.sh >/var/log/airmur04-bootstrap.log 2>&1; then
  touch /var/lib/airmur04-ready
else
  status=$?
  printf '%s\n' "$status" >/var/lib/airmur04-failed
  exit "$status"
fi

