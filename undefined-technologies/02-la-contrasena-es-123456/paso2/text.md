## 🎬 Ramiro
«Quiero RIVALZ para los jugadores y otro portal para los inversores. ¿Eso son dos ordenadores?»

No: **un servidor puede alojar varias webs**. Nginx decide cuál mostrar según el nombre de dominio recibido.

1. Crea el segundo **sitio virtual**:

```bash
cat > /etc/nginx/sites-available/inversores.conf <<'EOF'
server {
    listen 80;
    server_name inversores.test;
    root /srv/inversores;
    index index.html;
    location / { try_files $uri $uri/ =404; }
}
EOF
```

2. Actívalo y revisa:

```bash
ln -s /etc/nginx/sites-available/inversores.conf /etc/nginx/sites-enabled/inversores.conf
nginx -t
systemctl reload nginx
```

3. Comprueba la **diferencia**. Fíjate que `-H 'Host: ...'` simula qué dominio escribió el navegador:

```bash
curl -s -H 'Host: rivalz.test' http://127.0.0.1/ | grep RIVALZ_LAB
curl -s -H 'Host: inversores.test' http://127.0.0.1/ | grep UNDEFINED_INVEST
```

**No necesitas comprar esos dominios.** `.test` se usa aquí para el laboratorio. Si ves ambas marcas, pulsa **CHECK**.
