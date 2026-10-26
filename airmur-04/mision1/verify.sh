#!/usr/bin/env bash
set -u
pre=/root/airmur04/evidencias/prerrequisitos.txt
con=/root/airmur04/evidencias/conceptos.txt
[[ -s $pre ]] || { echo 'Falta ejecutar el verificador de prerrequisitos.'; exit 1; }
grep -q '^MODO=SIMULADO_STANDALONE' "$pre" || { echo 'No se ha identificado el alcance simulado.'; exit 1; }
grep -q 'SUMMARY.*FAIL=0' "$pre" || { echo 'Hay prerrequisitos fallidos.'; exit 1; }
[[ -s $con ]] || { echo 'Falta conceptos.txt.'; exit 1; }
perm=$(awk -F= '/^PERMISO=/{sub(/^PERMISO=/,""); print}' "$con")
right=$(awk -F= '/^DERECHO=/{sub(/^DERECHO=/,""); print}' "$con")
((${#perm} >= 20 && ${#right} >= 20)) || { echo 'Explica ambos conceptos con un ejemplo (mínimo 20 caracteres cada uno).'; exit 1; }
echo 'Misión 1 superada: alcance y conceptos documentados.'

