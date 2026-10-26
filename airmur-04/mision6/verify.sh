#!/usr/bin/env bash
set -u
file=/root/airmur04/evidencias/cockpit-files.txt
[[ -s $file ]] || { echo 'Falta ejecutar record-cockpit.sh.'; exit 1; }
systemctl is-active --quiet cockpit.socket || { echo 'Cockpit no está activo.'; exit 1; }
if [[ -d /usr/share/cockpit/files ]]; then
  grep -q '^STATUS=COMPLETADO' "$file" || { echo 'Falta crear la nota desde Cockpit Files.'; exit 1; }
  grep -q 'AIRMUR 04' /srv/airmur/evidencias/nota-cockpit.txt || { echo 'La nota no contiene AIRMUR 04.'; exit 1; }
  echo 'Misión 6 superada y CE 4.e documentado.'
else
  grep -q '^STATUS=PENDIENTE_VIRTUALBOX' "$file" || { echo 'Registra la indisponibilidad del complemento.'; exit 1; }
  echo 'Misión 6 cerrada con CE 4.e pendiente de VirtualBox.'
fi

