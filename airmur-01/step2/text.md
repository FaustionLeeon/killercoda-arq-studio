# 🗂️ Prepara el centro de operaciones

Tu jefe vuelve.

—Necesitamos una zona en el servidor para guardar los partes de turno.

Vamos a crearla. Debes conseguir esta estructura:

```text
/srv/aeropuerto/
└── turnos/
    └── parte_inicio.txt
```

Desde cualquier sitio puedes crear los directorios usando una **ruta absoluta**:

`mkdir -p /srv/aeropuerto/turnos`

Ahora entra en el nuevo directorio:

`cd /srv/aeropuerto/turnos`

Comprueba tu ubicación con `pwd` y crea el primer parte con una **ruta
relativa**:

`touch parte_inicio.txt`

Comprueba el resultado con `ls` y pulsa **CHECK**.
