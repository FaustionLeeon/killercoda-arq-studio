# Misión 7 — La auditoría del director

**Consolidación de RA3.a, RA3.b, RA3.d, RA3.e, RA3.f, RA3.g y RA3.h.**

## 14:30 — «¿Y cómo sé que funciona?»

El director mira el terminal.

—Veo muchas letras. Algunas incluso están en mayúsculas. ¿Cómo sé que funciona?

—Auditando resultados, no contando comandos.

La auditoría revisa el estado real: servicio, rol, dominio, DNS, usuarios, grupos, cuentas de equipo, OU y planificación.

## 1. Ejecuta la auditoría

`airmur-auditoria`{{exec}}

No modifica el dominio. Cada línea indica una evidencia correcta o un fallo concreto.

## 2. Inspecciona la estructura final

`samba-tool domain info 127.0.0.1`{{exec}}

`samba-tool ou listobjects 'OU=AIRMUR' --full-dn --recursive`{{exec}}

`samba-tool computer list`{{exec}}

`samba-tool dbcheck --cross-ncs`{{exec}}

## 3. Consulta la puntuación provisional

`airmur-puntuacion`{{exec}}

Pulsa **CHECK**. El corrector vuelve a ejecutar la auditoría: no basta con haber ejecutado el comando anteriormente.
