# Misión 1 — La baliza fantasma

El primer indicio no está en un fichero: está en lo que este entorno **puede** y **no puede** demostrar.

Genera el inventario:

`sudo /opt/airmur04/check-prerequisites.sh`{{exec}}

Ahora crea `/root/airmur04/evidencias/conceptos.txt` con dos líneas escritas con tus palabras:

```text
PERMISO=<qué permite una ACL sobre un recurso y un ejemplo>
DERECHO=<qué capacidad administrativa o del sistema es distinta y un ejemplo>
```

`nano /root/airmur04/evidencias/conceptos.txt`{{exec}}

No afirmes que este host está unido a `ad.airmur.test`: el inventario debe decir `MODO=SIMULADO_STANDALONE`.

**Evidencia:** CE 4.a y delimitación del escenario.

