#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

entry="$(getent passwd trevor)" || fail "Todavía no existe el usuario real trevor."
[ -n "$entry" ] || fail "Todavía no existe el usuario real trevor."
home="$(printf '%s\n' "$entry" | cut -d: -f6)"
[ "$home" = "/home/trevor" ] || fail "El HOME registrado de trevor debe ser /home/trevor."
[ -d /home/trevor ] || fail "Falta el directorio real /home/trevor."
[ "$(stat -c '%U' /home/trevor)" = "trevor" ] || fail "/home/trevor debe pertenecer a trevor."
status="$(passwd -S trevor 2>/dev/null | awk '{print $2}')"
[ "$status" = "L" ] || fail "La contraseña de trevor todavía no está bloqueada (estado esperado: L)."

echo "✅ Trevor está bloqueado y sus datos permanecen intactos."
