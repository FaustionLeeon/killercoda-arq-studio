#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd miguel >/dev/null || fail "Todavía no existe el usuario miguel."
[ -d /home/miguel ] || fail "Debe conservarse /home/miguel."
[ "$(stat -c '%U' /home/miguel)" = "miguel" ] || fail "/home/miguel no pertenece a miguel."
status="$(passwd -S miguel 2>/dev/null | awk '{print $2}')"
[ "$status" = "L" ] || fail "La contraseña de miguel todavía no está bloqueada."

echo "✅ Miguel está bloqueado y sus datos se conservan."

