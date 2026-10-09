#!/bin/bash
set -u

archivo="/home/lucas/.bashrc"

[ -f "$archivo" ] || {
  echo "❌ No encuentro .bashrc de Lucas."
  exit 1
}

grep -Fxq "alias turnos='cd /srv/aeropuerto/turnos'" "$archivo" || {
  echo "❌ El alias turnos no está configurado exactamente como se pide."
  exit 1
}

propietario="$(stat -c '%U' "$archivo")"
grupo="$(stat -c '%G' "$archivo")"

[ "$propietario" = "lucas" ] && [ "$grupo" = "lucas" ] || {
  echo "❌ .bashrc debe pertenecer a lucas:lucas."
  exit 1
}

echo "✅ Entorno personal de Lucas configurado."
