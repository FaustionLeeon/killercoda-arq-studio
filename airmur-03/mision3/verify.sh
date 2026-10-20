#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

has_user() { samba-tool user show "$1" 2>/dev/null | grep -Fqi 'objectClass: user'; }
has_group() { samba-tool group show "$1" >/dev/null 2>&1; }
member_of() { samba-tool group listmembers "$1" 2>/dev/null | grep -Fxiq "$2"; }

echo '=== COMPROBACIÓN MISIÓN 3 ==='
for user in lucas marta elena raul nora; do check "Usuario de dominio $user" has_user "$user"; done
for group in operaciones mantenimiento administracion sistemas; do check "Grupo de dominio $group" has_group "$group"; done
check 'Lucas pertenece a operaciones' member_of operaciones lucas
check 'Marta pertenece a administracion' member_of administracion marta
check 'Elena pertenece a mantenimiento' member_of mantenimiento elena
check 'Raúl pertenece a sistemas' member_of sistemas raul
check 'Nora pertenece a sistemas' member_of sistemas nora

mark_and_finish 3 15 'RA3.e · RA3.h'
