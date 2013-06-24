About VPN

A virtual private network (VPN) extends a private network across public networks like the Internet. It enables a host computer to send and receive data across shared or public networks as if they were an integral part of the private network with all the functionality, security and management policies of the private network.This is done by establishing a virtual point-to-point connection through the use of dedicated connections, encryption, or a combination of the two.
The following steps illustrate the principles of a VPN client-server interaction in simple terms.

Assume a remote host (with VPN client in it) with public IP address 1.2.3.4 wishes to connect to a system found inside a company network. The system has internal address 192.168.1.10 and is not reachable publicly. Before the client can reach this server, it needs to go through a VPN server / firewall device that has public IP address 5.6.7.8 and an internal address of 192.168.1.1. All data between the client and the server will need to be kept confidential, hence a secure VPN is used.

> The VPN client connects to a VPN server via an external network interface.
> The VPN server assigns an IP address to the VPN client from the VPN server's subnet. The client gets internal IP address 192.168.1.50, for example, and creates a virtual network interface through which it will send encrypted packets to the other tunnel endpoint (the device at the other end of the tunnel).
> When the VPN client wishes to communicate with the company server, it prepares a packet addressed to 192.168.1.10, encrypts it and encapsulates it in an outer VPN packet, say an IPSec packet. This packet is then sent to the VPN server at IP address 5.6.7.8 over the public Internet. The inner packet is encrypted so that even if someone intercepts the packet over the Internet, they cannot get any information from it. They can see that the remote host is communicating with a server/firewall, but none of the contents of the communication. The inner encrypted packet has source address 192.168.1.50 and destination address 192.168.1.10. The outer packet has source address 1.2.3.4 and destination address 5.6.7.8.
> When the packet reaches the VPN server from the Internet, the VPN server decapsulates the inner packet, decrypts it, finds the destination address to be 192.168.1.10, and forwards it to the intended server at 192.168.1.10.
> After some time, the VPN server receives a reply packet from 192.168.1.10, intended for 192.168.1.50. The VPN server consults its routing table, and sees this packet is intended for a remote host that must go through VPN.
> The VPN server encrypts this reply packet, encapsulates it in a VPN packet and sends it out over the Internet. The inner encrypted packet has source address 192.168.1.10 and destination address 192.168.1.50. The outer VPN packet has source address 5.6.7.8 and destination address 1.2.3.4.
> The remote host receives the packet. The VPN client decapsulates the inner packet, decrypts it, and passes it to the appropriate software at upper layers.

Overall, it appears as if the remote host (VPN client) and internal system are on the same 192.168.1.0/24 network.

This feature is used in Signpost where two VPN clients from different networks are given IP which is in the same subnet as VPN server. It will appear that VPN clients and server are in the same network. A tunnel is established between client and server and they both will communicate to each other through server.

For using this technique, OpenVPN is used which is an open source software application that implements virtual private network (VPN) techniques for creating secure point-to-point connections. It uses a custom security protocol that utilizes SSL/TLS for key exchange. It is capable of traversing network address translators (NATs) and firewalls. OpenVPN allows peers to authenticate each other using a pre-shared secret key, certificates, or username/password. 
In Signpost, it is used in a multiclient-server configuration, in which the server releases an authentication certificate for every client, using signature and Certificate authority. It uses the OpenSSL encryption library extensively, as well as the SSLv3/TLSv1 protocol, and contains many security and control features.

***************************
Implementation Details:

The first step in building an OpenVPN 2.x configuration is to establish a PKI (public key infrastructure). The PKI consists of:

   > a separate certificate (also known as a public key) and private key for the server and each client, and
   > a master Certificate Authority (CA) certificate and key which is used to sign each of the server and client certificates.

OpenVPN supports bidirectional authentication based on certificates, meaning that the client must authenticate the server certificate and the server must authenticate the client certificate before mutual trust is established.

Both server and client will authenticate the other by first verifying that the presented certificate was signed by the master certificate authority (CA), and then by testing information in the now-authenticated certificate header, such as the certificate common name or certificate type (client or server).


AT SERVER:

For PKI management, we will use easy-rsa, a set of scripts which is bundled with OpenVPN. Copy the scripts from /usr/share/doc/openvpn/examples/easy-rsa/2.0/* These scripts are needed to generate a master CA certificate/key, a server certificate/key, and certificates/keys for each client.

Server generates certificates and keys for each client. At each run, a new certificate and new keys are generated. So, clients need to copy this new certificate and key everytime. this generation of certificates and keys is the work aprior to starting of server.

File aprior.sh use:
	File prior.sh for generation of certificates according to the parameters entered by user significant to location of client 
	File keygen.sh for generation of keys for server and each client
A 'server.conf' file is generated automatically with all the parameters input by user in 'parameters' file. File 'initialize_server.sh' then starts openvpn server at the port mentioned in the parameters file using 'server.conf' file.

AT CLIENT:

Copy the client specific keys and certificates from the server at each client. This is done by file 'aprior.sh'. A 'client.conf' file is generated automatically with all the parameters input by user in 'parameters' file. File 'initialize.sh' then start openvpn client at the same port on which server is listening using 'client.conf' file.

*****************************
Output
*****************************

Server will create a VPN using a virtual TUN network interface (for routing) and will listen for client connections on UDP port x (mentioned in parameters file), and distribute virtual addresses to connecting clients from the 10.8.0.0/24 subnet.

Client will also have a virtual TUN network interface with virtual address being assigned by the server.

Both clients can also ping each other using IP at their TUN interfaces.

********************************
Problem Faced / Points to note
********************************

> The dev (tun or tap) and proto (udp or tcp) directives are consistent at both client and server config files. Also make sure that comp-lzo and fragment, if used, are present in both client and server config files.

> Use different client names for different clients while generating keys from them at server.

> A symbolic link is created because openssl.cnf file is not present in openvpn software and its absence does not allow openvpn to generate keys in Ubuntu 12.04 or higher versions. Symbolic link is created using: "ln -s openssl-1.0.0.cnf openssl.cnf" in 'server/aprior.sh'

> Make sure the port on which server and client contact is not firewalled/busy.

***************************
References
*************************** 

[1] https://help.ubuntu.com/10.04/serverguide/openvpn.html

[2] http://openvpn.net/index.php/open-source/documentation/howto.html

