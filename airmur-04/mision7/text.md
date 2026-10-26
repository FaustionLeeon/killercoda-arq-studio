# Misión 7 — Cierre de pista

La última acción no es “hacer una captura”: es ejecutar una auditoría repetible y empaquetar pruebas sin contraseñas.

```bash
sudo /opt/airmur04/audit.sh
sudo /opt/airmur04/collect-evidence.sh
cat /root/airmur04/ultimo-paquete.txt
```{{exec}}

La auditoría puede mostrar un `WARN` si Cockpit Files no estaba disponible. Eso no invalida el trabajo técnico previo, pero obliga a completar CE 4.e en VirtualBox.

El paquete declara expresamente `NO_ACREDITA_AD=SI`.

**Evidencia:** cierre de CE 4.a–4.g y trazabilidad.

