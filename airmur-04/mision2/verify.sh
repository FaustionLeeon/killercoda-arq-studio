#!/usr/bin/env bash
set -u
[[ -s /root/airmur04/evidencias/policy.tsv ]] || { echo 'Falta policy.tsv.'; exit 1; }
[[ $(wc -l </root/airmur04/evidencias/policy.tsv) -eq 5 ]] || { echo 'La matriz debe contener cabecera y cuatro recursos.'; exit 1; }
check_acl() { getfacl -cp "$1" 2>/dev/null | grep -Fqx "$2"; }
check_acl /srv/airmur/operaciones 'group:air_ops:rwx' || { echo 'air_ops debe escribir en Operaciones.'; exit 1; }
check_acl /srv/airmur/operaciones 'group:air_security:r-x' || { echo 'air_security debe leer Operaciones.'; exit 1; }
check_acl /srv/airmur/seguridad 'group:air_ops:r-x' || { echo 'air_ops debe ser solo lectura en Seguridad.'; exit 1; }
check_acl /srv/airmur/seguridad 'group:air_security:rwx' || { echo 'air_security debe escribir en Seguridad.'; exit 1; }
check_acl /srv/airmur/evidencias 'group:air_it:rwx' || { echo 'air_it debe escribir en Evidencias.'; exit 1; }
for path in /srv/airmur/{operaciones,seguridad,intercambio,evidencias}; do
  getfacl -cp "$path" | grep -q '^default:' || { echo "Falta herencia en $path"; exit 1; }
done
echo 'Misión 2 superada: política y ACL heredables correctas.'

