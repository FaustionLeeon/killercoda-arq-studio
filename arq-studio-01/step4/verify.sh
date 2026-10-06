#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

[ -f /home/pablo/.bashrc ] || fail "No existe /home/pablo/.bashrc."
grep -Eq "^[[:space:]]*alias[[:space:]]+proyecto='cd ~/PROYECTOS'[[:space:]]*$" /home/pablo/.bashrc || fail "Falta el alias exacto en el .bashrc de pablo."

resolved="$(su - pablo -c "bash -ic 'proyecto; pwd'" 2>/dev/null | tail -n 1)"
[ "$resolved" = "/home/pablo/PROYECTOS" ] || fail "El alias proyecto todavía no lleva al directorio esperado."

echo "✅ El perfil de Pablo contiene un alias funcional."

