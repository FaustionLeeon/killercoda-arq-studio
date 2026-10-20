# Misión 6 — Lucas cambia de ordenador

**CE: RA2.h y refuerzo de RA3.h.**

## 13:10 — El escritorio con ruedas

—Lucas quiere que su escritorio viaje con él —dice el director.

—¿El escritorio físico?

—Espero que no. Acabamos de pintar el suelo.

Hay que distinguir tres cosas:

1. **Autenticación centralizada:** el dominio comprueba la identidad.
2. **Directorio personal compartido:** los datos están en un servidor accesible desde varios clientes.
3. **Perfil móvil completo:** también traslada o sincroniza configuración y estado del entorno.

No son equivalentes.

## 1. Demuestra la autenticación de Lucas

Destruye el ticket anterior y solicita uno como Lucas:

```bash
kdestroy 2>/dev/null || true
kinit lucas@AD.AIRMUR.TEST
klist
```{{exec}}

Introduce `Airmur-Lab-2026!`.

Prueba el uso del ticket frente a Samba:

`smbclient --use-kerberos=required -L airmur-dc.ad.airmur.test`{{exec}}

## 2. Redacta el plan de movilidad

```bash
install -m 0600 /root/airmur03/plantillas/plan-perfil-lucas.md /root/airmur03/evidencias/plan-perfil-lucas.md
nano /root/airmur03/evidencias/plan-perfil-lucas.md
```{{exec}}

Debes conservar las cuatro etiquetas de control y escribir al menos 80 palabras propias. El plan debe decidir:

- dónde se autentica Lucas;
- qué servidor miembro almacenará sus datos;
- cómo se montará el recurso desde PC01 y PC02;
- permisos privados y recuperación administrativa;
- copias, desconexiones y conflictos;
- qué parte no constituye un perfil móvil completo.

Sustituye y elimina todas las líneas `COMPLETA-AQUI`. La plantilla sin redactar no supera la misión.

El DC no debe utilizarse como servidor general de archivos en el diseño recomendado.

> Killercoda demuestra Kerberos real en el DC y evalúa el plan. VirtualBox probará el inicio de sesión y el mismo almacenamiento desde dos clientes.
