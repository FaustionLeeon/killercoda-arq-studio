# Lucia se incorpora

Lucia se une al equipo. Trabajará en el mismo servidor, pero necesita una cuenta
y un perfil completamente independientes.

```bash
adduser lucia
```{{copy}}

Completa el asistente y compara después las dos identidades:

```bash
id lucia
getent passwd lucia
ls -ld /home/jason /home/lucia
```{{copy}}

Si quieres comprobar su punto de partida, puedes entrar brevemente como Lucia:

```bash
su - lucia
pwd
exit
```{{copy}}

**Mismo servidor, usuarios distintos, HOME distintos y configuraciones
distintas.** Cuando `/home/lucia` exista y pertenezca a Lucia, pulsa **CHECK**.
