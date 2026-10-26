# Misión 5 — La tarjeta que nunca se imprimió

La cola `AIRMUR-BOARDING` será una impresora virtual: recibe trabajos y escribe un fichero de spool, sin papel ni hardware.

```bash
sudo /opt/airmur04/configure-printer.sh
printf 'BOARDING PASS — AIRMUR 04 — %s\n' "$(date -u +%FT%TZ)" | lp -d AIRMUR-BOARDING
sleep 2
lpstat -t
sudo ls -l /var/spool/airmur-virtual-printer/
```{{exec}}

La cola también está publicada por Samba para usuarios autenticados.

**Evidencia:** CE 4.d.

