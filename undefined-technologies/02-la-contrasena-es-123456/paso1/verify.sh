#!/usr/bin/env bash
set -euo pipefail
[[ -f /tmp/rivalz-setup.ok ]] || { echo 'El escenario aún se está preparando'; exit 1; }
[[ -s /root/diagnostico-seguridad.txt ]] || { echo 'Crea el diagnóstico de seguridad'; exit 1; }
nginx -t >/dev/null 2>&1 || exit 1
[[ "$(curl -s -o /dev/null -w '%{http_code}' -H 'Host: rivalz.test' http://127.0.0.1/admin/)" == 403 ]] || { echo 'El panel no está bloqueado en HTTP'; exit 1; }
echo '✅ Diagnóstico de la configuración actual.'
