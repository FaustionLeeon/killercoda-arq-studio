#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

getent passwd jason >/dev/null || fail "No existe el usuario real jason."
[ -d /home/jason/GTAVI ] || fail "Falta el directorio /home/jason/GTAVI."
[ -f /home/jason/GTAVI/build_vicecity.txt ] || fail "Falta /home/jason/GTAVI/build_vicecity.txt."
[ "$(stat -c '%U' /home/jason/GTAVI)" = "jason" ] || fail "La carpeta GTAVI debe pertenecer a jason."
[ "$(stat -c '%U' /home/jason/GTAVI/build_vicecity.txt)" = "jason" ] || fail "build_vicecity.txt debe pertenecer a jason."

echo "✅ El espacio de trabajo de Jason está preparado y le pertenece."
