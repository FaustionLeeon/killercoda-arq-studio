# 👷 Llegan los trabajadores

**07:20.**

Recibes un correo de Recursos Humanos. Hoy se incorporan cuatro trabajadores:

- Lucas — Operaciones
- Marta — Mantenimiento
- Elena — Administración
- Raúl — Sistemas

Linux es multiusuario. Eso significa que cada trabajador puede tener su propia
identidad dentro del mismo servidor.

Para crear un usuario utilizamos `adduser`.

Crea las cuatro cuentas:

```bash
adduser lucas
adduser marta
adduser elena
adduser raul
```

Usa una contraseña de laboratorio. **No utilices ninguna contraseña real.**
Puedes dejar vacíos los datos opcionales pulsando `Intro`.

Comprueba las identidades:

```bash
id lucas
id marta
id elena
id raul
```

Después ejecuta `ls /home`. Deberían existir `/home/lucas`, `/home/marta`,
`/home/elena` y `/home/raul`.

Cuando estén las cuatro cuentas, pulsa **CHECK**.
