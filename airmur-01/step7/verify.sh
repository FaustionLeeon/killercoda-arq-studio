#!/bin/bash
set -u

fail() {
  echo "❌ $1"
  exit 1
}

for grupo in operaciones mantenimiento administracion sistemas; do
  getent group "$grupo" >/dev/null || fail "Falta el grupo $grupo."
done

id -nG lucas | tr ' ' '\n' | grep -qx operaciones || fail "Lucas no pertenece a operaciones."
id -nG marta | tr ' ' '\n' | grep -qx mantenimiento || fail "Marta no pertenece a mantenimiento."
id -nG elena | tr ' ' '\n' | grep -qx administracion || fail "Elena no pertenece a administracion."
id -nG raul | tr ' ' '\n' | grep -qx sistemas || fail "Raúl no pertenece a sistemas."

echo "✅ Todos están en su pandilla correspondiente."
