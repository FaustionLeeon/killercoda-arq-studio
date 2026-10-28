#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/codigo-sin-clave.txt ]] || { echo 'Guarda el código HTTP sin clave'; exit 1; }
[[ "$(cat /root/codigo-sin-clave.txt)" == 401 ]] || { echo 'El código esperado sin clave es 401'; exit 1; }
getcode(){ curl -ksS -o /dev/null -w '%{http_code}' --resolve rivalz.test:443:127.0.0.1 "$@"; }
[[ "$(getcode https://rivalz.test/admin/)" == 401 ]] || { echo 'Sin usuario, /admin/ no devuelve 401'; exit 1; }
[[ "$(getcode -u 'operador:ClaveSoloLaboratorio2026!' https://rivalz.test/admin/)" == 200 ]] || { echo 'Con usuario válido, /admin/ no devuelve 200'; exit 1; }
curl -ksS -u 'operador:ClaveSoloLaboratorio2026!' --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/ | grep -q RIVALZ_ADMIN_2026 || { echo 'El panel autorizado no devuelve el HTML esperado'; exit 1; }
echo '✅ 401 sin credenciales; 200 con credenciales y HTTPS.'
