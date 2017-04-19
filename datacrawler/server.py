from config import Config

# Crawlers:
from intriniofinance import IntrinioFinance
from rsscrawler import RSSCrawler
from dbInterface import dbInterface
from rssyahoo import RSSYahoo
from rssmarketwatch import RSSMarketWatch

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
        
        # Intrinio leaderboard crawler. Will only work if MySQL is configured correctly on the host.
#        self.crawlers.append(IntrinioFinance(cf.apiUID,cf.apiPW,int(cf.intrinioLimit))

        # Yahoo Finance RSS Company Crawler
#        self.crawlers.append(RSSYahoo(1))
       
        # Market Watch RSS Crawlers
        # TODO Add the rest of the feeds from http://www.marketwatch.com/rss/
        self.crawlers.append(RSSMarketWatch("http://feeds.marketwatch.com/marketwatch/topstories/",1))

        # Client interface initiation
        self.client = ClientInterface(self)
        
        
    def start(self):
        i = 0

        print("Starting server main loop\n")

        # TODO include something so the server only runs from 4am-7am
        # Currently iterates between all instantiated crawlers once.
        loop_cnt = 0
        while(loop_cnt < len(self.crawlers)):
            # Not yet Implemented.
            # process all the client requests before continuing crawling
            #if(self.client.hasRequests()):
            #    self.client.processRequests()

            if(self.crawlers[i].isAvailable()):
                results = self.crawlers[i].makeRequest()

            time.sleep(self.looplength) # May not actually be important when everything is working.
            i = (i+1) % len(self.crawlers)
            loop_cnt = loop_cnt + 1

        # any sort of final logging should be done here
