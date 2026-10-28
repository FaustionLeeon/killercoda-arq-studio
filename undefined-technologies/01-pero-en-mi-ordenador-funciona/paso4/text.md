![UNDEFINED TECHNOLOGIES. Cómic del paso 4: ¡ESTO NO SE LLAMA NGINX!](./comic-paso-4.png)

> **En la historia:** Configuración válida y sitio RIVALZ activo. Usa los comandos explicados debajo de esta viñeta; no copies comandos de las ilustraciones.

---

## 🎬 Ramiro
«Ahora veo la página de bienvenida de Nginx. ¡La startup se llama RIVALZ, no NGINX!»

Nginx usa **archivos de configuración** para saber qué carpeta debe mostrar.

1. Crea una configuración llamada `rivalz.conf`. Pega el bloque **completo**:

```bash
cat > /etc/nginx/sites-available/rivalz.conf <<'EOF'
server {
    listen 80 default_server;
    server_name rivalz.test;
    root /srv/rivalz;
    index index.html;
    access_log /var/log/nginx/rivalz_access.log;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF
```

Traducción: `listen 80` escucha visitas web; `root` es la carpeta; `index` es el archivo principal; `access_log` registra visitas.

2. Desactiva la web genérica, activa RIVALZ y revisa la sintaxis:

```bash
rm -f /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/rivalz.conf /etc/nginx/sites-enabled/rivalz.conf
nginx -t
```

3. **Solo si** ves `syntax is ok` y `test is successful`, recarga el servicio:

```bash
systemctl reload nginx
```

**Si aparece «File exists»:** ya existe el enlace, no hace falta crearlo de nuevo. **Si `nginx -t` falla: no recargues**; revisa llaves `{}` y puntos y coma `;`.

Pulsa **CHECK**.
