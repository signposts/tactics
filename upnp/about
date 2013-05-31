Suppose some service is running in the system which is behind NAT and you want to use that service but you are not in this network. Since, you do not know IP of this system (only external IP is known), you can't access this service. You need to do some Port Forwarding. To do this port forwarding automatically without user's intervention, upnp is used.

*********SERVER SIDE*************

What is IGD? Why to use it?

UPnP is a set of protocols that allow the automatic configuration of devices. One of those protocols, the Internet Gateway Device (IGD) protocol, allows software to configure routers for NAT traversal without user-intervention. In other words, with UPnP/IGD, the long and error-prone manual configuration for port-forwarding can be done automatically.

It creates iptables rule for port forwarding automatically using an upnp client. At client you need to mention external port whose traffic you need to forward to a specific (Interal) port in the client.

Example:

UPnP router has following configurations:
eth1 (External port): 128.243.35.178/24
eth0 (Internal port): 172.16.1.1/16

Client behind NAT has following configuration:
eth0: 172.16.1.2/16

If you want traffic coming on some external port (say 55555) at upnp router to be forwarded to internal port (say 22) of the client, you can add port forwarding at upnp client using a command. This will automatically be added in upnp router's iptables. You need not manually configure UPnP router's iptables. This is convenient as adding/deleting iptable rule is router's vendor specific.

In order to make a linux system to behave as an upnp router, libupnp and linuxigd is used. These 2 libraries need to be installed and configured in the system.

NOTE: linuxigd will only work with system having 2 physical interfaces (ie 2 NICs). It won't work with virtual interfaces.


Tested with:

1. Dreamplug with Debian 6.0
2. libupnp-1.3.1.tar.gz
3. linuxigd-1.0.tar.gz (source: http://linux-igd.sourceforge.net/)

Steps to configure dreamplug to behave as upnp router (source: INSTALL in linuxigd-1.0):

1. Download and install libupnp-1.3.1 (source: http://www.sourceforge.net/projects/upnp).
2. Configure libupnp (source: README of libupnp-1.3.1)
	Make sure there is c++ compiler already installed.
	> tar -xvzf libupnp-1.3.1.tar.gz
	> cd libupnp-1.3.1
	> ./configure
	> make
	> make install
3. Download and install linuxigd-1.0.tar.gz
4. Configure linuxigd
	> tar -xvzf linuxigd-1.0.tgz    (or whatever the version you have is, or CVS)
	> make (I have not done make using LIBIPTC which is mentioned as one of the options in INSTALL)
	> make install

After that everything is done by script tactics/upnp/server/initialize_server.sh. Don't forget to mention parameters in tactics/upnp/server/parameters.
NOTE: Sometimes make install may not work if not done as sudo. In that case run:
	sudo make install
	
***********CLIENT SIDE*******************

Tested as PortMapper-1.9.5.jar as upnp client. (source: http://upnp-portmapper.sourceforge.net/)	 

This can also be used as GUI or as command line. 

REQUIREMENT: Java SE Runtime Environment 6.0

Steps followed:

1. Install JAVA
2. Download PortMapper-1.9.5.jar from the source specified. 
3. Rest everything is done by tactics/upnp/server/initialize_client.sh. Don't forget to mention parameters in tactics/upnp/client/parameters.

When you will type following:
java -jar PATH_TO_PORTMAPPER.jar  -h

You will get following:

usage: java -jar PortMapper.jar [-a <ip port external_port protocol> | -d
       <external_port protocol [...]> | -g | -h | -l | -r <port protocol [...]>
       | -s]    [-i <index>]    [-u <class name>]
 -a <ip port external_port protocol>   Add port forwarding
 -d <external_port protocol [...]>     Delete port forwarding
 -g                                    Start graphical user interface (default)
 -h                                    print this message
 -i <index>                            Router index (if more than one is found)
 -l                                    List forwardings
 -r <port protocol [...]>              Add all forwardings to the current host
 -s                                    Get Connection status
 -u <class name>                       UPnP library
Protocol is UDP or TCP

"java -jar PortMapper.jar -a ip port external_port protocol"  is used currently.

Here:
ip: IP of the client which is behind NAT
port: Internal port of the client on which you want request to be forwarded. (As from example above, this is port 22)
external_port: Port on the upnp router on which traffic from internet comes. (As from example above, this is port 55555)
protocol: It can be TCP/UDP mentioned in UPPER CASE else exception is thrown.
