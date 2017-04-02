from config import Config


# Crawlers:
from intriniofinance import IntrinioFinance
from rsscrawler import RSSCrawler
from dbInterface import dbInterface

# Client to handle server status information
from clientinterface import ClientInterface

# Standard Libraries
import time

class Server():
    def __init__(self,cf):
        self.config = cf
        self.looplength = 3

        self.dbIf= dbInterface(cf.dbUID,cf.dbPW,cf.dbHost) 

        # Crawler initiation:
        self.crawlers = []
#        self.crawlers.append(IntrinioFinance(cf.apiUID,cf.apiPW,int(cf.intrinioLimit),self.dbIf))
        self.crawlers.append(RSSCrawler("http://feeds.marketwatch.com/marketwatch/realtimeheadlines/",1,self.dbIf))
        self.crawlers.append(RSSCrawler("https://www.bloomberg.com/view/rss",1,self.dbIf))
        self.crawlers.append(RSSCrawler("https://feeds.feedburner.com/MarketFolly",1,self.dbIf))
        self.crawlers.append(RSSCrawler("https://feeds2.feedburner.com/afraidtotrade/NRSd",1,self.dbIf))

        # Client interface initiation
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
            print("\n")
            time.sleep(self.looplength) # just to slow things down for now, because ec2 micro instances suck
            i = (i+1) % len(self.crawlers) # loop through the crawlers indefinitely

        # any sort of final logging should be done here
