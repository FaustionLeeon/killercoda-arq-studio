# Misión 4 — Los ordenadores también tienen identidad

**CE: RA3.h. Evidencia parcial de RA2.c en Killercoda.**

## 11:00 — El ordenador misterioso de la puerta 7

—Un usuario se autentica y ya está —dice el director.

—También debemos saber qué ordenador está hablando con el dominio.

—¿Los ordenadores tienen cuenta?

—Sí. Y, a diferencia de algunos empleados, cambian su contraseña automáticamente.

Una cuenta de equipo es un objeto real del directorio. Su nombre de inicio suele terminar en `$` y mantiene un secreto de máquina. Crear el objeto no equivale, por sí solo, a unir un sistema operativo.

## 1. Crea dos cuentas `computer` reales

```bash
samba-tool computer add AIRMUR-PC01 --description='Puesto de facturación 01'
samba-tool computer add AIRMUR-PC02 --description='Puesto de embarque 02'
samba-tool user enable 'AIRMUR-PC01$'
samba-tool user enable 'AIRMUR-PC02$'
```{{exec}}

Una cuenta precreada puede aparecer inicialmente deshabilitada porque todavía no existe un equipo que haya establecido su secreto de unión. En este laboratorio se habilita para practicar su ciclo administrativo; esto no convierte el objeto en un cliente unido.

## 2. Examina los objetos

`samba-tool computer list`{{exec}}

`samba-tool computer show AIRMUR-PC01`{{exec}}

`samba-tool computer show AIRMUR-PC02`{{exec}}

Comprueba `objectClass: computer`, `sAMAccountName: AIRMUR-PC01$` y `userAccountControl`.

## 3. Practica el ciclo de deshabilitación

En Samba 4.19 no existe un subcomando documentado `computer disable`. Los objetos de equipo heredan de la clase `user`, por lo que el laboratorio prueba el subcomando general:

```bash
samba-tool user disable 'AIRMUR-PC02$'
airmur-registra-ciclo-equipo AIRMUR-PC02
samba-tool user enable 'AIRMUR-PC02$'
```{{exec}}

Después confirma que vuelve a estar habilitado:

`samba-tool computer show AIRMUR-PC02 | grep userAccountControl`{{exec}}

## Límite obligatorio

Estas son cuentas reales, pero Killercoda solo ofrece un nodo Ubuntu en este backend. El botón **CHECK** no afirmará que PC01 y PC02 estén unidos. Esa evidencia se obtiene en VirtualBox ejecutando `realm join` desde dos máquinas separadas.
