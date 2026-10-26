#!/usr/bin/env bash
set -u
audit=/root/airmur04/evidencias/auditoria-final.txt
[[ -s $audit ]] || { echo 'Falta ejecutar audit.sh.'; exit 1; }
grep -q 'AUDIT_SUMMARY.*FAIL=0' "$audit" || { echo 'La auditoría conserva fallos.'; tail -n 15 "$audit"; exit 1; }
[[ -s /root/airmur04/ultimo-paquete.txt ]] || { echo 'Falta generar el paquete de evidencias.'; exit 1; }
package=$(cat /root/airmur04/ultimo-paquete.txt)
[[ -s $package ]] || { echo 'El paquete indicado no existe.'; exit 1; }
tar -tzf "$package" | grep -q 'alcance.txt' || { echo 'El paquete no documenta su alcance.'; exit 1; }
echo "Misión 7 superada. Conserva: $package"

