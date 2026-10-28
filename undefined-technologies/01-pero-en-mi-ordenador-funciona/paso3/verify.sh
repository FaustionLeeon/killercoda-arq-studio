#!/usr/bin/env bash
set -euo pipefail
[[ -f /srv/rivalz/index.html && -f /srv/rivalz/style.css ]] || { echo 'Copia index.html y style.css a /srv/rivalz'; exit 1; }
grep -q RIVALZ_LAB_2026 /srv/rivalz/index.html || { echo 'index.html no es el de RIVALZ'; exit 1; }
echo '✅ Archivos publicados en el directorio de trabajo.'
