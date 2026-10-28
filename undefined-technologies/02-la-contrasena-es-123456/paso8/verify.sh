#!/usr/bin/env bash
set -euo pipefail
f=/root/acta-capitulo2.md
[[ -s "$f" ]] || { echo 'Falta /root/acta-capitulo2.md'; exit 1; }
for t in '## Dos sitios virtuales' '## Archivo de autenticación' '## Certificado y HTTPS' '## Pruebas HTTP' '## Registros de seguridad' '## Recomendaciones para producción'; do grep -Fq "$t" "$f" || { echo "Falta $t"; exit 1; }; done
if grep -Eq '\[explica |\[qué encontraste|\[escribe tres' "$f"; then echo 'Quedan respuestas entre corchetes sin completar'; exit 1; fi
echo '✅ Informe terminado formalmente; la calidad la revisará el profesor.'
