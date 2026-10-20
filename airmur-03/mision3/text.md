# Misión 3 — Los trabajadores ya no viven en cada ordenador

**CE: RA3.e y RA3.h. Refuerzo de RA2.a, RA2.d, RA2.e y RA2.f.**

## 10:05 — Lucas existe, pero solo en el ordenador de Lucas

—Tenemos una cuenta `lucas` en un servidor —dice el director—. Problema resuelto.

—Esa es una cuenta local. El dominio todavía no sabe quién es Lucas.

—¿Hay dos Lucas?

—Solo uno. Pero ahora mismo tenemos dos sitios distintos donde alguien podría escribir su nombre y una contraseña.

Una cuenta local pertenece a una máquina. Una cuenta de dominio se guarda en el servicio de directorio y puede ser reconocida por equipos unidos.

## 1. Crea los grupos del dominio

```bash
for grupo in operaciones mantenimiento administracion sistemas; do
  samba-tool group add "$grupo"
done
```{{exec}}

## 2. Crea los usuarios del dominio

Esta contraseña es pública y solo se permite porque el laboratorio es efímero:

```bash
for usuario in lucas marta elena raul nora; do
  samba-tool user add "$usuario" 'Airmur-Lab-2026!'
done
```{{exec}}

## 3. Asigna cada trabajador

```bash
samba-tool group addmembers operaciones lucas
samba-tool group addmembers administracion marta
samba-tool group addmembers mantenimiento elena
samba-tool group addmembers sistemas raul,nora
```{{exec}}

## 4. Consulta objetos reales

`samba-tool user show lucas`{{exec}}

`samba-tool user getgroups lucas`{{exec}}

`samba-tool group listmembers sistemas`{{exec}}

Observa `dn`, `objectClass`, `sAMAccountName` y la pertenencia a grupos. Pulsa **CHECK**.
