# ⚡ Lucas quiere trabajar más rápido

Lucas está cansado de escribir:

`cd /srv/aeropuerto/turnos`

cada vez que necesita consultar un turno.

Cada usuario puede personalizar su entorno en `~/.bashrc`. Para Lucas será
`/home/lucas/.bashrc`.

Añade exactamente esta línea al archivo:

`alias turnos='cd /srv/aeropuerto/turnos'`

Puedes editarlo con:

`nano /home/lucas/.bashrc`

O añadirla directamente:

`echo "alias turnos='cd /srv/aeropuerto/turnos'" >> /home/lucas/.bashrc`

Asegúrate de que el archivo sigue perteneciendo a Lucas:

`chown lucas:lucas /home/lucas/.bashrc`

Compruébalo con `ls -l /home/lucas/.bashrc`.

Cuando Lucas inicie una nueva sesión podrá escribir simplemente `turnos` para
saltar al directorio de turnos. No has cambiado Linux para todo el mundo: has
cambiado **el entorno de Lucas**.

Pulsa **CHECK**.
