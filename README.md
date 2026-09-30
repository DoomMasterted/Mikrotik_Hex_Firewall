# MikroTik RB750r2 (hEX lite) - Home Network & Security Configuration

Este repositorio contiene la configuración base y de seguridad para un router MikroTik operando como gateway de mi propia red

## Hardware Utilizado
* **Modelo:** MikroTik RouterBOARD RB750r2 (hEX lite)
* **RouterOS:** (Versión 7.x)

## Características Principales de la Configuración

###  Seguridad y Firewall
* **Default Drop:** Se implementó una política de bloqueo por defecto en la cadena `forward` para tráfico no autorizado.
* **Bloqueo de Puertos Vulnerables:** Regla específica en el firewall para descartar tráfico saliente hacia puertos comúnmente explotados o innecesarios (21, 23, 25, 110, 1433, 3389, etc.).
* **Protección de Acceso Local:** El acceso al router (WinBox/SSH) está estrictamente limitado a la interfaz LAN (`ether2`) y a un segmento específico de la WAN.
* **IPv6 Deshabilitado:** 

### DNS Ad-Blocking (Sinkhole)
* Integración de las listas de bloqueo de **StevenBlack** (hosts) y **URLhaus** (Abuse.ch) directamente en el DNS 
* **Forzado de DNS Local (DNS Hijacking):** Reglas NAT (`dstnat`) se intercepta la peticion del  puerto 53 (TCP/UDP) y redirigen al DNS del router
* **Automatización:** Script programado en el `scheduler` para actualizar las listas de bloqueo

### Optimización de Red y Gaming
* **FastTrack Habilitado:** Para descargar el procesamiento del CPU en conexiones ya establecidas y mejorar el throughput general.
* **MSS Clamping:** Regla de mangle (`change-mss`) para ajustar el MSS de los paquetes TCP SYN, previniendo problemas de fragmentación
* **UPnP Habilitado:** por si algun juego lo pide
* **Wake-on-LAN (WOL):** Script para encender la pc desde el cel con comando via WinBox

### Calidad de Vida (QoL)
* Asignación estática de IP (DHCP Lease) para la pc.
* Colas SFQ (Stochastic Fairness Queuing) aplicadas a las interfaces para mejorar la distribución de paquetes.
