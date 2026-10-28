#!/usr/bin/env bash
set -euo pipefail
echo 'Preparando servidor web RIVALZ para el capítulo 2...'
for i in $(seq 1 180); do
 if [[ -f /tmp/rivalz-setup.ok ]]; then echo '✅ Entorno preparado. Empieza por el paso 1.'; exit 0; fi
 if [[ -f /tmp/rivalz-setup.error ]]; then echo '⚠ Error preparando Ubuntu/Nginx. Avise al profesor; consulte Creator Debug.'; exit 1; fi
 sleep 1
done
echo '⚠ La instalación no terminó a tiempo. Reinicia escenario o consulta Creator Debug.'
exit 1
