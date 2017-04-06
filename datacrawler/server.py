from config import Config

# Crawlers:
from intriniofinance import IntrinioFinance
from rsscrawler import RSSCrawler
from dbInterface import dbInterface
from rssyahoo import RSSYahoo

# Client to handle server status information
from clientinterface import ClientInterface

# Standard Libraries
import time

class Server():
    def __init__(self,cf):
        self.config = cf
        self.looplength = 3 # Delay time between dispatching each crawler

        # Initialize Database Interface Class with server configuration
        dbInterface.setDBConfig(cf.dbUID,cf.dbPW,cf.dbHost) 

        # Crawler initiation:
        # *******************IMPORTANT****************************
        # Disable or Activate Crawlers by commenting it's line out
        # ********************************************************
        self.crawlers = []
#        self.crawlers.append(IntrinioFinance(cf.apiUID,cf.apiPW,int(cf.intrinioLimit))
        self.crawlers.append(RSSYahoo(1))
        

        # Client interface initiation
        self.client = ClientInterface(self) # client is passed a reference to the server so it may extract the necessary information
        
        
    def start(self):
        i = 0

        print("Starting server main loop\n")

        # TODO include something so the server only runs from 4am-7am
        # Currently iterates between all instantiated crawlers once.
        loop_cnt = 0
        while(loop_cnt < 5):
            # process all the client requests before continuing crawling
            if(self.client.hasRequests()):
                self.client.processRequests()
            if(self.crawlers[i].isAvailable()):
                results = self.crawlers[0].makeRequest()

            #TODO make this better
            time.sleep(self.looplength) # just to slow things down for now, because ec2 micro instances suck
            i = (i+1) % len(self.crawlers) # loop through the crawlers indefinitely
            loop_cnt = loop_cnt + 1

        # any sort of final logging should be done here
