#!/usr/bin/env bash

puntos=0
total=10

ok() {
    printf '✅ %s\n' "$1"
    puntos=$((puntos + 1))
}

fail() {
    printf '❌ %s\n' "$1"
}

printf '%s\n' '============================================'
printf '%s\n' '       COMPROBACIÓN ARQ STUDIO 01'
printf '%s\n\n' '============================================'

if id pablo >/dev/null 2>&1; then
    ok 'El usuario pablo existe'
else
    fail 'El usuario pablo no existe'
fi

if id laura >/dev/null 2>&1; then
    ok 'El usuario laura existe'
else
    fail 'El usuario laura no existe'
fi

if id sara >/dev/null 2>&1; then
    ok 'El usuario sara existe'
else
    fail 'El usuario sara no existe'
fi

if [ -d /home/pablo/PROYECTOS ]; then
    ok '/home/pablo/PROYECTOS existe'
else
    fail 'Falta /home/pablo/PROYECTOS'
fi

if [ -f /home/pablo/PROYECTOS/vivienda_murcia.txt ]; then
    ok 'vivienda_murcia.txt existe'
else
    fail 'Falta vivienda_murcia.txt'
fi

if grep -Eq '(^|[[:space:]])alias[[:space:]]+proyecto=' /home/pablo/.bashrc 2>/dev/null; then
    ok 'El alias proyecto está en /home/pablo/.bashrc'
else
    fail 'Falta alias proyecto= en /home/pablo/.bashrc'
fi

if id miguel >/dev/null 2>&1; then
    ok 'El usuario miguel existe'
else
    fail 'El usuario miguel no existe'
fi

estado_miguel=$(passwd -S miguel 2>/dev/null | awk '{print $2}')
if [ "$estado_miguel" = 'L' ] || [ "$estado_miguel" = 'LK' ]; then
    ok 'El usuario miguel está bloqueado'
else
    fail 'El usuario miguel no está bloqueado'
fi

if [ -d /home/sara/PROYECTOS ]; then
    ok '/home/sara/PROYECTOS existe'
else
    fail 'Falta /home/sara/PROYECTOS'
fi

if [ -f /home/sara/PROYECTOS/museo_murcia.txt ]; then
    ok 'museo_murcia.txt existe'
else
    fail 'Falta museo_murcia.txt'
fi

printf '\n%s\n' '--------------------------------------------'
printf 'TOTAL DE PUNTOS: %d / %d\n' "$puntos" "$total"
printf 'NOTA FINAL: %d / 10\n\n' "$puntos"

if [ "$puntos" -ge 9 ]; then
    printf '%s\n' '🌟 SOBRESALIENTE'
elif [ "$puntos" -ge 7 ]; then
    printf '%s\n' '👍 NOTABLE'
elif [ "$puntos" -ge 5 ]; then
    printf '%s\n' '✅ APROBADO'
else
    printf '%s\n' '❌ NO SUPERADO'
fi

printf '%s\n' '============================================'
