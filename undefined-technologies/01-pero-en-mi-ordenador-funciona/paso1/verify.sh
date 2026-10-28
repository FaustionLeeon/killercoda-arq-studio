#!/usr/bin/env bash
set -euo pipefail
f=/root/diagnostico.txt
[[ -f "$f" ]] || { echo 'Falta /root/diagnostico.txt'; exit 1; }
for v in 'PERSONA:' 'SISTEMA:' 'KIT:' 'OBJETIVO:'; do grep -Fq "$v" "$f" || { echo "Falta $v"; exit 1; }; done
echo '✅ Inspección registrada. El sistema operativo ya no es un misterio.'
