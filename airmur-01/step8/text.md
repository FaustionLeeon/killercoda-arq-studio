# 🦸 Los que tienen superpoderes

Hay usuarios normales... y luego está `root`.

Ejecuta:

`id root`

Verás algo importante: `uid=0`. `root` es el superusuario de Linux y puede
prácticamente hacerlo todo.

Por eso utilizar `root` para trabajar normalmente es una idea fantástica...

si vuestro objetivo es destruir el servidor.

## También existen grupos especiales

Comprueba:

`getent group sudo`

Los usuarios del grupo `sudo` pueden ejecutar tareas administrativas de forma
controlada usando el comando `sudo`.

En nuestro aeropuerto solo Raúl, que trabaja en Sistemas, necesita esos
privilegios en esta práctica. Añádelo al grupo:

`usermod -aG sudo raul`

Compruébalo de dos formas:

```bash
groups raul
id raul
```

Raúl debe pertenecer simultáneamente a `sistemas` y `sudo`. Cuando sea así,
pulsa **CHECK**.
