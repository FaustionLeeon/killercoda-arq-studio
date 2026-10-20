# Misión 2 — Nace el dominio AIRMUR

**CE: RA3.a, RA3.b y RA3.e.**

## 09:20 — Bautizar un dominio sin comprar una web

—¿`ad.airmur.test` será nuestra nueva página web? —pregunta Marta.

—No. Es el nombre DNS del dominio interno.

—¿Y Kerberos?

—El portero que pide credenciales sin guardar tu contraseña debajo del teclado.

Conceptos esenciales:

- **servicio de directorio:** base organizada de identidades y recursos;
- **dominio:** límite administrativo común para usuarios, equipos y políticas;
- **controlador de dominio:** servidor que mantiene el directorio y autentica;
- **DNS:** permite localizar controladores y servicios mediante nombres y registros SRV;
- **Kerberos:** protocolo que entrega tickets después de comprobar la identidad.

## 1. Aprovisiona el dominio real

Ejecuta:

```bash
samba-tool domain provision --domain=AIRMUR --realm=AD.AIRMUR.TEST --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL
```{{exec}}

Cuando pida la contraseña de Administrator, usa una contraseña exclusivamente de laboratorio, por ejemplo `Airmur-Admin-2026!`. No reutilices una contraseña real.

> No pulses **CHECK** todavía. Aprovisionar crea el dominio, pero aún debes completar los pasos 2, 3 y 4 de esta misión.

## 2. Configura el DNS del propio DC

El DNS interno de Samba debe responder en el servidor. Configura un reenviador externo de laboratorio:

`sed -i 's/^[[:space:]]*dns forwarder =.*/\tdns forwarder = 1.1.1.1/' /etc/samba/smb.conf`{{exec}}

Haz que el DC se consulte a sí mismo:

```bash
systemctl disable --now systemd-resolved
rm -f /etc/resolv.conf
printf 'nameserver 127.0.0.1\nsearch ad.airmur.test\n' > /etc/resolv.conf
cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
systemctl restart samba-ad-dc
```{{exec}}

## 3. Verifica servicio, dominio y DNS

`systemctl --no-pager --full status samba-ad-dc`{{exec}}

`samba-tool domain info 127.0.0.1`{{exec}}

`samba-tool domain level show`{{exec}}

`dig +short @127.0.0.1 SRV _ldap._tcp.ad.airmur.test`{{exec}}

`dig +short @127.0.0.1 SRV _kerberos._udp.ad.airmur.test`{{exec}}

## 4. Obtén un ticket Kerberos

`kinit Administrator@AD.AIRMUR.TEST`{{exec}}

Introduce la contraseña del laboratorio y después comprueba:

`klist`{{exec}}

Pulsa **CHECK** solamente cuando DNS, Kerberos y el dominio respondan. La comprobación puede tardar unos segundos y siempre mostrará qué está correcto y qué falta.

Si el botón vuelve a ponerse naranja, consulta el informe detallado con:

`cat /tmp/airmur-mision2.log`{{exec}}

El informe marcará con `✅` lo que funciona y con `❌` el requisito concreto que todavía falta. El verificador busca también el ticket Kerberos creado por `kinit` aunque Killercoda ejecute **CHECK** en un proceso separado de tu terminal.
