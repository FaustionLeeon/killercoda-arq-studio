#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/prueba-rivalz.html ]] || { echo 'Guarda la respuesta en /root/prueba-rivalz.html'; exit 1; }
grep -q RIVALZ_LAB_2026 /root/prueba-rivalz.html || { echo 'El comprobante no contiene RIVALZ'; exit 1; }
curl -fsSI --max-time 5 http://127.0.0.1/style.css >/dev/null || { echo 'El CSS no se sirve'; exit 1; }
echo '✅ Prueba HTTP y recursos estáticos superada.'
