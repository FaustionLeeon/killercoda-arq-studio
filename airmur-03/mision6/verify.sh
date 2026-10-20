#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

ticket_lucas() { klist -s && klist 2>/dev/null | grep -Fqi 'Default principal: lucas@AD.AIRMUR.TEST'; }
smb_kerberos() { smbclient --use-kerberos=required -L airmur-dc.ad.airmur.test 2>/dev/null | grep -Eq 'SYSVOL|NETLOGON'; }
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
check 'Ticket Kerberos de Lucas válido' ticket_lucas
check 'El ticket accede a servicios Samba' smb_kerberos
check 'Plan de movilidad completo y razonado' plan_ok
echo 'ℹ️  La unión de dos clientes y la movilidad de datos se acreditan en VirtualBox.'

mark_and_finish 6 15 'RA2.h · RA3.h'
