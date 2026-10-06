# Miguel deja ARQ Studio

Miguel, el comercial, abandona la empresa. Sus documentos pueden ser
importantes, por lo que **no debes eliminar la cuenta ni su HOME**. Pero ya no
debe poder autenticarse con su contraseña.

Primero crea la cuenta `miguel`:

```bash
adduser miguel
```{{copy}}

Luego bloquea su contraseña:

```bash
passwd -l miguel
```{{copy}}

Comprueba el estado:

```bash
passwd -S miguel
ls -ld /home/miguel
```{{exec}}

En la salida de `passwd -S`, la letra `L` significa **Locked**. Cuando la cuenta
exista, conserve su HOME y esté bloqueada, pulsa **CHECK**.

