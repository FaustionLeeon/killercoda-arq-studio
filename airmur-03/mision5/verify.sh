#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

dn_contains() { samba-tool "$1" show "$2" 2>/dev/null | grep -Fqi "dn: $3"; }
has_ou() { samba-tool ou list --full-dn 2>/dev/null | grep -Fqi "$1"; }
model_ok() {
  local file=/root/airmur03/evidencias/modelo-ou.md
  [ -f "$file" ] && [ "$(wc -w < "$file")" -ge 80 ] &&
    ! grep -Fq 'COMPLETA-AQUI' "$file" &&
    grep -Fqi 'OU' "$file" && grep -Fqi 'grupo' "$file" &&
    grep -Fqi 'deleg' "$file" && grep -Fqi 'polít' "$file"
}

echo '=== COMPROBACIÓN MISIÓN 5 ==='
for ou in \
  'OU=AIRMUR,' \
  'OU=Usuarios,OU=AIRMUR,' \
  'OU=Equipos,OU=AIRMUR,' \
  'OU=Grupos,OU=AIRMUR,' \
  'OU=Operaciones,OU=Usuarios,OU=AIRMUR,' \
  'OU=Mantenimiento,OU=Usuarios,OU=AIRMUR,' \
  'OU=Administracion,OU=Usuarios,OU=AIRMUR,' \
  'OU=Sistemas,OU=Usuarios,OU=AIRMUR,'; do
  check "Existe $ou" has_ou "$ou"
done
check 'Lucas está en Operaciones' dn_contains user lucas 'CN=lucas,OU=Operaciones,OU=Usuarios,OU=AIRMUR,'
check 'Marta está en Administración' dn_contains user marta 'CN=marta,OU=Administracion,OU=Usuarios,OU=AIRMUR,'
check 'Elena está en Mantenimiento' dn_contains user elena 'CN=elena,OU=Mantenimiento,OU=Usuarios,OU=AIRMUR,'
check 'Raúl está en Sistemas' dn_contains user raul 'CN=raul,OU=Sistemas,OU=Usuarios,OU=AIRMUR,'
check 'Nora está en Sistemas' dn_contains user nora 'CN=nora,OU=Sistemas,OU=Usuarios,OU=AIRMUR,'
check 'PC01 está en Equipos' dn_contains computer AIRMUR-PC01 'CN=AIRMUR-PC01,OU=Equipos,OU=AIRMUR,'
check 'PC02 está en Equipos' dn_contains computer AIRMUR-PC02 'CN=AIRMUR-PC02,OU=Equipos,OU=AIRMUR,'
for group in operaciones mantenimiento administracion sistemas; do
  check "El grupo $group está en OU=Grupos" dn_contains group "$group" "CN=$group,OU=Grupos,OU=AIRMUR,"
done
check 'Justificación administrativa suficiente' model_ok

mark_and_finish 5 15 'RA3.f · RA3.g'
