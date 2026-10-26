#!/usr/bin/env bash
set -u
out=/root/airmur04/evidencias/auditoria-final.txt; pass=0; fail=0; warn=0
exec > >(tee "$out") 2>&1
ok() { echo "PASS $*"; pass=$((pass+1)); }
bad() { echo "FAIL $*"; fail=$((fail+1)); }
for path in /srv/airmur/operaciones /srv/airmur/seguridad /srv/airmur/intercambio /srv/airmur/evidencias; do
  [[ -d $path ]] && ok "$path existe" || bad "$path falta"
  getfacl -cp "$path" 2>/dev/null | grep -q '^default:' && ok "$path hereda ACL" || bad "$path no hereda ACL"
done
testparm -s >/dev/null 2>&1 && ok 'Samba válido' || bad 'Samba inválido'
for share in Operaciones Seguridad Intercambio Evidencias AIRMUR-BOARDING; do
  testparm -s 2>/dev/null | grep -Fq "[$share]" && ok "share $share" || bad "falta share $share"
done
lpstat -p AIRMUR-BOARDING >/dev/null 2>&1 && ok 'cola AIRMUR-BOARDING' || bad 'falta cola'
systemctl is-active --quiet cockpit.socket && ok 'Cockpit activo' || bad 'Cockpit inactivo'
if grep -q '^STATUS=COMPLETADO' /root/airmur04/evidencias/cockpit-files.txt 2>/dev/null; then ok 'Cockpit Files documentado';
elif grep -q '^STATUS=PENDIENTE_VIRTUALBOX' /root/airmur04/evidencias/cockpit-files.txt 2>/dev/null; then echo 'WARN CE 4.e pendiente de VirtualBox'; warn=$((warn+1));
else bad 'falta evidencia Cockpit'; fi
grep -q 'SUMMARY PASS=14 FAIL=0' /root/airmur04/evidencias/access-tests.txt 2>/dev/null && ok 'pruebas de acceso' || bad 'pruebas de acceso incompletas'
echo "AUDIT_SUMMARY PASS=$pass WARN=$warn FAIL=$fail"
exit "$fail"

