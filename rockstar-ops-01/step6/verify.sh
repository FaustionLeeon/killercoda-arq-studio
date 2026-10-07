#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

entry="$(getent passwd michael)" || fail "No existe el usuario real michael."
[ -n "$entry" ] || fail "No existe el usuario real michael."
home="$(printf '%s\n' "$entry" | cut -d: -f6)"
[ "$home" = "/home/michael" ] || fail "El HOME registrado de michael debe ser /home/michael."
[ -d /home/michael ] || fail "Falta el directorio real /home/michael."
[ "$(stat -c '%U' /home/michael)" = "michael" ] || fail "/home/michael debe pertenecer a michael."
[ -d /home/michael/GTAVI ] || fail "Falta /home/michael/GTAVI."
[ -f /home/michael/GTAVI/trailer_final.txt ] || fail "Falta /home/michael/GTAVI/trailer_final.txt."
[ "$(stat -c '%U' /home/michael/GTAVI)" = "michael" ] || fail "La carpeta GTAVI debe pertenecer a michael."
[ "$(stat -c '%U' /home/michael/GTAVI/trailer_final.txt)" = "michael" ] || fail "trailer_final.txt debe pertenecer a michael."

echo "✅ Michael tiene cuenta, HOME y entrega con la propiedad correcta."
