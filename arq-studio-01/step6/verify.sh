#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd sara >/dev/null || fail "Todavía no existe el usuario sara."
home="$(getent passwd sara | cut -d: -f6)"
[ "$home" = "/home/sara" ] || fail "El HOME registrado de sara debe ser /home/sara."
[ -d /home/sara ] || fail "Falta /home/sara."
[ "$(stat -c '%U' /home/sara)" = "sara" ] || fail "/home/sara no pertenece a sara."
[ -d /home/sara/PROYECTOS ] || fail "Falta /home/sara/PROYECTOS."
[ "$(stat -c '%U' /home/sara/PROYECTOS)" = "sara" ] || fail "PROYECTOS debe pertenecer a sara."
[ -f /home/sara/PROYECTOS/museo_murcia.txt ] || fail "Falta museo_murcia.txt."
[ "$(stat -c '%U' /home/sara/PROYECTOS/museo_murcia.txt)" = "sara" ] || fail "museo_murcia.txt debe pertenecer a sara."

echo "✅ Sara está preparada. Has completado el escenario."

