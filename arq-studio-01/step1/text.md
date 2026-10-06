# Mañana empieza Pablo

Carmen, directora de ARQ Studio, entra en tu despacho:

> Mañana empieza Pablo García, nuestro nuevo arquitecto. Necesito que tenga una
> cuenta y un espacio personal en el servidor.

Crea el usuario `pablo` con su directorio personal. En este laboratorio ya eres
administrador, así que no necesitas escribir `sudo`.

Puedes usar el asistente de Ubuntu:

```bash
adduser pablo
```{{copy}}

Elige una contraseña temporal. Los demás datos son opcionales: puedes pulsar
Intro para dejarlos vacíos y confirmar al final con `Y`.

Comprueba el resultado:

```bash
id pablo
getent passwd pablo
ls -ld /home/pablo
```{{copy}}

Cuando la cuenta exista, su HOME sea `/home/pablo` y la carpeta pertenezca a
Pablo, pulsa **CHECK**.

