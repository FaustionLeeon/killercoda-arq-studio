#!/usr/bin/env bash
set -Eeuo pipefail
for group in air_ops air_security air_it; do getent group "$group" >/dev/null || { echo "Falta $group"; exit 1; }; done
chgrp air_it /srv/airmur/{operaciones,seguridad,intercambio,evidencias}
chmod 2770 /srv/airmur/{operaciones,seguridad,intercambio,evidencias}
setfacl -m u::rwx,g::rwx,g:air_ops:rwx,g:air_security:r-x,g:air_it:rwx,m::rwx,o::--- /srv/airmur/operaciones
setfacl -m d:u::rwx,d:g::rwx,d:g:air_ops:rwx,d:g:air_security:r-x,d:g:air_it:rwx,d:m::rwx,d:o::--- /srv/airmur/operaciones
setfacl -m u::rwx,g::rwx,g:air_ops:r-x,g:air_security:rwx,g:air_it:rwx,m::rwx,o::--- /srv/airmur/seguridad
setfacl -m d:u::rwx,d:g::rwx,d:g:air_ops:r-x,d:g:air_security:rwx,d:g:air_it:rwx,d:m::rwx,d:o::--- /srv/airmur/seguridad
setfacl -m u::rwx,g::rwx,g:air_ops:rwx,g:air_security:rwx,g:air_it:rwx,m::rwx,o::--- /srv/airmur/intercambio
setfacl -m d:u::rwx,d:g::rwx,d:g:air_ops:rwx,d:g:air_security:rwx,d:g:air_it:rwx,d:m::rwx,d:o::--- /srv/airmur/intercambio
setfacl -m u::rwx,g::rwx,g:air_ops:---,g:air_security:---,g:air_it:rwx,m::rwx,o::--- /srv/airmur/evidencias
setfacl -m d:u::rwx,d:g::rwx,d:g:air_ops:---,d:g:air_security:---,d:g:air_it:rwx,d:m::rwx,d:o::--- /srv/airmur/evidencias
touch /srv/airmur/.acl-applied
echo 'ACL AIRMUR 04 aplicadas.'

