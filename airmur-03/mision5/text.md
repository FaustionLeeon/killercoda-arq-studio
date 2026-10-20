# Misión 5 — Cada departamento en su sitio

**CE: RA3.f y RA3.g.**

## 12:00 — La carpeta llamada «cosas importantes»

El director enseña su propuesta de estructura:

—He pensado meterlo todo en una carpeta llamada `COSAS_IMPORTANTES_FINAL_AHORA_SI`.

Silencio administrativo.

Las **unidades organizativas (OU)** ordenan objetos y permiten delegar administración o aplicar políticas. Los **grupos** reúnen identidades para conceder acceso. Una OU no sustituye a un grupo.

## 1. Crea el árbol administrativo

```bash
samba-tool ou add 'OU=AIRMUR'
samba-tool ou add 'OU=Usuarios,OU=AIRMUR'
samba-tool ou add 'OU=Equipos,OU=AIRMUR'
samba-tool ou add 'OU=Grupos,OU=AIRMUR'
samba-tool ou add 'OU=Operaciones,OU=Usuarios,OU=AIRMUR'
samba-tool ou add 'OU=Mantenimiento,OU=Usuarios,OU=AIRMUR'
samba-tool ou add 'OU=Administracion,OU=Usuarios,OU=AIRMUR'
samba-tool ou add 'OU=Sistemas,OU=Usuarios,OU=AIRMUR'
```{{exec}}

## 2. Mueve usuarios, grupos y equipos

```bash
samba-tool user move lucas 'OU=Operaciones,OU=Usuarios,OU=AIRMUR'
samba-tool user move marta 'OU=Administracion,OU=Usuarios,OU=AIRMUR'
samba-tool user move elena 'OU=Mantenimiento,OU=Usuarios,OU=AIRMUR'
samba-tool user move raul 'OU=Sistemas,OU=Usuarios,OU=AIRMUR'
samba-tool user move nora 'OU=Sistemas,OU=Usuarios,OU=AIRMUR'

for grupo in operaciones mantenimiento administracion sistemas; do
  samba-tool group move "$grupo" 'OU=Grupos,OU=AIRMUR'
done

samba-tool computer move AIRMUR-PC01 'OU=Equipos,OU=AIRMUR'
samba-tool computer move AIRMUR-PC02 'OU=Equipos,OU=AIRMUR'
```{{exec}}

## 3. Analiza la estructura

`samba-tool ou list --full-dn`{{exec}}

`samba-tool ou listobjects 'OU=AIRMUR' --full-dn --recursive`{{exec}}

## 4. Justifica el modelo

```bash
install -m 0600 /root/airmur03/plantillas/modelo-ou.md /root/airmur03/evidencias/modelo-ou.md
nano /root/airmur03/evidencias/modelo-ou.md
```{{exec}}

Redacta al menos 80 palabras y explica expresamente las diferencias entre OU y grupo, la delegación y las políticas. El corrector combina el análisis con la estructura real; el texto por sí solo no aprueba.

Sustituye y elimina todas las líneas `COMPLETA-AQUI`. La plantilla sin redactar no supera la misión.
