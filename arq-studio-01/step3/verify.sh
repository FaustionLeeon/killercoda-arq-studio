#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd laura >/dev/null || fail "Todavía no existe el usuario laura."
home="$(getent passwd laura | cut -d: -f6)"
[ "$home" = "/home/laura" ] || fail "El HOME registrado de laura debe ser /home/laura."
[ -d /home/laura ] || fail "Falta el directorio /home/laura."
[ "$(stat -c '%U' /home/laura)" = "laura" ] || fail "/home/laura no pertenece a laura."
[ /home/laura != /home/pablo ] || fail "Laura y Pablo no pueden compartir el mismo HOME."

echo "✅ Laura tiene una cuenta y un perfil independientes."

