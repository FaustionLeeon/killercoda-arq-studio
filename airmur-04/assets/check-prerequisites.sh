#!/usr/bin/env bash
set -u
out=${1:-/root/airmur04/evidencias/prerrequisitos.txt}
mkdir -p "$(dirname "$out")"
pass=0; warn=0; fail=0
check() { if eval "$2"; then printf '[PASS] %s\n' "$1"; pass=$((pass+1)); else printf '[FAIL] %s\n' "$1"; fail=$((fail+1)); fi; }
exec > >(tee "$out") 2>&1
printf 'MODO=SIMULADO_STANDALONE\nFECHA=%s\n' "$(date -u +'%FT%TZ')"
check 'Preparación finalizada' 'test -e /var/lib/airmur04-prepared'
for user in lucas marta elena raul nora; do check "Usuario local $user" "getent passwd $user >/dev/null"; done
for group in air_ops air_security air_it; do check "Grupo local $group" "getent group $group >/dev/null"; done
for cmd in getfacl setfacl smbd testparm smbclient lpstat; do check "Comando $cmd" "command -v $cmd >/dev/null"; done
printf '[WARN] No se comprueban AD, Kerberos, DNS de dominio ni unión.\n'; warn=$((warn+1))
printf 'SUMMARY PASS=%d WARN=%d FAIL=%d\n' "$pass" "$warn" "$fail"
exit "$fail"

