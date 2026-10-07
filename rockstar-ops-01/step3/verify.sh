#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

entry="$(getent passwd lucia)" || fail "Todavía no existe el usuario real lucia."
[ -n "$entry" ] || fail "Todavía no existe el usuario real lucia."
home="$(printf '%s\n' "$entry" | cut -d: -f6)"
[ "$home" = "/home/lucia" ] || fail "El HOME registrado de lucia debe ser /home/lucia."
[ "$home" != "/home/jason" ] || fail "Lucia y Jason no pueden compartir el mismo HOME."
[ -d /home/lucia ] || fail "Falta el directorio real /home/lucia."
[ "$(stat -c '%U' /home/lucia)" = "lucia" ] || fail "/home/lucia debe pertenecer a lucia."

echo "✅ Lucia tiene una cuenta y un perfil independientes."
