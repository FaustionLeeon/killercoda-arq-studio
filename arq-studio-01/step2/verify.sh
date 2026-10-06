#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd pablo >/dev/null || fail "No existe el usuario pablo."
[ -d /home/pablo/PROYECTOS ] || fail "Falta /home/pablo/PROYECTOS."
[ -f /home/pablo/PROYECTOS/vivienda_murcia.txt ] || fail "Falta vivienda_murcia.txt."
[ "$(stat -c '%U' /home/pablo/PROYECTOS)" = "pablo" ] || fail "La carpeta PROYECTOS debe pertenecer a pablo."
[ "$(stat -c '%U' /home/pablo/PROYECTOS/vivienda_murcia.txt)" = "pablo" ] || fail "El archivo debe pertenecer a pablo."

echo "✅ El primer proyecto de Pablo está preparado."

