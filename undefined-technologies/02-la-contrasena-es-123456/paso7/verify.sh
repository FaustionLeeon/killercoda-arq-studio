#!/usr/bin/env bash
set -euo pipefail
[[ -s /root/accesos-denegados.log ]] || { echo 'Crea /root/accesos-denegados.log con solicitudes 401'; exit 1; }
grep -q ' 401 ' /root/accesos-denegados.log || { echo 'El archivo no contiene accesos 401'; exit 1; }
[[ -s /var/log/nginx/rivalz_access.log ]] || { echo 'No hay registro de accesos'; exit 1; }
echo '✅ Registros de intentos 401 inspeccionados y guardados.'
