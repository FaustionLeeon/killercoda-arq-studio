#!/bin/bash
set -u

[ -d /srv/aeropuerto ] || {
  echo "❌ Falta /srv/aeropuerto."
  exit 1
}

[ -d /srv/aeropuerto/turnos ] || {
  echo "❌ Falta el directorio turnos."
  exit 1
}

[ -f /srv/aeropuerto/turnos/parte_inicio.txt ] || {
  echo "❌ Falta parte_inicio.txt."
  exit 1
}

echo "✅ Centro de operaciones preparado."
