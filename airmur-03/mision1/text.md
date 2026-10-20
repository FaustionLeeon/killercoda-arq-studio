# Misión 1 — El servidor central

**CE principal: RA3.d — Se ha realizado la instalación del servicio de directorio.**

## 08:35 — Una máquina con complejo de recepcionista

—Este Ubuntu ya es un servidor, ¿no? —pregunta el director.

—Sí.

—Entonces ya controla a todos los usuarios.

—No.

—Qué poco intuitivo es esto de la informática.

Un Ubuntu Server normal no se convierte en controlador de dominio por llevar la palabra «Server». Primero hay que darle un nombre estable, preparar DNS e instalar el software de Samba AD.

## 1. Identifica el sistema

`cat /etc/os-release`{{exec}}

`hostnamectl`{{exec}}

Killercoda utiliza Ubuntu 24.04. La IP del único nodo es `172.30.1.2`.

## 2. Asigna el nombre completo

`hostnamectl set-hostname airmur-dc.ad.airmur.test`{{exec}}

Añade la resolución local si todavía no existe:

`grep -Fq 'airmur-dc.ad.airmur.test' /etc/hosts || echo '172.30.1.2 airmur-dc.ad.airmur.test airmur-dc' >> /etc/hosts`{{exec}}

Comprueba:

`hostname -f && getent hosts airmur-dc.ad.airmur.test`{{exec}}

## 3. Instala el servicio de directorio

```bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  samba-ad-dc krb5-user bind9-dnsutils dnsutils ldb-tools smbclient
```{{exec}}

- `samba-ad-dc` aporta el controlador de dominio.
- `krb5-user` aporta `kinit` y `klist` para Kerberos.
- `bind9-dnsutils` y `dnsutils` permiten consultar DNS.
- `ldb-tools` permite inspeccionar la base del directorio.
- `smbclient` permite probar los recursos de Samba.

## 4. Separa el servicio AD de los servicios Samba normales

```bash
systemctl disable --now smbd nmbd winbind
systemctl mask smbd nmbd winbind
systemctl unmask samba-ad-dc
systemctl enable samba-ad-dc
```{{exec}}

El DC utiliza la unidad conjunta `samba-ad-dc`. No debe arrancarse como tres servicios independientes.

Aparta la configuración genérica para que el aprovisionador pueda crear una nueva:

`[ ! -f /etc/samba/smb.conf ] || mv /etc/samba/smb.conf /etc/samba/smb.conf.orig`{{exec}}

Pulsa **CHECK**. Todavía no debes crear el dominio: eso ocurrirá en la misión 2.
