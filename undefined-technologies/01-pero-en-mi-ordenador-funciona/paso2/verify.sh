#!/usr/bin/env bash
set -euo pipefail
command -v nginx >/dev/null || { echo 'Nginx no está instalado'; exit 1; }
systemctl is-active --quiet nginx || { echo 'Nginx no está arrancado'; exit 1; }
curl -fsSI --max-time 5 http://127.0.0.1/ >/dev/null || { echo 'Nginx no responde en puerto 80'; exit 1; }
echo '✅ Nginx instalado, arrancado y accesible por HTTP.'
