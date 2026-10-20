# AIRMUR 03 — EL AEROPUERTO NECESITA UN CEREBRO

**Sistemas Operativos en Red — 2.º SMR**
**Continuación independiente de AIRMUR 01 y AIRMUR 02**

## 08:10 — Despacho del director

El director entra sujetando treinta hojas impresas. Nadie sabe por qué las ha impreso. Probablemente tampoco él.

—Tenemos treinta ordenadores y cada uno parece vivir en su propio universo.

—Si Lucas cambia de puesto, hay que volver a crearle. Si Nora olvida su contraseña, empieza una búsqueda del tesoro. Y cuando alguien se marcha, revisamos ordenador por ordenador como si estuviéramos haciendo arqueología.

Pausa dramática.

—Quiero un único sistema que controle a los usuarios y a los equipos.

—Y lo quiero funcionando antes de que alguien proponga una hoja de cálculo compartida.

La solución será un **Samba Active Directory Domain Controller** para el dominio:

- DNS: `ad.airmur.test`
- Kerberos: `AD.AIRMUR.TEST`
- NetBIOS: `AIRMUR`
- Controlador: `airmur-dc.ad.airmur.test`
- IP de laboratorio Killercoda: `172.30.1.2`

## Qué es real en este laboratorio

En Killercoda instalarás un **servicio Samba AD real**. Se comprobarán procesos, base de directorio, DNS, Kerberos, usuarios, grupos, unidades organizativas y cuentas de equipo.

Killercoda no ofrece un Ubuntu genérico de tres nodos. Por tanto:

- `AIRMUR-DC` sí será un DC real;
- `AIRMUR-PC01` y `AIRMUR-PC02` serán objetos `computer` reales del directorio;
- no afirmaremos que son dos sistemas independientes unidos;
- las dos uniones reales y la movilidad entre clientes se completarán en VirtualBox.

## Evaluación

La puntuación máxima es **10,0**:

- misión 1: 1,0;
- misiones 2 a 7: 1,5 cada una.

Cada botón **CHECK** inspecciona el estado real. Los archivos de explicación nunca bastan por sí solos para aprobar una misión técnica.

> Usa únicamente contraseñas de laboratorio. El entorno es efímero y desaparece al finalizar la sesión.
