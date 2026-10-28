## 🎬 Lucía
«El candado no es decoración. HTTPS cifra lo que viaja entre navegador y servidor.»

Necesitamos un **certificado digital** y una **clave privada**. En esta práctica son **autofirmados**: sirven para aprender, no para certificar públicamente una web real.

1. Crea certificado y clave con este único comando (es largo; cópialo completo):

```bash
openssl req -x509 -nodes -newkey rsa:2048 -days 3 -keyout /etc/ssl/private/rivalz.test.key -out /etc/ssl/certs/rivalz.test.crt -subj '/CN=rivalz.test' -addext 'subjectAltName=DNS:rivalz.test'
```

2. Protege la clave privada:

```bash
chmod 600 /etc/ssl/private/rivalz.test.key
```

3. Consulta el certificado (sin enseñar su clave privada):

```bash
openssl x509 -in /etc/ssl/certs/rivalz.test.crt -noout -subject -dates
```

4. Comprueba que existen los dos archivos:

```bash
ls -l /etc/ssl/certs/rivalz.test.crt /etc/ssl/private/rivalz.test.key
```

**No compartas jamás una clave privada de producción.** Pulsa **CHECK**.
