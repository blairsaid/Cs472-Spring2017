# This will process all the client requests while the server is running
# Will use socket programming in the future

import time

class ClientInterface():
    def __init__(self,server):
        self.server = server
        self.sockloc = "" # location of the listening socket
        self.sock = -1 # still need to figure out socket programming in python
        self.cnx = {}
        self.codes = {} # codes corresponding to what data the client wants back from the running server
   
    # Check of a client is connecting to the unix socket
    def hasRequests(self):
#        return True
#        print("Client has requested server information, waiting to be served.")
        pass

    # Return the requested data to the client through the socket
    def processRequests(self):
        #time.sleep(1)
        #print("Processing client information requests")
        pass
    
