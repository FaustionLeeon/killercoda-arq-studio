# Preparar el proyecto GTA VI

Jason necesita una carpeta de trabajo y el primer archivo de compilación. La
estructura final debe ser:

```text
/home/jason/GTAVI/build_vicecity.txt
```

Cambia a la identidad de Jason con `su -`. El guion carga su HOME y su perfil,
como si hubiera iniciado una sesión nueva:

```bash
su - jason
mkdir GTAVI
touch GTAVI/build_vicecity.txt
ls -lR /home/jason/GTAVI
exit
```{{copy}}

`mkdir` crea una carpeta, `touch` crea un archivo vacío y `exit` regresa al
administrador. `GTAVI` es una **ruta relativa** desde el HOME de Jason;
`/home/jason/GTAVI` es la misma ubicación expresada como **ruta absoluta**.

Es importante crear los elementos siendo Jason: así Linux les asigna a Jason
como propietario. Cuando la estructura y la propiedad sean correctas, pulsa
**CHECK**.
