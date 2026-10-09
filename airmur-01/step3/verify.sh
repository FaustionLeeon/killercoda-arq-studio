#!/bin/bash
set -u

for usuario in lucas marta elena raul; do
  getent passwd "$usuario" >/dev/null || {
    echo "❌ No existe el usuario $usuario."
    exit 1
  }

  home="$(getent passwd "$usuario" | cut -d: -f6)"
  [ "$home" = "/home/$usuario" ] || {
    echo "❌ El HOME registrado de $usuario no es /home/$usuario."
    exit 1
  }

  [ -d "/home/$usuario" ] || {
    echo "❌ $usuario existe, pero no encuentro /home/$usuario."
    exit 1
  }
done

echo "✅ Todos los trabajadores tienen ya identidad y HOME."
