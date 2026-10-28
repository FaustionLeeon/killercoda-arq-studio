#!/usr/bin/env bash
set -euo pipefail
nginx -t >/dev/null 2>&1 || { echo 'nginx -t falla. Revisa la configuración'; exit 1; }
ss -tln | grep -q ':443 ' || { echo 'Nginx no escucha en puerto 443'; exit 1; }
headers=$(curl -sSI -H 'Host: rivalz.test' http://127.0.0.1/admin/)
echo "$headers" | grep -Eq '^HTTP/[^ ]+ 301' || { echo 'HTTP /admin/ debe devolver 301'; exit 1; }
echo "$headers" | grep -qi 'location: https://rivalz.test/admin/' || { echo 'La redirección a HTTPS no es correcta'; exit 1; }
echo '✅ Puerto 443 activado y panel HTTP redirigido a HTTPS.'
