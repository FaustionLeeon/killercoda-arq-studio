#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

echo '=== COMPROBACIÓN MISIÓN 1 ==='
contains 'Ubuntu 24.04 identificado' '24.04' grep PRETTY_NAME /etc/os-release
contains 'Nombre FQDN del DC' 'airmur-dc.ad.airmur.test' hostname -f
contains 'Resolución local hacia 172.30.1.2' '172.30.1.2' getent hosts airmur-dc.ad.airmur.test
contains 'Paquete samba-ad-dc instalado' 'install ok installed' dpkg-query -W -f='${Status}' samba-ad-dc
check 'Herramienta samba-tool disponible' command -v samba-tool
check 'Herramienta kinit disponible' command -v kinit
check 'Herramienta dig disponible' command -v dig
contains 'samba-ad-dc habilitado para el arranque' 'enabled' systemctl is-enabled samba-ad-dc
contains 'smbd está enmascarado' 'masked' systemctl is-enabled smbd

mark_and_finish 1 10 'RA3.d'
