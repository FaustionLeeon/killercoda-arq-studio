#!/bin/bash
set -Eeuo pipefail

state=/var/lib/airmur03
asset_dir=/opt/airmur03-assets
install -d -m 0700 "$state" /root/airmur03/evidencias /root/airmur03/plantillas
rm -f "$state/setup.ok" "$state/setup.failed"
trap 'touch /var/lib/airmur03/setup.failed' ERR

install -m 0555 "$asset_dir/verify-common.sh" /usr/local/lib/airmur03-verify-common.sh
install -m 0555 "$asset_dir/airmur-puntuacion" /usr/local/bin/airmur-puntuacion
install -m 0555 "$asset_dir/airmur-auditoria" /usr/local/bin/airmur-auditoria
install -m 0555 "$asset_dir/airmur-registra-ciclo-equipo" /usr/local/bin/airmur-registra-ciclo-equipo
install -m 0444 "$asset_dir/plan-perfil-lucas.template" /root/airmur03/plantillas/plan-perfil-lucas.md
install -m 0444 "$asset_dir/modelo-ou.template" /root/airmur03/plantillas/modelo-ou.md

cat > /root/airmur03/LEEME.txt <<'EOF'
AIRMUR 03 no deja el dominio resuelto.
Solo instala herramientas de evaluación y plantillas.
El alumno debe instalar y configurar Samba AD durante las misiones.
EOF
chmod 0444 /root/airmur03/LEEME.txt

touch "$state/setup.ok"
chmod 0600 "$state/setup.ok"
