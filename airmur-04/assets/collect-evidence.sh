#!/usr/bin/env bash
set -Eeuo pipefail
root=/root/airmur04/evidencias; stamp=$(date -u +'%Y%m%dT%H%M%SZ'); out="$root/$stamp"
mkdir -p "$out"
for resource in operaciones seguridad intercambio evidencias; do getfacl -p "/srv/airmur/$resource" >"$out/acl-$resource.txt"; done
testparm -s >"$out/samba-effective.txt" 2>&1
lpstat -t >"$out/cups.txt" 2>&1 || true
cp -a "$root"/*.txt "$out/" 2>/dev/null || true
printf 'MODO=KILLERCODA_STANDALONE\nNO_ACREDITA_AD=SI\nFECHA=%s\n' "$stamp" >"$out/alcance.txt"
tar -C "$root" -czf "$root/airmur04-evidencias-$stamp.tar.gz" "$stamp"
echo "$root/airmur04-evidencias-$stamp.tar.gz" | tee /root/airmur04/ultimo-paquete.txt

