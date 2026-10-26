# AIRMUR 04 — EL AEROPUERTO TIENE SECRETOS

Son las 04:04. El panel de salidas muestra un vuelo que no existe y, en el servidor, han aparecido carpetas que demasiadas personas pueden abrir. El equipo AIRMUR debe reconstruir la política de acceso antes del primer embarque.

Este escenario practica **RA4: gestión segura de recursos compartidos**. La preparación crea solo el andamiaje que normalmente vendría de AIRMUR 01–03: nombres de usuarios, grupos, paquetes y directorios.

## Importante

Aquí no hay un controlador Samba AD validado. `lucas`, `marta`, `elena`, `raul` y `nora` son cuentas **locales** que simulan roles. ACL, Samba, CUPS, Cockpit y las pruebas sí se ejecutan de verdad. La unión a `ad.airmur.test` se completa después en VirtualBox.

Espera a que el terminal indique **AIRMUR 04 preparado**. Si falla, consulta `/var/log/airmur04-bootstrap.log`.

Contraseña didáctica: `Airmur04!Lab`. Solo sirve en esta máquina efímera.

