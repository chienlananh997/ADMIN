#!/bin/bash

# Define the ports you want to block
PORTS=("80" "8080" "8088" "443") # Default ports, will be modified by the install script

# Block specified ports on all interfaces except bridge0, eth0, and tailscale0
for port in "${PORTS[@]}"; do
    iptables -A INPUT -i bridge0 -p tcp --dport $port -j ACCEPT
    iptables -A INPUT -i eth0 -p tcp --dport $port -j ACCEPT
    iptables -A INPUT -i tailscale0 -p tcp --dport $port -j ACCEPT
    iptables -A INPUT -p tcp --dport $port -j DROP
done
