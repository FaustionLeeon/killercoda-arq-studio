#!/bin/bash
set -u

getent passwd lucas >/dev/null || {
  echo "❌ El usuario lucas no existe."
  exit 1
}

getent passwd proveedor >/dev/null || {
  echo "❌ El usuario proveedor no existe."
  exit 1
}

estado_lucas="$(passwd -S lucas | awk '{print $2}')"
estado_proveedor="$(passwd -S proveedor | awk '{print $2}')"

if [ "$estado_lucas" != "P" ]; then
  echo "❌ Lucas no tiene una contraseña activa."
  exit 1
fi

if [ "$estado_proveedor" != "L" ]; then
  echo "❌ La cuenta proveedor todavía no está bloqueada."
  exit 1
fi

echo "✅ Credenciales gestionadas correctamente."
