#!/usr/bin/env bash
set -Eeuo pipefail
main=/etc/samba/smb.conf
include='include = /etc/samba/airmur04.conf'
if ! grep -Eq '^[[:space:]]*include[[:space:]]*=[[:space:]]*/etc/samba/airmur04\.conf[[:space:]]*$' "$main"; then
  if testparm -s 2>/dev/null | grep -Eq '^\[(Operaciones|Seguridad|Intercambio|Evidencias|AIRMUR-BOARDING)\]'; then
    echo 'Ya hay shares AIRMUR fuera del include; no se sobrescriben.' >&2; exit 2
  fi
  cp -a "$main" "$main.airmur04.bak"
  sed -i "/^\[global\]/a\\    $include" "$main"
fi
[[ -e /etc/samba/airmur04.conf ]] || install -m 0640 /etc/airmur04/smb-standalone.conf.staged /etc/samba/airmur04.conf
testparm -s >/var/log/airmur04-testparm.log 2>&1
systemctl restart smbd.service
echo 'Shares AIRMUR 04 activos.'

