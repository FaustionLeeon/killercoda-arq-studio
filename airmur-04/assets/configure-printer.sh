#!/usr/bin/env bash
set -Eeuo pipefail
printer=AIRMUR-BOARDING
spool=/var/spool/airmur-virtual-printer
install -d -m 0770 -o root -g lp "$spool"
systemctl enable --now cups.service
if ! lpstat -p "$printer" >/dev/null 2>&1; then
  if ! grep -Eq '^[[:space:]]*FileDevice[[:space:]]+Yes' /etc/cups/cups-files.conf; then
    sed -ri 's/^#?FileDevice[[:space:]]+.*/FileDevice Yes/' /etc/cups/cups-files.conf
    grep -Eq '^[[:space:]]*FileDevice[[:space:]]+Yes' /etc/cups/cups-files.conf || echo 'FileDevice Yes' >>/etc/cups/cups-files.conf
    systemctl restart cups.service
  fi
  model=$(lpinfo -m 2>/dev/null | awk '/Generic.*Text-Only|textonly/ {print $1; exit}')
  [[ -n ${model:-} ]] || model='drv:///sample.drv/generic.ppd'
  lpadmin -p "$printer" -E -v "file:$spool/boarding-output.prn" -m "$model" || \
    lpadmin -p "$printer" -E -v "file:$spool/boarding-output.prn" -m raw
fi
cupsaccept "$printer"; cupsenable "$printer"; lpoptions -d "$printer" >/dev/null
lpstat -p "$printer"

