#!/bin/bash
set -u

if [ ! -f /home/ubicacion_comprobada ]; then
  echo "❌ No encuentro /home/ubicacion_comprobada."
  echo "Ve a /home y crea allí el archivo ubicacion_comprobada."
  exit 1
fi

echo "✅ Sabes localizarte y moverte por el sistema."
