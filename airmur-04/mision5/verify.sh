#!/usr/bin/env bash
set -u
lpstat -p AIRMUR-BOARDING >/dev/null 2>&1 || { echo 'No existe la cola AIRMUR-BOARDING.'; exit 1; }
spool_dir=/var/spool/airmur-virtual-printer
has_spool() { find "$spool_dir" -maxdepth 1 -type f -size +0c -print -quit 2>/dev/null | grep -q .; }
for _ in $(seq 1 10); do has_spool && break; sleep 1; done
has_spool || { echo 'La cola existe, pero falta un trabajo de prueba en el spool.'; exit 1; }
testparm -s 2>/dev/null | grep -Fq '[AIRMUR-BOARDING]' || { echo 'La cola no está publicada por Samba.'; exit 1; }
echo 'Misión 5 superada: impresora virtual compartida y probada.'

