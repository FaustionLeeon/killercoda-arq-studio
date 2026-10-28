## 🎬 Lucía
«No me digas que es seguro. **Demuéstramelo** con pruebas.»

Haz estas tres pruebas de forma separada. **Ojo:** `-k` acepta temporalmente el certificado autofirmado de ESTE laboratorio. **No es adecuado para conexiones de producción.**

1. Solicita el panel **sin credenciales**:

```bash
curl -k -I --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/
```

Esperado: `401 Unauthorized`.

2. Solicita el panel **con credenciales de prueba**:

```bash
curl -k -u 'operador:ClaveSoloLaboratorio2026!' --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/ | grep RIVALZ_ADMIN
```

Esperado: `RIVALZ_ADMIN_2026`.

3. Comprueba que el sitio normal sigue funcionando por HTTP:

```bash
curl -I -H 'Host: rivalz.test' http://127.0.0.1/
```

4. Crea un pequeño archivo de evidencias:

```bash
curl -k -s -o /dev/null -w '%{http_code}' --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/ > /root/codigo-sin-clave.txt
```

5. Comprueba el contenido:

```bash
cat /root/codigo-sin-clave.txt
```

Debe decir `401`. Pulsa **CHECK**.
