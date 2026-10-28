## 🎬 Ramiro
«Un inversor dice que el panel le ha rechazado. ¿Cómo sé si alguien ha intentado entrar?»

Los **logs** son diarios que escribe el servidor. Permiten revisar errores y solicitudes.

1. Genera tres peticiones de prueba (sin contraseña):

```bash
curl -k -s -o /dev/null --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/
curl -k -s -o /dev/null --resolve rivalz.test:443:127.0.0.1 https://rivalz.test/admin/
curl -s -o /dev/null -H 'Host: rivalz.test' http://127.0.0.1/
```

2. Consulta las 12 últimas líneas del registro:

```bash
tail -n 12 /var/log/nginx/rivalz_access.log
```

3. Busca intentos rechazados (`401`):

```bash
grep ' 401 ' /var/log/nginx/rivalz_access.log | tail -n 5
```

4. Guarda una evidencia de que has analizado las solicitudes:

```bash
grep ' 401 ' /var/log/nginx/rivalz_access.log > /root/accesos-denegados.log
wc -l /root/accesos-denegados.log
```

**Atención:** `tail` y `grep` son una introducción a los logs. El criterio RA2:j exige una solución más completa de gestión, consolidación y análisis en tiempo real y **no queda superado con este ejercicio**.

Pulsa **CHECK**.
