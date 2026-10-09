# 🧭 ¿Dónde demonios estoy?

Tu jefe se marcha y te deja solo delante de una terminal.

Magnífico.

Antes de tocar nada necesitas aprender tres preguntas fundamentales.

## ¿Quién soy?

Ejecuta:

`whoami`

## ¿Dónde estoy?

Ejecuta:

`pwd`

`pwd` significa **Print Working Directory**. Te dice exactamente en qué
directorio estás.

## ¿Qué hay aquí?

Ejecuta:

`ls`

Ahora ve al directorio donde Linux guarda normalmente los espacios personales
de los usuarios:

`cd /home`

Comprueba dónde estás con `pwd` y mira qué contiene con `ls`.

## Rutas

`/home` es una **ruta absoluta**: empieza desde `/`, la raíz del sistema.

Vuelve un nivel hacia atrás usando `cd ..`, comprueba dónde has terminado y
regresa después a `/home`.

## Tu misión

Cuando estés en `/home`, crea allí un archivo usando una **ruta relativa**:

`touch ubicacion_comprobada`

Comprueba el resultado con `ls` y pulsa **CHECK**.
