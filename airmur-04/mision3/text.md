# Misión 3 — El manifiesto compartido

La configuración candidata ya existe, pero todavía no se ha activado. Revísala antes de publicarla:

`sed -n '1,220p' /etc/airmur04/smb-standalone.conf.staged`{{exec}}

Comprueba que no hay `guest ok = yes`, que cada share tiene `valid users` y que la escritura está limitada mediante `write list`. Después actívala:

`sudo /opt/airmur04/activate-samba.sh && testparm -s`{{exec}}

El activador guarda copia de `smb.conf`, usa un `include` y se niega a pisar shares AIRMUR preexistentes.

**Evidencia:** CE 4.b, 4.c y 4.f.

