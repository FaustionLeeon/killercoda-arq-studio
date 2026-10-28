#!/usr/bin/env bash
set -euo pipefail
nginx -t >/dev/null 2>&1 || { echo 'Configuración de Nginx con errores'; exit 1; }
[[ -L /etc/nginx/sites-enabled/rivalz.conf ]] || { echo 'No has activado rivalz.conf'; exit 1; }
[[ ! -e /etc/nginx/sites-enabled/default ]] || { echo 'La web genérica sigue habilitada'; exit 1; }
grep -Eq 'root[[:space:]]+/srv/rivalz;' /etc/nginx/sites-available/rivalz.conf || { echo 'Falta root /srv/rivalz;'; exit 1; }
curl -fsS --max-time 5 http://127.0.0.1/ | grep -q RIVALZ_LAB_2026 || { echo 'Nginx no está mostrando RIVALZ'; exit 1; }
echo '✅ Configuración activada: ahora se muestra RIVALZ.'
