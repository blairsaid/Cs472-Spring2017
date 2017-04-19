# Super Class
from rsscrawler import RSSCrawler

# Crawling Toosl:
import requests
from tickerlist import TickerList

# Parsing Tools:
from dbInterface import dbInterface
import feedparser
from marketwatchparser import MarketWatchParser
from keywordlist import KeywordList

# Standard Library
import time

class RSSMarketWatch(RSSCrawler):
    def __init__(self,domain,crawl_speed):
        RSSCrawler.__init__(self,domain,crawl_speed)

    def makeRequest(self):
        RSSCrawler.makeRequest(self)

        data = []
        for article in self.article_list:
            time.sleep(self.crawl_speed)
            self.last_request_time = time.time()
            self.getCount = self.getCount + 1
            url = article.link # TODO Filter this
            article_http = requests.get(url)

            parser = MarketWatchParser()
            parser.feed(article_http.text)            
            if(len(parser.hits) > 0):
                datum = parser.getDatum() # Gets tickers/time
                datum["url"] = url
                datum["title"] = article.title
                datum["open_price"] = 0
                # The descriptions in the rss feed suck. use first paragraph of story ideally. TODO
#                datum["description"] = article.description
                data.append(datum)
  
        # Still Experimental. 
#        dbInterface.sendPressData(data)         

        # Currently for debugging.
        dbInterface.printPressData(data)
