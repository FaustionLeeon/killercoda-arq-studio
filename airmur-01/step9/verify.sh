#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

getent passwd nora >/dev/null || fail "Nora todavía no existe."

home="$(getent passwd nora | cut -d: -f6)"
[ "$home" = "/home/nora" ] || fail "El HOME registrado de Nora debe ser /home/nora."
[ -d /home/nora ] || fail "Nora no tiene su directorio HOME."

id -nG nora | tr ' ' '\n' | grep -qx operaciones || fail "Nora no pertenece a operaciones."

[ -d /home/nora/INCIDENCIAS ] || fail "Falta la carpeta INCIDENCIAS."
[ -f /home/nora/INCIDENCIAS/primer_turno.txt ] || fail "Falta primer_turno.txt."

[ "$(stat -c '%U' /home/nora/INCIDENCIAS)" = "nora" ] || fail "INCIDENCIAS no pertenece a Nora."
[ "$(stat -c '%G' /home/nora/INCIDENCIAS)" = "nora" ] || fail "El grupo de INCIDENCIAS no es nora."
[ "$(stat -c '%U' /home/nora/INCIDENCIAS/primer_turno.txt)" = "nora" ] || fail "primer_turno.txt no pertenece a Nora."
[ "$(stat -c '%G' /home/nora/INCIDENCIAS/primer_turno.txt)" = "nora" ] || fail "El grupo de primer_turno.txt no es nora."

[ -f /home/nora/.bashrc ] || fail "No encuentro el .bashrc de Nora."
grep -Fxq "alias incidencias='cd ~/INCIDENCIAS'" /home/nora/.bashrc || fail "El alias incidencias no está configurado exactamente como se pide."

echo "✅ MISIÓN SUPERADA."
echo "🛫 El aeropuerto está preparado para comenzar el turno."
