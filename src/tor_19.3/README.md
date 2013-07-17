About Tor

Tor protects you against a common form of Internet surveillance known as "traffic analysis" which can be used to infer who is talking to whom over a public network. Knowing the source and destination of your Internet traffic allows others to track your behavior and interests. 
Traffic analysis works as:
Internet data packets have two parts: a data payload and a header used for routing. The data payload is whatever is being sent, whether that's an email message, a web page, or an audio file. Even if you encrypt the data payload of your communications, traffic analysis still reveals a great deal about what you're doing and, possibly, what you're saying. That's because it focuses on the header, which discloses source, destination, size, timing, and so on.  A very simple form of traffic analysis might involve sitting somewhere between sender and recipient on the network, looking at headers. Some attackers spy on multiple parts of the Internet and use sophisticated statistical techniques to track the communications patterns of many different organizations and individuals. Encryption does not help against these attackers, since it only hides the content of Internet traffic, not the headers. 

"Onion Routing" refers to the layers of the encryption used. The original data, including its destination, are encrypted and re-encrypted multiple times, and sent through a virtual circuit comprising successive, randomly selected Tor relays. Each relay decrypts a "layer" of encryption to reveal only the next relay in the circuit in order to pass the remaining encrypted data on to it. The final relay decrypts the last layer of encryption and sends the original data, without revealing or even knowing its sender, to the destination. This method reduces the chance of the original data being understood in transit and, more notably, conceals the routing of it.

How Tor works

Tor helps to reduce the risks of both simple and sophisticated traffic analysis by distributing the transactions over several places on the Internet, so no single point can link you to your destination. This is same as using a twisty, hard-to-follow route in order to throw off somebody who is tailing you — and then periodically erasing your footprints. Instead of taking a direct route from source to destination, data packets on the Tor network take a random pathway through several relays that cover your tracks so no observer at any single point can tell where the data came from or where it's going. 

To create a private network pathway with Tor, the user's software or client incrementally builds a circuit of encrypted connections through relays on the network. The circuit is extended one hop at a time, and each relay along the way knows only which relay gave it data and which relay it is giving data to. No individual relay ever knows the complete path that a data packet has taken. The client negotiates a separate set of encryption keys for each hop along the circuit to ensure that each hop can't trace these connections as they pass through. 

Once a circuit has been established, many kinds of data can be exchanged and several different sorts of software applications can be deployed over the Tor network. Because each relay sees no more than one hop in the circuit, neither an eavesdropper nor a compromised relay can use traffic analysis to link the connection's source and destination.[1]


Hidden Services

Servers configured to receive inbound connections through Tor are called hidden services. Rather than revealing a server's IP address, a hidden service is accessed through its onion address. The Tor network understands these addresses and can route data to and from hidden services, even those hosted behind firewalls or network address translators (NAT), while preserving the anonymity of both parties. Tor is necessary to access hidden services.


About Hidden service protocol

Step 1: A hidden service needs to advertise its existence in the Tor network before clients will be able to contact it. Therefore, the service randomly picks some relays, builds circuits to them, and asks them to act as introduction points by telling them its public key. The introduction points and others are told the hidden service's identity (public key), but not about the hidden server's location (IP address).

Step 2: The hidden service assembles a hidden service descriptor, containing its public key and a summary of each introduction point, and signs this descriptor with its private key. It uploads that descriptor to a distributed hash table. The descriptor will be found by clients requesting XYZ.onion where XYZ is a 16 character name derived from the service's public key. After this step, the hidden service is set up.  

Step 3: A client that wants to contact a hidden service needs to learn about its onion address first. After that, the client can initiate connection establishment by downloading the descriptor from the distributed hash table. If there is a descriptor for XYZ.onion, the client now knows the set of introduction points and the right public key to use. Around this time, the client also creates a circuit to another randomly picked relay and asks it to act as rendezvous point by telling it a one-time secret.

Step 4: When the descriptor is present and the rendezvous point is ready, the client assembles an introduce message (encrypted to the hidden service's public key) including the address of the rendezvous point and the one-time secret. The client sends this message to one of the introduction points, requesting it be delivered to the hidden service. Again, communication takes place via a Tor circuit: nobody can relate sending the introduce message to the client's IP address, so the client remains anonymous.  

Step 5: The hidden service decrypts the client's introduce message and finds the address of the rendezvous point and the one-time secret in it. The service creates a circuit to the rendezvous point and sends the one-time secret to it in a rendezvous message. 

Step 6: The rendezvous point notifies the client about successful connection establishment. After that, both client and hidden service can use their circuits to the rendezvous point for communicating with each other. The rendezvous point simply relays (end-to-end encrypted) messages from client to service and vice versa. [3]

*********************************
Implementation Details
*********************************

The Hidden Services are used in Signpost as a tactic to provide anonymity to the Tor client. For this to work, following steps are done:

AT SERVER:

1. A web server is set locally for hidden service: Currently, http server with python is set up at port number specified in 'parameters' file.[4]
 This web server is started in the same system in which Tor server is running.

2. Configuring hidden service: For this tor configuration file (/tactics/working/tor_19.3/server/tor.conf) need to be edited. Edit:
	
    > HiddenServiceDir: Give full path to a directory. This is a directory where Tor will store information about that hidden service. In particular, Tor will create a file here named hostname which will tell you the onion URL. You don't need to add any files to this directory. This 'hostname' file need to be send to Tor client so that client can know the onion URL to connect to hidden service.
    > HiddenServicePort: This is the port where hidden service is running.[2]

(This is just for the information. A 'tor.conf' is provided in 'tactics/working/tor_19.3' directory in which all the work is already done. Port is taken from 'parameters' file and is added to 'tor.conf' file by the script 'initialize_server.sh'. the 'tor.conf' file is a copy of '/etc/torrc' file which is provided by tor software.)

In the HiddenServiceDir, 2 things are added:

> private_key: Tor will generate a new public/private keypair for your hidden service. It is written into a file called "private_key". Do not share this with client.

> hostname: This contains a short summary of service's public key -- it will look something like duskgytldkxiuqc6.onion. This is the public name for hidden service(16 characters) and this should be known to client.

The script 'initialize_serevr.sh' will start http server for hidden service at the specified port and also Tor Server.

AT CLIENT:

The script 'initialize_client.sh' is:

> copying 'hostname' which contains onion URL to connect to hiddden service generated at Tor server side.

> Redirecting the reply coming from the hidden service to port 9050 where Tor client is listening. 

> Starting Tor client.

*******************************************
Output
*******************************************

When Client and Server both are running successfully, some html source code will be displayed at client's terminal window. This source code is serverd by the server running as hidden service to which Tor client has successfully connected.

***************************************
Problem faced/Point to be noted
****************************************

> Sometimes, even though Tor starts successfully at both client and server ends,you may not see html source code at client side, instead you get a message like this "curl: (7) Can't complete SOCKS4 connection to 0.0.0.0:0. (91), request rejected or failed". This problem occurs due to server being not started immediately or causing delay in serving request. This is solved by stopping Tor at client side and rerunning the script 'initialize_client.sh'

> Everytime initialize_server.sh will start a python server and a new onion URL is generated and new 'hostname' file is added to HiddenServiceDir . Tor client need to have information about this new URL else it won't be able to connect to hidden service.

> Make sure nothing is running at the port where you are starting hidden service and also tor is not running before.

*************************************
References
*************************************


[1] https://www.torproject.org/about/overview.html.en
  
[2] https://www.torproject.org/docs/tor-hidden-service.html.en

[3] https://www.torproject.org/docs/hidden-services.html.en

[4] http://www.linuxjournal.com/content/tech-tip-really-simple-http-server-python









