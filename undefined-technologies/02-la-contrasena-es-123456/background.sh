#!/usr/bin/env bash
set -euo pipefail
trap 'echo FALLO > /tmp/rivalz-setup.error' ERR
mkdir -p /srv/rivalz /srv/inversores /root
cat > /srv/rivalz/index.html <<'RIVALZ_EOF'
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>RIVALZ | UNDEFINED TECHNOLOGIES</title><link rel="stylesheet" href="/style.css"></head>
<body><main class="panel"><p class="kicker">UNDEFINED TECHNOLOGIES / 2026</p>
<h1>RIVALZ</h1><p class="sub">Tu equipo. Tu código. Tu liga.</p>
<p>La plataforma de fútbol virtual está en construcción. <strong>¡Próximo lanzamiento!</strong></p>
<p class="tag">RIVALZ_LAB_2026</p></main></body></html>
RIVALZ_EOF
cat > /srv/rivalz/style.css <<'RIVALZ_EOF'
*{box-sizing:border-box}body{margin:0;min-height:100vh;display:grid;place-items:center;
background:linear-gradient(145deg,#0a1930,#154d55);font-family:Arial,sans-serif;color:#fff}
.panel{width:min(92%,620px);padding:46px;border:1px solid #ffffff3c;border-radius:22px;background:#ffffff12}
h1{font-size:clamp(48px,9vw,88px);letter-spacing:5px;margin:10px 0}.kicker{color:#92e0ce;font-weight:bold}
.sub{font-size:23px}.tag{font-family:monospace;color:#92e0ce;font-size:12px;margin-top:40px}
RIVALZ_EOF
cat > /srv/inversores/index.html <<'EOF'
<!doctype html><html lang="es"><meta charset="utf-8"><title>Inversores</title><h1>Portal de inversores</h1><p>UNDEFINED_INVEST_2026</p></html>
EOF
mkdir -p /srv/rivalz/admin
cat > /srv/rivalz/admin/index.html <<'EOF'
<!doctype html><html lang="es"><meta charset="utf-8"><title>Admin RIVALZ</title><h1>Panel de administración de RIVALZ</h1><p>RIVALZ_ADMIN_2026</p></html>
EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq nginx apache2-utils openssl curl
rm -f /etc/nginx/sites-enabled/default
cat > /etc/nginx/sites-available/rivalz.conf <<'EOF'
server {
    listen 80 default_server;
    server_name rivalz.test;
    root /srv/rivalz;
    index index.html;
    access_log /var/log/nginx/rivalz_access.log;
    error_log /var/log/nginx/rivalz_error.log;
    location /admin/ { return 403; }
    location / { try_files $uri $uri/ =404; }
}
EOF
ln -sf /etc/nginx/sites-available/rivalz.conf /etc/nginx/sites-enabled/rivalz.conf
nginx -t
systemctl enable --now nginx
systemctl reload nginx
touch /tmp/rivalz-setup.ok
