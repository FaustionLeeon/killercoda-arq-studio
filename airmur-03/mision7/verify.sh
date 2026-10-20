#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

echo '=== COMPROBACIÓN MISIÓN 7 ==='
expected=(10 15 15 15 15 15)
for mission in 1 2 3 4 5 6; do
  check "Misión $mission corregida" grep -Fxq "${expected[$((mission - 1))]}" "/var/lib/airmur03/mision${mission}.aprobada"
done
check 'Auditoría técnica completa' airmur-auditoria
check 'Base del directorio coherente' samba-tool dbcheck --cross-ncs

mark_and_finish 7 15 'AUDITORÍA FINAL RA3'
