#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

exec > >(tee /tmp/airmur-mision6.log) 2>&1

find_lucas_cache() {
  local cache configured=${KRB5CCNAME:-}
  configured=${configured#FILE:}

  for cache in "$configured" /tmp/krb5cc_*; do
    [ -n "$cache" ] && [ -f "$cache" ] || continue
    if timeout 5s klist -c "FILE:$cache" 2>/dev/null |
       grep -Fqi 'Default principal: lucas@AD.AIRMUR.TEST'; then
      printf '%s\n' "$cache"
      return 0
    fi
  done

  return 1
}

ticket_lucas() {
  local cache
  cache=$(find_lucas_cache) || return 1
  timeout 5s klist -c "FILE:$cache" -s
}

smb_kerberos() {
  local cache
  cache=$(find_lucas_cache) || return 1
  KRB5CCNAME="FILE:$cache" timeout 10s \
    smbclient --use-kerberos=required --no-pass -L airmur-dc.ad.airmur.test 2>/dev/null |
    grep -Eqi 'sysvol|netlogon'
}
plan_ok() {
  local file=/root/airmur03/evidencias/plan-perfil-lucas.md
  [ -f "$file" ] && [ "$(wc -w < "$file")" -ge 80 ] &&
    ! grep -Fq 'COMPLETA-AQUI' "$file" &&
    grep -Fqx 'AUTENTICACION=KERBEROS' "$file" &&
    grep -Fqx 'DATOS_CENTRALIZADOS=SMB' "$file" &&
    grep -Fqx 'PERMISOS=PRIVADOS' "$file" &&
    grep -Fqx 'PERFIL_MOVIL_COMPLETO=NO' "$file" &&
    grep -Fqi 'copia' "$file" && grep -Fqi 'cliente' "$file"
}

echo '=== COMPROBACIÓN MISIÓN 6 ==='
echo 'Si CHECK no avanza, ejecuta: cat /tmp/airmur-mision6.log'
check 'Ticket Kerberos de Lucas válido' ticket_lucas
check 'El ticket accede a servicios Samba' smb_kerberos
check 'Plan de movilidad completo y razonado' plan_ok
echo 'ℹ️  La unión de dos clientes y la movilidad de datos se acreditan en VirtualBox.'

mark_and_finish 6 15 'RA2.h · RA3.h'
