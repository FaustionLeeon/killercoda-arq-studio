#!/bin/bash
set -u
source /usr/local/lib/airmur03-verify-common.sh

role_dc() { timeout 5s testparm -s --parameter-name='server role' 2>/dev/null | grep -Fqi 'active directory domain controller'; }
domain_name() { timeout 8s samba-tool domain info 127.0.0.1 2>/dev/null | grep -Fqi 'Domain : ad.airmur.test'; }
dns_ldap() { dig +time=2 +tries=1 +short @127.0.0.1 SRV _ldap._tcp.ad.airmur.test | grep -Fqi 'airmur-dc.ad.airmur.test'; }
dns_kerberos() { dig +time=2 +tries=1 +short @127.0.0.1 SRV _kerberos._udp.ad.airmur.test | grep -Fqi 'airmur-dc.ad.airmur.test'; }
kerberos_ticket() { klist -s && klist 2>/dev/null | grep -Fq '@AD.AIRMUR.TEST'; }

echo '=== COMPROBACIÓN MISIÓN 2 ==='
echo 'Revisando Samba, DNS, Kerberos y la base del directorio...'
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
