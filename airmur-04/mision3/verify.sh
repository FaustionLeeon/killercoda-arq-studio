#!/usr/bin/env bash
set -u
testparm -s >/dev/null 2>&1 || { echo 'Samba no acepta la configuración.'; exit 1; }
effective=$(testparm -s 2>/dev/null)
for share in Operaciones Seguridad Intercambio Evidencias AIRMUR-BOARDING; do
  grep -Fq "[$share]" <<<"$effective" || { echo "Falta el share $share"; exit 1; }
done
for share in Operaciones Seguridad Intercambio Evidencias; do
  valid=$(testparm -s --parameter-name='valid users' --section-name="$share" 2>/dev/null)
  guest=$(testparm -s --parameter-name='guest ok' --section-name="$share" 2>/dev/null)
  [[ -n $valid ]] || { echo "$share no limita usuarios."; exit 1; }
  [[ ${guest,,} == no ]] || { echo "$share debe rechazar invitado."; exit 1; }
done
systemctl is-active --quiet smbd.service || { echo 'smbd no está activo.'; exit 1; }
echo 'Misión 3 superada: shares publicados con autenticación.'

