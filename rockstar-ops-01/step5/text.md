# Un desarrollador deja el proyecto

Trevor abandona el equipo. Su cuenta y sus documentos deben conservarse por si
hay que revisar trabajo anterior, pero su contraseña ya no debe permitir acceso.

Primero crea la cuenta:

```bash
adduser trevor
```{{copy}}

Después bloquea su contraseña:

```bash
passwd -l trevor
```{{copy}}

Comprueba tanto el estado como su HOME:

```bash
passwd -S trevor
ls -ld /home/trevor
```{{copy}}

En la salida de `passwd -S`, la letra `L` significa **Locked** (bloqueada).
Bloquear no es borrar: la identidad, el HOME y los archivos siguen existiendo.

Cuando Trevor exista, conserve su HOME y la contraseña esté bloqueada, pulsa
**CHECK**.
