# 2026-09-30 14:35:25 by RouterOS 7.24.4
# software id = XXXX-XXXX
#
# model = RB750r2
# serial number = XXXXXXXXX
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool_pc ranges=192.168.88.100-192.168.88.254
/ip dhcp-server
add address-pool=pool_pc interface=ether2 name=server_pc
/queue type
set 1 kind=sfq sfq-perturb=10
/queue interface
set ether1 queue=ethernet-default
set ether2 queue=ethernet-default
/system script
add dont-require-permissions=no name=Encender_PC owner=Madoka policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=ether2 mac=XX:XX:XX:XX:XX:XX"
/ipv6 settings
set disable-ipv6=yes
/ip address
add address=192.168.88.1/24 interface=ether2 network=192.168.88.0
/ip dhcp-client
add interface=ether1 name="Cliente DHC a Router de ISP" use-peer-dns=no
/ip dhcp-server lease
add address=192.168.88.50 comment="PC Gamer Estatica" mac-address=\
    XX:XX:XX:XX:XX:XX server=server_pc
/ip dhcp-server network
add address=192.168.88.0/24 dns-server=192.168.88.1 gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes cache-size=16384KiB servers=1.1.1.1,8.8.8.8
/ip dns adlist
add ssl-verify=no url=\
    https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
add ssl-verify=no url=https://urlhaus.abuse.ch/downloads/hostfile/
/ip firewall address-list
add address=162.158.0.0/15 comment=\
    "Servidores/Voice Discord (Cloudflare/Discord)" list=Servidores_Discord
add address=66.22.192.0/18 comment="Servidores Voice/Infrastructure Discord" \
    list=Servidores_Discord
add address=138.128.136.0/21 comment="Infraestructura Discord" list=\
    Servidores_Discord
/ip firewall filter
add action=accept chain=input comment="Permitir WinBox desde Wi-Fi ISP" \
    dst-port=8291 in-interface=ether1 protocol=tcp src-address=192.168.0.0/24
add action=accept chain=input comment="1. Aceptar conexiones establecidas" \
    connection-state=established,related
add action=accept chain=input comment=\
    "2. Permitir acceso al router SOLO desde la LAN (ether2)" in-interface=\
    ether2
add action=fasttrack-connection chain=forward comment="FastTrack PC" \
    connection-state=established,related
add action=drop chain=input comment=\
    "3. Bloquear TODO lo entrante desde la WAN (ether1)" in-interface=ether1
add action=accept chain=forward comment="Aceptar establecidas" \
    connection-state=established,related
add action=drop chain=forward comment="Descartar invalidas" connection-state=\
    invalid
add action=drop chain=forward comment=\
    "Bloquear salida a puertos raros/vulnerables" dst-port=\
    21,23,25,110,143,1433,3306,3389,5900 out-interface=ether1 protocol=tcp
add action=accept chain=forward comment="LAN -> Internet" in-interface=ether2 \
    out-interface=ether1 src-address=192.168.88.0/24
add action=drop chain=forward comment="Bloquear forward no autorizado"
/ip firewall mangle
add action=change-mss chain=forward comment=\
    "Ajustar MSS para evitar fragmentacion" new-mss=clamp-to-pmtu protocol=\
    tcp tcp-flags=syn
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=redirect chain=dstnat comment="Forzar DNS local" dst-port=53 \
    in-interface=ether2 protocol=udp to-ports=53
add action=redirect chain=dstnat comment="Forzar DNS local" dst-port=53 \
    in-interface=ether2 protocol=tcp to-ports=53
/ip upnp
set enabled=yes
/ip upnp interfaces
add interface=ether1 type=external
add interface=ether2 type=internal
/system clock
set time-zone-name=America/Argentina/Catamarca
/system identity
set name="Puella Magi"
/system leds
set 0 disabled=yes
set 1 disabled=yes
set 2 disabled=yes
set 3 disabled=yes
set 4 disabled=yes
/system scheduler
add !days interval=1w name=Actualizar_Adlist on-event="/ip dns adlist reload" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-09-29 start-time=03:00:00
