# 🔐 Problemas con las credenciales

**07:27.**

Lucas aparece por tu despacho.

—He olvidado mi contraseña.

Lleva exactamente siete minutos trabajando aquí. Promete.

Cámbiale la contraseña con:

`passwd lucas`

Usa otra contraseña de laboratorio y comprueba el estado de la cuenta:

`passwd -S lucas`

La letra `P` indica que tiene una contraseña válida.

## Y tenemos otro problema

Crea una cuenta para un proveedor externo:

`adduser proveedor`

Justo después llega un mensaje:

> Su contrato ha terminado. No borres todavía la cuenta ni sus archivos, pero
> debe dejar de poder iniciar sesión inmediatamente.

Bloquea la cuenta:

`passwd -l proveedor`

Compruébala con `passwd -S proveedor`. La letra `L` indica que la contraseña
está bloqueada.

Cuando Lucas tenga una contraseña activa y `proveedor` exista pero esté
bloqueado, pulsa **CHECK**.
