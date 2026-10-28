## 🎬 Ramiro: «La contraseña es 123456. ¿Qué podría salir mal?»

La web RIVALZ **ya funciona**: Killercoda ha recreado automáticamente el final del capítulo 1. Comprueba primero el servicio.

1. Ejecuta:

```bash
systemctl is-active nginx
nginx -t
curl -I -H 'Host: rivalz.test' http://127.0.0.1/
```

2. Intenta acceder al panel:

```bash
curl -I -H 'Host: rivalz.test' http://127.0.0.1/admin/
```

Verás `403 Forbidden`: significa **acceso prohibido**. Es una protección temporal; el objetivo es dar acceso seguro al personal autorizado.

3. Registra el diagnóstico:

```bash
cat > /root/diagnostico-seguridad.txt <<'EOF'
SERVIDOR: nginx
WEB: rivalz.test
PUERTO_HTTP: 80
ADMIN_INICIAL: bloqueado con 403
EOF
```

**Recuerda:** `403` = prohibido; `401` = pide autenticarse; `200` = correcto; `301` = redirección. Pulsa **CHECK**.
