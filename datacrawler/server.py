import time
from intriniofinance import IntrinioFinance
from dbInterface import dbInterface
from clientinterface import ClientInterface
from config import Config

class Server():
    def __init__(self,cf):
        # all this stuff can be based on some sort of config file
        self.config = cf
        self.looplength = 5
        self.crawlers = [IntrinioFinance(cf.apiUID,cf.apiPW,int(cf.intrinioLimit))] # an array of all our web crawlers
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

            if(self.crawlers[i].isAvailable()):
                results = self.crawlers[i].makeRequest()
                self.dbIf.sendData(results)

            print("\n")

            time.sleep(self.looplength) # just to slow things down for now, because ec2 micro instances suck
            i = (i+1) % len(self.crawlers) # loop through the crawlers indefinitely

        # any sort of final logging should be done here
