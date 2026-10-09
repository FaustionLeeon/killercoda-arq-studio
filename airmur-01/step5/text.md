# 📄 ¿De quién es este archivo?

El departamento de Operaciones necesita este documento:

`/srv/aeropuerto/turnos/plan_turnos.txt`

Créalo:

`touch /srv/aeropuerto/turnos/plan_turnos.txt`

Mira quién es ahora su propietario:

`ls -l /srv/aeropuerto/turnos/plan_turnos.txt`

Como tú lo has creado, probablemente aparece `root`. Pero el responsable del
documento será Lucas.

Cambia el propietario con `chown`:

`chown lucas:lucas /srv/aeropuerto/turnos/plan_turnos.txt`

Vuelve a comprobarlo con `ls -l`. Cuando el archivo pertenezca a Lucas, pulsa
**CHECK**.
