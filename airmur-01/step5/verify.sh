#!/bin/bash
set -u

archivo="/srv/aeropuerto/turnos/plan_turnos.txt"

[ -f "$archivo" ] || {
  echo "❌ No existe plan_turnos.txt."
  exit 1
}

propietario="$(stat -c '%U' "$archivo")"
grupo="$(stat -c '%G' "$archivo")"

if [ "$propietario" != "lucas" ] || [ "$grupo" != "lucas" ]; then
  echo "❌ El archivo debe pertenecer a lucas:lucas; ahora es $propietario:$grupo."
  exit 1
fi

echo "✅ Lucas es propietario del documento."
