#!/usr/bin/env bash
set -euo pipefail
f=/root/acta-capitulo1.md
[[ -s "$f" ]] || { echo 'Crea el acta /root/acta-capitulo1.md'; exit 1; }
for t in '## Arquitectura' '## Archivos de la aplicación' '## Requisitos para publicar' '## Comandos utilizados' '## Pruebas realizadas' '## Comparación Nginx normal y Docker'; do grep -Fq "$t" "$f" || { echo "Falta la sección: $t"; exit 1; }; done
if grep -Eq '\[explica aquí|\[escribe aquí|\[resume los|\[describe tus|\[explica una' "$f"; then echo 'Aún tienes textos entre corchetes sin completar'; exit 1; fi
echo '✅ Acta completa en estructura; el profesor evaluará si el contenido es correcto.'
