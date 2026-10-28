#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/rivalz-kit /srv/rivalz
cat > /root/rivalz-kit/index.html <<'RIVALZ_EOF'
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>RIVALZ | UNDEFINED TECHNOLOGIES</title><link rel="stylesheet" href="/style.css"></head>
<body><main class="panel"><p class="kicker">UNDEFINED TECHNOLOGIES / 2026</p>
<h1>RIVALZ</h1><p class="sub">Tu equipo. Tu código. Tu liga.</p>
<p>La plataforma de fútbol virtual está en construcción. <strong>¡Próximo lanzamiento!</strong></p>
<p class="tag">RIVALZ_LAB_2026</p></main></body></html>
RIVALZ_EOF
cat > /root/rivalz-kit/style.css <<'RIVALZ_EOF'
*{box-sizing:border-box}body{margin:0;min-height:100vh;display:grid;place-items:center;
background:linear-gradient(145deg,#0a1930,#154d55);font-family:Arial,sans-serif;color:#fff}
.panel{width:min(92%,620px);padding:46px;border:1px solid #ffffff3c;border-radius:22px;background:#ffffff12}
h1{font-size:clamp(48px,9vw,88px);letter-spacing:5px;margin:10px 0}.kicker{color:#92e0ce;font-weight:bold}
.sub{font-size:23px}.tag{font-family:monospace;color:#92e0ce;font-size:12px;margin-top:40px}
RIVALZ_EOF
cat > /root/LEEME.txt <<'EOF'
UNDEFINED TECHNOLOGIES: ¡Pero en mi ordenador funciona!
El kit entregado por el desarrollador está en /root/rivalz-kit/
NO hay servidor web de RIVALZ configurado todavía.
EOF
