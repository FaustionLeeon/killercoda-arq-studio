# Misión 2 — Los pasillos prohibidos

Cuatro carpetas ocultan cuatro niveles de acceso. Aplica la política sin recrear usuarios ni directorios:

- Operaciones: Operaciones escribe; Seguridad lee; TI escribe.
- Seguridad: Seguridad escribe; Operaciones lee; TI escribe.
- Intercambio: los tres roles escriben.
- Evidencias: solo TI.

Registra la política y aplica ACL heredables:

```bash
printf 'recurso\trol_operaciones\trol_seguridad\trol_ti\nOperaciones\trw\tr\trw\nSeguridad\tr\trw\trw\nIntercambio\trw\trw\trw\nEvidencias\t-\t-\trw\n' | sudo tee /root/airmur04/evidencias/policy.tsv
sudo /opt/airmur04/apply-acl.sh
getfacl -p /srv/airmur/operaciones
```{{exec}}

Localiza en la salida las entradas normales y las `default:`. Las segundas son las que heredarán los objetos nuevos.

**Evidencia:** CE 4.b y 4.c.

