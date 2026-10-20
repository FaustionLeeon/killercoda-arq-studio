#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

# Killercoda ejecuta CHECK en un proceso separado de la terminal del alumno.
# Guardamos el resultado para que pueda consultarse aunque la interfaz solo
# muestre el botón naranja.
exec > >(tee /tmp/airmur-mision2.log) 2>&1

role_dc() { timeout 5s testparm -s --parameter-name='server role' 2>/dev/null | grep -Fqi 'active directory domain controller'; }
domain_name() {
  timeout 8s samba-tool domain info 127.0.0.1 2>/dev/null |
    grep -Eqi '^[[:space:]]*Domain[[:space:]]*:[[:space:]]*ad\.airmur\.test[[:space:]]*$'
}
dns_ldap() { dig +time=2 +tries=1 +short @127.0.0.1 SRV _ldap._tcp.ad.airmur.test | grep -Fqi 'airmur-dc.ad.airmur.test'; }
dns_kerberos() { dig +time=2 +tries=1 +short @127.0.0.1 SRV _kerberos._udp.ad.airmur.test | grep -Fqi 'airmur-dc.ad.airmur.test'; }
kerberos_ticket() {
  local cache

  # Primero prueba el almacén predeterminado del proceso CHECK.
  if timeout 5s klist 2>/dev/null | grep -Fq '@AD.AIRMUR.TEST'; then
    return 0
  fi

  # La terminal y CHECK no siempre heredan KRB5CCNAME. En Ubuntu, kinit suele
  # guardar el ticket en /tmp/krb5cc_UID. Buscamos esos almacenes reales y
  # exigimos que uno contenga un ticket del realm de AIRMUR todavía válido.
  for cache in /tmp/krb5cc_*; do
    [ -f "$cache" ] || continue
    if timeout 5s klist -c "FILE:$cache" -s 2>/dev/null &&
       timeout 5s klist -c "FILE:$cache" 2>/dev/null | grep -Fq '@AD.AIRMUR.TEST'; then
      return 0
    fi
  done

  return 1
}

echo '=== COMPROBACIÓN MISIÓN 2 ==='
echo 'Revisando Samba, DNS, Kerberos y la base del directorio...'
echo 'Si CHECK no avanza, ejecuta: cat /tmp/airmur-mision2.log'
check 'Servicio samba-ad-dc activo' systemctl is-active --quiet samba-ad-dc
check 'Rol AD DC configurado' role_dc
check 'Dominio ad.airmur.test operativo' domain_name
check 'Base sam.ldb real presente' test -s "$samdb"
check 'DNS SRV LDAP correcto' dns_ldap
check 'DNS SRV Kerberos correcto' dns_kerberos
contains 'Realm Kerberos configurado' 'AD.AIRMUR.TEST' grep default_realm /etc/krb5.conf
check 'Ticket Kerberos válido' kerberos_ticket
check 'Comprobación interna de la base' timeout 20s samba-tool dbcheck --cross-ncs

mark_and_finish 2 15 'RA3.a · RA3.b · RA3.e'
