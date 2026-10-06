# Llega Laura

La empresa sigue creciendo. Laura trabaja en Administración y necesita una
cuenta independiente.

Crea el usuario `laura` con HOME `/home/laura`:

```bash
adduser laura
```{{copy}}

Después compara los dos perfiles:

```bash
getent passwd pablo
getent passwd laura
ls -ld /home/pablo /home/laura
```{{exec}}

Es el mismo servidor, pero cada persona tiene su identidad y espacio personal.
Cuando Laura exista y su HOME le pertenezca, pulsa **CHECK**.

