# Misión 6 — La puerta de cristal

Comprueba primero la disponibilidad del complemento:

`cat /var/lib/airmur04-cockpit-files.status && systemctl is-active cockpit.socket`{{exec}}

Si indica `available`:

1. Abre [Cockpit]({{TRAFFIC_HOST1_9090}}).
2. Entra como `nora` con `Airmur04!Lab`.
3. Abre **Files** y navega a `/srv/airmur/evidencias`.
4. Crea `nota-cockpit.txt` con una frase que incluya `AIRMUR 04`.
5. Registra la comprobación:

   `sudo /opt/airmur04/record-cockpit.sh`{{exec}}

Si indica `unavailable`, ejecuta igualmente el registrador. La misión podrá continuar, pero quedará escrito que **CE 4.e sigue pendiente de VirtualBox**; no se fingirá la evidencia.

**Evidencia:** CE 4.e, condicionada al uso real de Cockpit Files.

