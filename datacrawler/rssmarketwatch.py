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

class RSSMarketWatch(RSSCrawler):
    def __init__(self,domain,crawl_speed):
        RSSCrawler.__init__(self,domain,crawl_speed)

    def makeRequest(self):
        RSSCrawler.makeRequest(self)

        data = []
        for story in self.article_list:
            time.sleep(self.crawl_speed)
            self.last_request_time = time.time()
            self.getCount = self.getCount + 1
            url = story.link.split("?")[0]
            story_html = requests.get(story.link)

            parser = MarketWatchParser()
            parser.feed(story_text.text)            
            if(len(parser.hits) > 0):
                datum = parser.getDatum()         
   
         
