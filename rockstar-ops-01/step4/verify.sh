#!/bin/bash
set -u

fail() { echo "❌ $1"; exit 1; }

getent passwd jason >/dev/null || fail "No existe el usuario real jason."
[ -d /home/jason/GTAVI ] || fail "Antes debe existir /home/jason/GTAVI."
[ -f /home/jason/.bashrc ] || fail "No existe /home/jason/.bashrc."
grep -Eq "^[[:space:]]*alias[[:space:]]+gtavi='cd ~/GTAVI'[[:space:]]*$" /home/jason/.bashrc || fail "Falta el alias exacto: alias gtavi='cd ~/GTAVI'."
resolved="$(su - jason -c "bash -ic 'gtavi; pwd'" 2>/dev/null | tail -n 1)"
[ "$resolved" = "/home/jason/GTAVI" ] || fail "El alias existe, pero no lleva a /home/jason/GTAVI."

echo "✅ El perfil de Jason contiene un alias exacto y funcional."
