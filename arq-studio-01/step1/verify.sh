#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd pablo >/dev/null || fail "Todavía no existe el usuario pablo."

home="$(getent passwd pablo | cut -d: -f6)"
[ "$home" = "/home/pablo" ] || fail "El HOME registrado de pablo debe ser /home/pablo."
[ -d /home/pablo ] || fail "Falta el directorio /home/pablo."
[ "$(stat -c '%U' /home/pablo)" = "pablo" ] || fail "/home/pablo no pertenece a pablo."

echo "✅ Pablo tiene cuenta y HOME propio."

