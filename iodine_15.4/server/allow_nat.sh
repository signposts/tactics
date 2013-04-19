#!/bin/sh

iface=$1 			#existing interface used by system, here eth0
dns_iface=$2			#write name of dns interface created, dns0, dns1 etc, by checking ifconfig
client_dns_ip=$3		#client ip which is assigned to dns interface, check by ifconfig

sysctl net.ipv4.ip_forward=1

iptables -A FORWARD -i $iface -o $dns_iface -d $client_dns_ip -j ACCEPT

iptables -A FORWARD -o $iface -i $dns_iface -s $client_dns_ip -j ACCEPT

iptables -t nat -A POSTROUTING -o $iface -j MASQUERADE
