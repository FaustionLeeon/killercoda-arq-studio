# 👥 Las pandillas del aeropuerto

**07:38.**

Tu jefe observa la lista de usuarios.

—Esto no puede funcionar así. No quiero administrar a 200 personas una por
una.

Correcto. Para eso existen los **grupos**: las pandillas de Linux.

Representaremos cuatro departamentos:

- `operaciones`
- `mantenimiento`
- `administracion`
- `sistemas`

Crea los grupos con `groupadd`:

```bash
groupadd operaciones
groupadd mantenimiento
groupadd administracion
groupadd sistemas
```

Después añade cada trabajador a su departamento:

- Lucas → `operaciones`
- Marta → `mantenimiento`
- Elena → `administracion`
- Raúl → `sistemas`

Usa `usermod -aG grupo usuario`. La opción `-aG` añade un grupo secundario sin
eliminar los que el usuario ya tenía.

Comprueba el resultado con `groups` e `id`:

```bash
groups lucas
id lucas
```

Cuando los cuatro trabajadores estén en su pandilla correspondiente, pulsa
**CHECK**.
