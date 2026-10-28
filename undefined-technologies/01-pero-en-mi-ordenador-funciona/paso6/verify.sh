#!/usr/bin/env bash
set -euo pipefail
command -v docker >/dev/null || { echo 'No hay Docker'; exit 1; }
[[ "$(docker inspect -f '{{.State.Running}}' rivalz-preview 2>/dev/null)" == true ]] || { echo 'No existe contenedor rivalz-preview en ejecución'; exit 1; }
[[ "$(docker inspect -f '{{range .Mounts}}{{if eq .Destination "/usr/share/nginx/html"}}{{.RW}}{{end}}{{end}}' rivalz-preview 2>/dev/null)" == false ]] || { echo 'El volumen debe ser de solo lectura (:ro)'; exit 1; }
curl -fsS --max-time 8 http://127.0.0.1:8081/ | grep -q RIVALZ_LAB_2026 || { echo 'RIVALZ no responde desde Docker en 8081'; exit 1; }
echo '✅ Servidor web de RIVALZ también en Docker.'
