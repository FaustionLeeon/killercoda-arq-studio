#!/usr/bin/env bash
set -Eeuo pipefail
evidence=/root/airmur04/evidencias/cockpit-files.txt
if [[ -d /usr/share/cockpit/files ]]; then
  [[ -s /srv/airmur/evidencias/nota-cockpit.txt ]] || { echo 'Crea nota-cockpit.txt desde Cockpit Files antes de registrar la evidencia.' >&2; exit 1; }
  { echo 'STATUS=COMPLETADO'; stat /srv/airmur/evidencias/nota-cockpit.txt; } >"$evidence"
  echo 'Uso de Cockpit Files registrado.'
else
  cat >"$evidence" <<'EOF'
STATUS=PENDIENTE_VIRTUALBOX
La imagen actual no ofrece cockpit-files. CE 4.e no se considera demostrado aquí.
EOF
  echo 'Cockpit Files no está disponible: misión registrada como pendiente de VirtualBox.'
fi

