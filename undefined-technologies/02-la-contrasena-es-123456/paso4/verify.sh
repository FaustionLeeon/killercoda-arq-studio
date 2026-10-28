#!/usr/bin/env bash
set -euo pipefail
crt=/etc/ssl/certs/rivalz.test.crt; key=/etc/ssl/private/rivalz.test.key
[[ -s "$crt" && -s "$key" ]] || { echo 'Faltan certificado o clave privada'; exit 1; }
openssl x509 -in "$crt" -noout -text 2>/dev/null | grep -q 'DNS:rivalz.test' || { echo 'Certificado sin el DNS rivalz.test'; exit 1; }
[[ "$(stat -c '%a' "$key")" == 600 ]] || { echo 'Clave privada: chmod 600'; exit 1; }
echo '✅ Certificado autofirmado de pruebas generado y clave protegida.'
