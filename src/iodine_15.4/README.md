DNS TUNNELING:
The technique of DNS tunnelling involves encapsulating binary data within DNS queries and replies, using base32 and base64 encoding, and to use the DNS domain name lookup system itself as a bi-directional carrier for this data. Therefore, as long as you can do domain name lookups on a network, you can tunnel any kind of data you want to a remote system, and also the internet.

Technical overview:

A hostname can only be 255 bytes long. Client encodes a formatted domain name request upto a maximum of 255 bytes and then fake DNS nameserver decodes it back. This fake NS then encodes the response back and deliver it to the client.


IODINE is a software that lets you tunnel IPv4 data through a DNS server. This can be usable in different situations where internet access is
firewalled, but DNS queries are allowed.[1]

To use this tunnel, you need control over a real domain (like mooo.com), and a server with a public IP address. This server acts as FakeNS  which will respond to the requests of your domain name(subd.mooo.com). Client will send IP packets encapsulated by DNS packets with this domain name(subd.mooo.com) and server will respond to them as follows:

For instance, you want to send IP packet to the internet, however only available service on your local network is DNS caching server.
Your client encodes IP packet as base32, and sends it as a DNS request. Iodine server (fake DNS server) is responsible for: subd.mooo.com. So, iodine client when trying to transmit IP packet, well send:

mzshgzttmrthez3smvtwizt ... m43eozshgzttmrthgz.subd.mooo.com

Our "fake" DNS server will decode the request, reconstruct IP packet, and send it off to internet. 

So, in short:
> Iodine client want to send data to IP 1.2.3.4
> It encodes packet as base32 and encapsulate it in a DNS query and sends DNS request as: base32encodedpacket.subd.mooo.com. to local relaying DNS server.
> The request after passing to relaying DNS servers (like servers for .com etc) goes to fake DNS server(fakens.mooo.com) as this is responsible to answer requests for domain subd.mooo.com.
> Fake NS eventually gets the request, decodes base32, reconstructing the packet and sends it off to the internet.
> Iodine server in response for received DNS query sends base64 encoded (NULL/TXT) record, with encoded IP packets destined for client.
> Iodine client will recive DNS response, decode DNS record and reconstruct packets.

 A tunnel is established between iodine client and iodine server for this purpose. In Signpost, this tunnel plays an important role of setting a communication path between two different clients through server.[2]

How to set a domain?

You can get a domain name by using BIND9 or setting some domain at sites such as http://freedns.afraid.org/

Once you get a domain name (here, I used freedns.afraid.org in getting the domain name: "mooo.com"), delegate a subdomain (like "subd.mooo.com") to the iodined server. 
> Go to freedns.afraid.org/subdomain/edit.php. [3]
> Create a subdomain of type NS which will act as fake DNS Server:
	Type 		NS
	Subdomain	subd
	Domain		mooo.com (public)
	Destination	fakens.subd.mooo.com 
> After saving, create another subdomain of type A giving IP to the above created fake DNS server. (This IP will be the IP of the system on which iodine server will be running)
	Type 		A
	Subdomain	fakens.subd
	Domain		mooo.com (public)
	Destination	IP_of_system_where_iodine_server_is_running

This looks like:

subd	IN	NS	fakens.mooo.com
fakens  IN 	A 	IP_of_system_where_iodine_server_is_running

So any query for the domain 'subd.mooo.com' is responded by fake nameserver fakens.mooo.com whose IP is given in the second line of the above record. Iodine server will run at this IP and will decode the encapsulated DNS packets(with DNS request for subd.mooo.com) sent by iodine client.

***********************************
Implementation Details
***********************************

AT SERVER:
 After getting a domain name, run iodine server as:

>iodined -n IP_of_system_where_iodine_server_is_running -P password -c IP_dns_interface_at_server

>> password: adds an extra layer of security. It needs to authenticate a client.
>> IP_dns_interface_at_server: Give any IP from private adresses. This is the IP of DNS interface which will serve as one end of the tunnel ie at server side. Server will assign IP in the same subnet to DNS interface of the client.

AT CLIENT:
 After server is up and running, start the client as:
> iodine -r -P password domain_name

>> password: which was given above by the server.
>>domain_name: the domain which you have set. (subd.mooo.com)

After this, setting iptables rules for masquerading packets coming at dns0 interface to go out through extrnal interface at server and setting routes at client, a client can connect to internet through server. 'set_route.sh' in client folder, set necessary routes and 'allow_nat.sh' in server folder, set iptables rule.[2]

*****************************
Output
*****************************

 You can see only DNS  requests and replies packets for domain subd.mooo.com at eth/wlan interfaces of client and server. At dns0 interfaces, you can see TCP packets coming from outside world. These packets were encapsulated as DNS packets and sent to client as DNS replies by the server. 


********************************
Problem faced:
********************************

1. It can be the case that some local relaying nameserver like (128.243.98.2 in horizon) does not allow to pass DNS queries for the subdomain to reach fakeNS. In that case(If this NS is given as the first option in /etc/resolv.conf, all the queries will pass through this), manually give the IP of other relaying NS(which are given in 2nd or 3rd number in /etc/resolv.conf) which does not block such requests and allows you to reach fakeNS. For that, use this command at CLIENT:

> iodine -r IP_NS -P password domain_name

>> IP_NS: manually giving the IP of the nameserver through which the request passes to reach fakeNS(iodine server).

2. Make sure no other process is using port 53 at server.

*************************************
References:
*************************************

[1] http://code.kryo.se/iodine/README.html

[2] http://blog.knuples.net/post/setting-up-ip-over-dns-nstx-tunneling-with-iodine/

[3] http://tunnel-ninja.webege.com/article/view/iodine-tunneling-over-dns-request

