import time
from intriniofinance import IntrinioFinance
from dbInterface import dbInterface
from clientinterface import ClientInterface

class Server():
    def __init__(self):
        # all this stuff can be based on some sort of config file
        self.looplength = 5
        self.crawlers = [ IntrinioFinance("apikey",5) ] # an array of all our web crawlers
        self.dbIf= dbInterface() # sends all the commands to the mysql server
        self.client = ClientInterface(self) # client is passed a reference to the server so it may extract the necessary information
        
        
    def start(self):
        i = 0

        print("Starting server main loop\n")

        # maybe include something so the server only runs from 4am-7am
        while(True):
            # process all the client requests before continuing crawling
            if(self.client.hasRequests()):
                self.client.processRequests()

            print("\n")

            # tell a crawler to begin making a request
            # not necessarily one request, an entire chain that results in data input to the database
            if(self.crawlers[i].isAvailable()):
                results = self.crawlers[i].makeRequest()
                self.dbIf.sendData(results)

            print("\n")

            time.sleep(self.looplength) # just to slow things down for now, because ec2 micro instances suck
            i = (i+1) % len(self.crawlers) # loop through the crawlers indefinitely

        # any sort of final logging should be done here
