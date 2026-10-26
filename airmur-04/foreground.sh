#!/usr/bin/env bash
set -u

printf 'Preparando identidades, Samba, CUPS y Cockpit'
for _ in $(seq 1 240); do
  if [[ -e /var/lib/airmur04-ready ]]; then
    printf '\nAIRMUR 04 preparado. Puedes comenzar.\n'
    exit 0
  fi
  if [[ -e /var/lib/airmur04-failed ]]; then
    printf '\nLa preparación falló. Ejecuta: tail -n 80 /var/log/airmur04-bootstrap.log\n'
    exit 1
  fi
  printf '.'
  sleep 1
done
printf '\nLa preparación sigue en curso. Revisa /var/log/airmur04-bootstrap.log\n'
exit 1

