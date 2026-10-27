#!/usr/bin/env bash
set -Eeuo pipefail
printer=AIRMUR-BOARDING
spool=/var/spool/airmur-virtual-printer
cup_output=/var/spool/cups/airmur-output.prn
install -d -m 0770 -o root -g lp "$spool"
systemctl enable --now cups.service
if [[ ! -e $cup_output ]]; then
  install -m 0660 -o lp -g lp /dev/null "$cup_output"
else
  chown lp:lp "$cup_output"; chmod 0660 "$cup_output"
fi
if [[ ! -e $spool/boarding-output.prn ]] || ! [[ $cup_output -ef $spool/boarding-output.prn ]]; then
  rm -f "$spool/boarding-output.prn"
  ln "$cup_output" "$spool/boarding-output.prn"
fi
if ! lpstat -p "$printer" >/dev/null 2>&1; then
  if ! grep -Eq '^[[:space:]]*FileDevice[[:space:]]+Yes' /etc/cups/cups-files.conf; then
    sed -ri 's/^#?FileDevice[[:space:]]+.*/FileDevice Yes/' /etc/cups/cups-files.conf
    grep -Eq '^[[:space:]]*FileDevice[[:space:]]+Yes' /etc/cups/cups-files.conf || echo 'FileDevice Yes' >>/etc/cups/cups-files.conf
    systemctl restart cups.service
  fi
  model=$(lpinfo -m 2>/dev/null | awk '/Generic.*Text-Only|textonly/ {print $1; exit}')
  [[ -n ${model:-} ]] || model='drv:///sample.drv/generic.ppd'
  lpadmin -p "$printer" -E -v "file:$cup_output" -m "$model" || \
    lpadmin -p "$printer" -E -v "file:$cup_output" -m raw
elif ! lpstat -v "$printer" 2>/dev/null | grep -Fq "file:$cup_output"; then
  lpadmin -p "$printer" -v "file:$cup_output"
fi
cupsaccept "$printer"; cupsenable "$printer"; lpoptions -d "$printer" >/dev/null
lpstat -p "$printer"

