#!/bin/bash
set -u

echo "Preparando los materiales de AIRMUR 03..."
for _ in $(seq 1 120); do
  if [ -f /var/lib/airmur03/setup.ok ]; then
    echo "✅ Materiales preparados. El dominio todavía NO existe: debes construirlo tú."
    echo "Sistema: $(. /etc/os-release; echo "$PRETTY_NAME")"
    echo "IP del laboratorio: $(hostname -I | awk '{print $1}')"
    exit 0
  fi
  if [ -f /var/lib/airmur03/setup.failed ]; then
    echo "❌ La preparación falló. Consulta Creator Debug." >&2
    exit 1
  fi
  sleep 1
done
echo "❌ La preparación no terminó a tiempo." >&2
exit 1
