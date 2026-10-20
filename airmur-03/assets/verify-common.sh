#!/bin/bash
# Biblioteca común de los verificadores AIRMUR 03.
set -u

STATE_DIR=/var/lib/airmur03
failures=0

ok() {
  printf '✅ %s\n' "$1"
}

bad() {
  printf '❌ %s\n' "$1"
  failures=$((failures + 1))
}

check() {
  local label=$1
  shift
  if "$@" >/dev/null 2>&1; then
    ok "$label"
  else
    bad "$label"
  fi
}

contains() {
  local label=$1 needle=$2
  shift 2
  if "$@" 2>/dev/null | grep -Fqi -- "$needle"; then
    ok "$label"
  else
    bad "$label"
  fi
}

mark_and_finish() {
  local mission=$1 points=$2 criterion=$3
  echo
  if [ "$failures" -ne 0 ]; then
    echo "MISIÓN $mission NO SUPERADA: faltan $failures requisito(s)."
    echo "Corrige únicamente los elementos marcados con ❌ y vuelve a pulsar CHECK."
    exit 1
  fi
  install -d -m 0700 "$STATE_DIR"
  printf '%s\n' "$points" > "$STATE_DIR/mision${mission}.aprobada"
  chmod 0600 "$STATE_DIR/mision${mission}.aprobada"
  echo "MISIÓN $mission SUPERADA — $criterion — $(printf '%d.%d' $((points / 10)) $((points % 10)))/10.0 puntos."
  exit 0
}

samdb=/var/lib/samba/private/sam.ldb
base_dn='DC=ad,DC=airmur,DC=test'
