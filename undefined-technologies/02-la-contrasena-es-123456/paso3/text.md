## 🎬 Lucía, responsable de seguridad
«No abras `/admin/` a todo Internet. Primero prepara una identidad autorizada.»

Crearemos un **usuario de laboratorio** y un archivo con su contraseña en formato hash. **¡No uses ninguna contraseña real ni la reutilices fuera del laboratorio!**

1. Crea el archivo de contraseñas:

```bash
htpasswd -bc /etc/nginx/.rivalz_htpasswd operador 'ClaveSoloLaboratorio2026!'
```

2. Da permisos: el servidor puede leer el archivo, pero los demás usuarios no:

```bash
chown root:www-data /etc/nginx/.rivalz_htpasswd
chmod 640 /etc/nginx/.rivalz_htpasswd
ls -l /etc/nginx/.rivalz_htpasswd
```

3. Comprueba la identidad creada:

```bash
htpasswd -vb /etc/nginx/.rivalz_htpasswd operador 'ClaveSoloLaboratorio2026!'
```

**¿Por qué no abrimos el panel todavía?** Porque Basic Auth por HTTP envía credenciales codificadas, no cifradas. Primero instalaremos HTTPS.

Pulsa **CHECK**.
