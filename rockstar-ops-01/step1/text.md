# Jason llega al equipo

Jason empieza mañana. Necesita una identidad propia y un espacio personal en
el servidor.

Crea su cuenta con el asistente de Ubuntu:

```bash
adduser jason
```{{copy}}

Escribe una contraseña temporal. Los demás datos son opcionales: puedes pulsar
Intro para dejarlos vacíos y confirmar al final con `Y`.

Después investiga qué ha creado el sistema:

```bash
id jason
getent passwd jason
ls -ld /home/jason
```{{copy}}

- Un **usuario** es una identidad reconocida por Linux.
- El **UID** es su número de identificación personal.
- El **GID** identifica su grupo principal.
- El **HOME** (`/home/jason`) es su espacio personal.
- `/bin/bash` es el programa que interpreta sus comandos al iniciar sesión.

Cuando Jason exista y su HOME sea realmente suyo, pulsa **CHECK**.
