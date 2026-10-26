#!/usr/bin/env bash
set -u
file=/root/airmur04/evidencias/access-tests.txt
[[ -s $file ]] || { echo 'Falta ejecutar access-test.sh.'; exit 1; }
grep -q 'SUMMARY PASS=14 FAIL=0' "$file" || { echo 'La matriz de acceso no coincide. Revisa ACL, grupos y Samba.'; tail -n 18 "$file"; exit 1; }
grep -q 'expected=deny' "$file" || { echo 'Falta una denegación verificada.'; exit 1; }
echo 'Misión 4 superada: accesos y denegaciones verificados.'

