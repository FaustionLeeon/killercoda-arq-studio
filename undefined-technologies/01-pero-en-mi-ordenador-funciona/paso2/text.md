![UNDEFINED TECHNOLOGIES. Cómic del paso 2: NECESITAMOS UN PORTERO](./comic-paso-2.png)

> **En la historia:** Servicio Nginx activo y HTTP 200. Usa los comandos explicados debajo de esta viñeta; no copies comandos de las ilustraciones.

---

## 🎬 El mensaje del programador desaparecido
«En mi portátil pulsaba un botón verde y funcionaba. Suerte.»

**Objetivo:** instalar Nginx. Nginx es el programa que recibe visitas del navegador y envía páginas web.

1. Actualiza el listado de programas (puede tardar):

```bash
apt-get update
```

2. Instala Nginx (si pregunta, escribe `Y` o confirma):

```bash
DEBIAN_FRONTEND=noninteractive apt-get install -y nginx
```

3. Arranca el servicio y configúralo para iniciar automáticamente:

```bash
systemctl enable --now nginx
```

4. Comprueba que está **active (running)**:

```bash
systemctl is-active nginx
```

5. Pide una página al propio servidor:

```bash
curl -I http://127.0.0.1/
```

`127.0.0.1` significa *este mismo equipo*. `curl -I` pide solamente las cabeceras. Busca `HTTP/1.1 200 OK`.

**Si sale `Connection refused`:** repite `systemctl status nginx --no-pager` y comprueba el paso 3. Pulsa **CHECK**.
