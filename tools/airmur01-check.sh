#!/usr/bin/env bash

# Comprobador externo y de solo lectura para AIRMUR 01.
# AIRMUR_CHECK_ROOT se usa únicamente para probar el comprobador con entornos
# simulados; en Killercoda queda vacío y se inspecciona el sistema real.

puntos=0
total=0
raiz=${AIRMUR_CHECK_ROOT:-}

ruta() {
    printf '%s%s' "$raiz" "$1"
}

entrada_usuario() {
    if [ -n "$raiz" ]; then
        awk -F: -v usuario="$1" '$1 == usuario { print; exit }' "$(ruta /etc/passwd)" 2>/dev/null
    else
        getent passwd "$1" 2>/dev/null
    fi
}

entrada_grupo() {
    if [ -n "$raiz" ]; then
        awk -F: -v grupo="$1" '$1 == grupo { print; exit }' "$(ruta /etc/group)" 2>/dev/null
    else
        getent group "$1" 2>/dev/null
    fi
}

usuario_existe() {
    [ -n "$(entrada_usuario "$1")" ]
}

home_registrado() {
    local entrada
    entrada=$(entrada_usuario "$1")
    [ "$(printf '%s\n' "$entrada" | cut -d: -f6)" = "$2" ]
}

grupo_existe() {
    [ -n "$(entrada_grupo "$1")" ]
}

pertenece_grupo() {
    local usuario=$1
    local grupo=$2
    local usuario_linea grupo_linea gid_usuario gid_grupo miembros

    if [ -z "$raiz" ]; then
        id -nG "$usuario" 2>/dev/null | tr ' ' '\n' | grep -Fxq "$grupo"
        return
    fi

    usuario_linea=$(entrada_usuario "$usuario")
    grupo_linea=$(entrada_grupo "$grupo")
    [ -n "$usuario_linea" ] && [ -n "$grupo_linea" ] || return 1

    gid_usuario=$(printf '%s\n' "$usuario_linea" | cut -d: -f4)
    gid_grupo=$(printf '%s\n' "$grupo_linea" | cut -d: -f3)
    miembros=$(printf '%s\n' "$grupo_linea" | cut -d: -f4)

    [ "$gid_usuario" = "$gid_grupo" ] || printf ',%s,' "$miembros" | grep -Fq ",$usuario,"
}

estado_contrasena() {
    local usuario=$1
    local hash

    if [ -z "$raiz" ]; then
        passwd -S "$usuario" 2>/dev/null | awk '{print $2}'
        return
    fi

    hash=$(awk -F: -v usuario="$usuario" '$1 == usuario { print $2; exit }' "$(ruta /etc/shadow)" 2>/dev/null)
    case "$hash" in
        '') printf '%s\n' 'NP' ;;
        '!'*|'*'*) printf '%s\n' 'L' ;;
        *) printf '%s\n' 'P' ;;
    esac
}

uid_numerico() {
    stat -c '%u' "$1" 2>/dev/null || stat -f '%u' "$1" 2>/dev/null
}

gid_numerico() {
    stat -c '%g' "$1" 2>/dev/null || stat -f '%g' "$1" 2>/dev/null
}

propietario_nombre() {
    local uid
    uid=$(uid_numerico "$1") || return 1
    if [ -n "$raiz" ]; then
        awk -F: -v uid="$uid" '$3 == uid { print $1; exit }' "$(ruta /etc/passwd)" 2>/dev/null
    else
        getent passwd "$uid" 2>/dev/null | cut -d: -f1
    fi
}

grupo_propietario_nombre() {
    local gid
    gid=$(gid_numerico "$1") || return 1
    if [ -n "$raiz" ]; then
        awk -F: -v gid="$gid" '$3 == gid { print $1; exit }' "$(ruta /etc/group)" 2>/dev/null
    else
        getent group "$gid" 2>/dev/null | cut -d: -f1
    fi
}

comprobar() {
    local descripcion=$1
    shift
    total=$((total + 1))
    if "$@"; then
        printf '✅ %s\n' "$descripcion"
        puntos=$((puntos + 1))
    else
        printf '❌ %s\n' "$descripcion"
    fi
}

es_archivo() {
    [ -f "$(ruta "$1")" ]
}

es_directorio() {
    [ -d "$(ruta "$1")" ]
}

contrasena_es() {
    [ "$(estado_contrasena "$1")" = "$2" ]
}

propietario_es() {
    [ "$(propietario_nombre "$(ruta "$1")")" = "$2" ]
}

grupo_propietario_es() {
    [ "$(grupo_propietario_nombre "$(ruta "$1")")" = "$2" ]
}

contiene_linea_exacta() {
    grep -Fxq "$2" "$(ruta "$1")" 2>/dev/null
}

printf '%s\n' '=================================================='
printf '%s\n' '       AIRMUR 01 — COMPROBACIÓN FINAL'
printf '%s\n\n' '=================================================='

printf '%s\n\n' 'PRIMER CONTACTO CON LINUX'
comprobar '/home/ubicacion_comprobada existe' es_archivo /home/ubicacion_comprobada
comprobar 'Directorio /srv/aeropuerto' es_directorio /srv/aeropuerto
comprobar 'Directorio /srv/aeropuerto/turnos' es_directorio /srv/aeropuerto/turnos
comprobar 'Archivo parte_inicio.txt' es_archivo /srv/aeropuerto/turnos/parte_inicio.txt

printf '\n%s\n\n' 'USUARIOS'
for usuario in lucas marta elena raul; do
    nombre=$(printf '%s' "$usuario" | awk '{ print toupper(substr($0,1,1)) substr($0,2) }')
    [ "$usuario" = 'raul' ] && nombre='Raúl'
    comprobar "$nombre existe" usuario_existe "$usuario"
    comprobar "$nombre tiene HOME registrado /home/$usuario" home_registrado "$usuario" "/home/$usuario"
    comprobar "Directorio /home/$usuario existe" es_directorio "/home/$usuario"
done
comprobar 'Lucas tiene contraseña activa' contrasena_es lucas P
comprobar 'Proveedor existe' usuario_existe proveedor
comprobar 'Proveedor está bloqueado' contrasena_es proveedor L

printf '\n%s\n\n' 'ARCHIVOS Y ENTORNO DE LUCAS'
comprobar 'plan_turnos.txt existe' es_archivo /srv/aeropuerto/turnos/plan_turnos.txt
comprobar 'plan_turnos.txt — propietario lucas' propietario_es /srv/aeropuerto/turnos/plan_turnos.txt lucas
comprobar 'plan_turnos.txt — grupo lucas' grupo_propietario_es /srv/aeropuerto/turnos/plan_turnos.txt lucas
comprobar '/home/lucas/.bashrc existe' es_archivo /home/lucas/.bashrc
comprobar "Alias turnos exacto" contiene_linea_exacta /home/lucas/.bashrc "alias turnos='cd /srv/aeropuerto/turnos'"
comprobar '.bashrc de Lucas — propietario lucas' propietario_es /home/lucas/.bashrc lucas
comprobar '.bashrc de Lucas — grupo lucas' grupo_propietario_es /home/lucas/.bashrc lucas

printf '\n%s\n\n' 'GRUPOS'
for grupo in operaciones mantenimiento administracion sistemas; do
    comprobar "Grupo $grupo existe" grupo_existe "$grupo"
done
comprobar 'Lucas → operaciones' pertenece_grupo lucas operaciones
comprobar 'Marta → mantenimiento' pertenece_grupo marta mantenimiento
comprobar 'Elena → administracion' pertenece_grupo elena administracion
comprobar 'Raúl → sistemas' pertenece_grupo raul sistemas
comprobar 'Raúl → sudo' pertenece_grupo raul sudo

printf '\n%s\n\n' 'RETO FINAL — NORA'
comprobar 'Nora existe' usuario_existe nora
comprobar 'Nora tiene HOME registrado /home/nora' home_registrado nora /home/nora
comprobar 'Directorio /home/nora existe' es_directorio /home/nora
comprobar 'Nora → operaciones' pertenece_grupo nora operaciones
comprobar 'INCIDENCIAS existe' es_directorio /home/nora/INCIDENCIAS
comprobar 'primer_turno.txt existe' es_archivo /home/nora/INCIDENCIAS/primer_turno.txt
comprobar 'INCIDENCIAS — propietario nora' propietario_es /home/nora/INCIDENCIAS nora
comprobar 'INCIDENCIAS — grupo nora' grupo_propietario_es /home/nora/INCIDENCIAS nora
comprobar 'primer_turno.txt — propietario nora' propietario_es /home/nora/INCIDENCIAS/primer_turno.txt nora
comprobar 'primer_turno.txt — grupo nora' grupo_propietario_es /home/nora/INCIDENCIAS/primer_turno.txt nora
comprobar '/home/nora/.bashrc existe' es_archivo /home/nora/.bashrc
comprobar "Alias incidencias exacto" contiene_linea_exacta /home/nora/.bashrc "alias incidencias='cd ~/INCIDENCIAS'"

nota=$(awk -v puntos="$puntos" -v total="$total" 'BEGIN { printf "%.1f", (puntos * 10) / total }')

printf '\n%s\n\n' '--------------------------------------------------'
printf 'PUNTOS: %d / %d\n\n' "$puntos" "$total"
printf 'NOTA FINAL: %s / 10\n\n' "$nota"

if [ $((puntos * 10)) -ge $((total * 9)) ]; then
    printf '%s\n' '🌟 SOBRESALIENTE'
elif [ $((puntos * 10)) -ge $((total * 7)) ]; then
    printf '%s\n' '👍 NOTABLE'
elif [ $((puntos * 10)) -ge $((total * 5)) ]; then
    printf '%s\n' '✅ APROBADO'
else
    printf '%s\n' '❌ ACTIVIDAD NO SUPERADA'
fi

printf '\n%s\n' '=================================================='
