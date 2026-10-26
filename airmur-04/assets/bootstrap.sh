#!/usr/bin/env bash
set -Eeuo pipefail
export DEBIAN_FRONTEND=noninteractive
PASSWORD='Airmur04!Lab'

missing=()
for package in acl attr samba smbclient cups cups-client cockpit; do
  dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'install ok installed' || missing+=("$package")
done
if ((${#missing[@]})); then
  apt-get update
  apt-get install -y --no-install-recommends "${missing[@]}"
fi
if apt-cache show cockpit-files >/dev/null 2>&1; then
  dpkg-query -W -f='${Status}' cockpit-files 2>/dev/null | grep -q 'install ok installed' || apt-get install -y --no-install-recommends cockpit-files
  printf 'available\n' >/var/lib/airmur04-cockpit-files.status
else
  printf 'unavailable\n' >/var/lib/airmur04-cockpit-files.status
fi

for group in air_ops air_security air_it; do getent group "$group" >/dev/null || groupadd "$group"; done
for pair in lucas:air_ops marta:air_ops elena:air_security raul:air_security nora:air_it; do
  user=${pair%%:*}; group=${pair#*:}; created=0
  if ! getent passwd "$user" >/dev/null; then
    useradd -m -s /bin/bash "$user"
    printf '%s:%s\n' "$user" "$PASSWORD" | chpasswd
    created=1
  fi
  id -nG "$user" | tr ' ' '\n' | grep -Fxq "$group" || usermod -aG "$group" "$user"
  if ! pdbedit -L 2>/dev/null | cut -d: -f1 | grep -Fxq "$user"; then
    printf '%s\n%s\n' "$PASSWORD" "$PASSWORD" | smbpasswd -s -a "$user" >/dev/null
    smbpasswd -e "$user" >/dev/null
  fi
done

install -d -m 0750 /etc/airmur04 /root/airmur04/evidencias /var/log/airmur04 /srv/airmur
for resource in operaciones seguridad intercambio evidencias; do
  [[ -d /srv/airmur/$resource ]] || install -d -m 0755 "/srv/airmur/$resource"
done

if [[ ! -e /etc/airmur04/smb-standalone.conf.staged ]]; then
  install -m 0640 /opt/airmur04/smb-standalone.conf /etc/airmur04/smb-standalone.conf.staged
fi

install -d -m 0755 /etc/cockpit
if [[ ! -e /etc/cockpit/cockpit.conf ]]; then
  printf '[WebService]\nAllowUnencrypted = true\n' >/etc/cockpit/cockpit.conf
fi
systemctl enable --now smbd.service cups.service cockpit.socket
touch /var/lib/airmur04-prepared

