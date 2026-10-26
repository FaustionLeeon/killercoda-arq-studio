#!/usr/bin/env bash
set -u
lpstat -p AIRMUR-BOARDING >/dev/null 2>&1 || { echo 'No existe la cola AIRMUR-BOARDING.'; exit 1; }
for _ in $(seq 1 10); do [[ -s /var/spool/airmur-virtual-printer/boarding-output.prn ]] && break; sleep 1; done
[[ -s /var/spool/airmur-virtual-printer/boarding-output.prn ]] || { echo 'La cola existe, pero falta un trabajo de prueba en el spool.'; exit 1; }
testparm -s 2>/dev/null | grep -Fq '[AIRMUR-BOARDING]' || { echo 'La cola no está publicada por Samba.'; exit 1; }
echo 'Misión 5 superada: impresora virtual compartida y probada.'

