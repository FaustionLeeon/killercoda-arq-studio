#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

computer_object() {
  local name=$1 out
  out=$(samba-tool computer show "$name" 2>/dev/null) || return 1
  grep -Fqi 'objectClass: computer' <<<"$out" && grep -Fqi "sAMAccountName: ${name}\$" <<<"$out"
}
computer_enabled() {
  local uac
  uac=$(samba-tool computer show "$1" 2>/dev/null | sed -n 's/^[[:space:]]*userAccountControl: //p' | head -n1)
  [[ $uac =~ ^[0-9]+$ ]] && (( (uac & 2) == 0 ))
}

echo '=== COMPROBACIÓN MISIÓN 4 ==='
check 'AIRMUR-PC01 es un objeto computer real' computer_object AIRMUR-PC01
check 'AIRMUR-PC02 es un objeto computer real' computer_object AIRMUR-PC02
check 'AIRMUR-PC01 está habilitado' computer_enabled AIRMUR-PC01
check 'AIRMUR-PC02 volvió a quedar habilitado' computer_enabled AIRMUR-PC02
check 'Se observó el estado deshabilitado de PC02' test -s /var/lib/airmur03/AIRMUR-PC02.ciclo

echo 'ℹ️  Killercoda acredita gestión de objetos reales, no dos uniones de sistemas independientes.'
mark_and_finish 4 15 'RA3.h · RA2.c parcial'
