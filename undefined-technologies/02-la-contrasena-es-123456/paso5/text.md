## 🎬 El inversor
«Si pongo la dirección del administrador, quiero que me pida usuario y contraseña y que viaje cifrado.»

Este es el paso importante: unimos **HTTPS + autenticación**.

1. Sustituye la configuración de RIVALZ por esta versión con dos bloques: uno para HTTP (`80`) y otro para HTTPS (`443`). Pega **todo**:

```bash
cat > /etc/nginx/sites-available/rivalz.conf <<'EOF'
server {
    listen 80 default_server;
    server_name rivalz.test;
    root /srv/rivalz;
    index index.html;
    access_log /var/log/nginx/rivalz_access.log;
    error_log /var/log/nginx/rivalz_error.log;
    location /admin/ { return 301 https://rivalz.test$request_uri; }
    location / { try_files $uri $uri/ =404; }
}
server {
    listen 443 ssl;
    server_name rivalz.test;
    root /srv/rivalz;
    index index.html;
    ssl_certificate /etc/ssl/certs/rivalz.test.crt;
    ssl_certificate_key /etc/ssl/private/rivalz.test.key;
    access_log /var/log/nginx/rivalz_access.log;
    error_log /var/log/nginx/rivalz_error.log;
    add_header X-Content-Type-Options nosniff always;
    add_header X-Frame-Options DENY always;
    location /admin/ {
        auth_basic 'Zona privada RIVALZ';
        auth_basic_user_file /etc/nginx/.rivalz_htpasswd;
        try_files $uri $uri/ =404;
    }
    location / { try_files $uri $uri/ =404; }
}
EOF
```

2. Comprueba la sintaxis antes de aplicar cambios:

```bash
nginx -t
```

3. Si dice `test is successful`, recarga:

```bash
systemctl reload nginx
```

4. Comprueba que el panel HTTP **redirige** a HTTPS:

```bash
curl -I -H 'Host: rivalz.test' http://127.0.0.1/admin/
```

Debes ver `301 Moved Permanently` y una cabecera `Location: https://...`.

**Importante:** Killercoda ofrece vista web por HTTP para el tráfico externo. El acceso HTTPS con certificado de pruebas lo comprobarás desde la terminal con `curl -k` en el siguiente paso. Pulsa **CHECK**.
