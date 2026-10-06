# Pablo quiere trabajar más rápido

Pablo está cansado de escribir `cd ~/PROYECTOS`. Quiere entrar en su carpeta de
proyectos escribiendo simplemente:

```bash
proyecto
```

Añade esta línea al archivo `/home/pablo/.bashrc`:

```bash
alias proyecto='cd ~/PROYECTOS'
```{{copy}}

Puedes editarlo con `nano /home/pablo/.bashrc` o añadir la línea desde una
sesión de Pablo. Después, abre una sesión nueva y pruébalo:

```bash
su - pablo
proyecto
pwd
exit
```{{copy}}

Debe llevarte a `/home/pablo/PROYECTOS`. La personalización pertenece al perfil
de Pablo, no a todos los usuarios. Pulsa **CHECK** cuando funcione.

