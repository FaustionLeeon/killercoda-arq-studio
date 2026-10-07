# Atajo de desarrollo

Jason entra muchas veces en su carpeta `GTAVI`. Vamos a personalizar **su
perfil** para que pueda llegar escribiendo solamente `gtavi`.

Añade el alias exacto a su archivo de configuración:

```bash
echo "alias gtavi='cd ~/GTAVI'" >> /home/jason/.bashrc
```{{copy}}

Después abre una sesión nueva para cargar el cambio y pruébalo:

```bash
su - jason
gtavi
pwd
exit
```{{copy}}

`pwd` debe responder `/home/jason/GTAVI`.

- `.bashrc` configura las sesiones interactivas de Bash de Jason.
- El punto inicial hace que sea un archivo **oculto** en listados normales.
- Un **alias** da un nombre corto a otro comando; aquí `gtavi` representa
  `cd ~/GTAVI`.
- `>` sustituye el contenido del archivo; `>>` añade una línea al final.
- Usamos `>>` para conservar toda la configuración que ya tenía `.bashrc`.

Cuando el atajo esté escrito y funcione, pulsa **CHECK**.
