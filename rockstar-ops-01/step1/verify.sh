#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

entry="$(getent passwd jason)" || fail "Todavía no existe el usuario real jason."
[ -n "$entry" ] || fail "Todavía no existe el usuario real jason."
home="$(printf '%s\n' "$entry" | cut -d: -f6)"
shell="$(printf '%s\n' "$entry" | cut -d: -f7)"
[ "$home" = "/home/jason" ] || fail "El HOME registrado de jason debe ser /home/jason."
[ "$shell" = "/bin/bash" ] || fail "La shell registrada de jason debe ser /bin/bash."
[ -d /home/jason ] || fail "Falta el directorio real /home/jason."
[ "$(stat -c '%U' /home/jason)" = "jason" ] || fail "/home/jason debe pertenecer a jason."

echo "✅ Jason tiene cuenta, HOME y shell correctamente configurados."
