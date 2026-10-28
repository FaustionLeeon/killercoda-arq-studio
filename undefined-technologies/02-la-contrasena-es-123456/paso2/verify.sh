#!/usr/bin/env bash
set -euo pipefail
nginx -t >/dev/null 2>&1 || { echo 'Hay errores de sintaxis de Nginx'; exit 1; }
[[ -L /etc/nginx/sites-enabled/inversores.conf ]] || { echo 'Falta activar el sitio virtual'; exit 1; }
curl -fsS -H 'Host: rivalz.test' http://127.0.0.1/ | grep -q RIVALZ_LAB_2026 || { echo 'RIVALZ no funciona'; exit 1; }
curl -fsS -H 'Host: inversores.test' http://127.0.0.1/ | grep -q UNDEFINED_INVEST_2026 || { echo 'El sitio de inversores no responde'; exit 1; }
echo '✅ Dos sitios virtuales diferenciados.'
