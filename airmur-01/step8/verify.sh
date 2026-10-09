#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

[ "$(id -u root)" -eq 0 ] || fail "Algo muy raro ha pasado con root."
getent group sudo >/dev/null || fail "No existe el grupo especial sudo."
id -nG raul | tr ' ' '\n' | grep -qx sistemas || fail "Raúl ha perdido su grupo sistemas."
id -nG raul | tr ' ' '\n' | grep -qx sudo || fail "Raúl todavía no pertenece a sudo."

echo "✅ Ya distingues usuarios normales de usuarios y grupos privilegiados."
