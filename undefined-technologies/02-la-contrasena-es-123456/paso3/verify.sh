#!/usr/bin/env bash
set -euo pipefail
f=/etc/nginx/.rivalz_htpasswd
[[ -f "$f" ]] || { echo 'Falta archivo htpasswd'; exit 1; }
htpasswd -vb "$f" operador 'ClaveSoloLaboratorio2026!' >/dev/null 2>&1 || { echo 'Usuario de prueba o clave incorrectos'; exit 1; }
[[ "$(stat -c '%a' "$f")" == 640 ]] || { echo 'Establece chmod 640'; exit 1; }
[[ "$(stat -c '%G' "$f")" == www-data ]] || { echo 'Usa grupo www-data'; exit 1; }
echo '✅ Identidad de laboratorio preparada (sin exponerla en HTTP).'
