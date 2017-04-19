# Super Class
from rsscrawler import RSSCrawler

# Crawling Toosl:
import requests
from tickerlist import TickerList

# Parsing Tools:
from dbInterface import dbInterface
import feedparser
from yahfinparser import YahFinParser 
from keywordlist import KeywordList

# Standard Library
import time

class RSSYahoo(RSSCrawler):
    def __init__(self,crawl_speed):
        # Main Yahoo RSS address, sorted by ticker symbol through http options field
        self.yahoo_rss_address = "http://finance.yahoo.com/rss/headline"

        RSSCrawler.__init__(self,self.yahoo_rss_address,crawl_speed)

        # Tickers ordered alphabetically from 1 -> ~3000
        self.ticker_index = 1

    def makeRequest(self):
        # Retrieve the next feed for the next ticker symbol
        tic = TickerList.get(self.ticker_index) # used so ticker list can be updated from db eventually
        self.domain = self.yahoo_rss_address + "?s=" + TickerList.get(self.ticker_index)
        self.ticker_index = self.ticker_index + 1
        RSSCrawler.makeRequest(self)

        # Iterate through the articles
        data = []
        for story in self.article_list:
            # Get Article
            time.sleep(self.crawl_speed)
            self.getCount = self.getCount + 1
            self.last_request_time = time.time()
            url = story.link.split("?")[0]
            story_text = requests.get(url).text

            # Keyword paragraph tag search
            parser = YahFinParser()
            parser.feed(story_text)  
            if(len(parser.hits) > 0):
                tmp = ""
                for kw in parser.hits:
                    tmp = tmp + kw + ","
                if(tic != parser.ticker):
                    print("Ticker mismatch:",tic,"  ||  ",parser.ticker)
                    print("Time:",parser.time)
                    print("URL:",url)

                if(parser.time == None):
                    print("Publish Date(time) not found")
                    print("Article URL:",url)

                story_data = {"ticker":tic,"title":story.title,
                            "url":url,"time":parser.time,
                            "open_price":0.0,"description":"stub",
                            "matchs":tmp}
                data.append(story_data)    
            parser.close()
        if(len(data) > 0):
            dbInterface.sendPressData(data)



    def isAvailable(self):
        return True
