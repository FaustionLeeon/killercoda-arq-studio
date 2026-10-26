#!/usr/bin/env bash
set -Eeuo pipefail
out=/root/airmur04/evidencias/access-tests.txt
password='Airmur04!Lab'; pass=0; fail=0
mkdir -p "$(dirname "$out")"
exec > >(tee "$out") 2>&1
probe() {
  expected=$1; user=$2; path=$3; file="$path/.airmur04-$user-$$"; ok=0
  sudo -u "$user" sh -c 'printf test > "$1"' sh "$file" >/dev/null 2>&1 && ok=1
  rm -f "$file" 2>/dev/null || true
  if { [[ $expected == allow ]] && ((ok)); } || { [[ $expected == deny ]] && ((!ok)); }; then
    echo "PASS user=$user write=$path expected=$expected"; pass=$((pass+1))
  else echo "FAIL user=$user write=$path expected=$expected"; fail=$((fail+1)); fi
}
probe allow lucas /srv/airmur/operaciones
probe deny lucas /srv/airmur/seguridad
probe allow elena /srv/airmur/seguridad
probe deny elena /srv/airmur/operaciones
probe allow marta /srv/airmur/intercambio
probe allow raul /srv/airmur/intercambio
probe allow nora /srv/airmur/evidencias
probe deny lucas /srv/airmur/evidencias
smb_probe() {
  expected=$1; user=$2; share=$3; ok=0; tmp=$(mktemp); printf 'SMB AIRMUR04\n' >"$tmp"
  smbclient "//localhost/$share" -U "$user%$password" -c "put $tmp .airmur04-$user-$$; del .airmur04-$user-$$" >/dev/null 2>&1 && ok=1
  rm -f "$tmp"
  if { [[ $expected == allow ]] && ((ok)); } || { [[ $expected == deny ]] && ((!ok)); }; then
    echo "PASS smb_user=$user share=$share expected=$expected"; pass=$((pass+1))
  else echo "FAIL smb_user=$user share=$share expected=$expected"; fail=$((fail+1)); fi
}
smb_probe allow lucas Operaciones
smb_probe deny lucas Seguridad
smb_probe allow elena Seguridad
smb_probe deny elena Operaciones
smb_probe allow nora Evidencias
if smbclient -L //localhost -U "lucas%$password" >/dev/null 2>&1; then echo 'PASS smb_auth=lucas'; pass=$((pass+1)); else echo 'FAIL smb_auth=lucas'; fail=$((fail+1)); fi
echo "SUMMARY PASS=$pass FAIL=$fail"
exit "$fail"

