# Super Class:
from crawler import Crawler

# Crawling Toosl:
import requests

# Parsing Tools:
import feedparser
from keywordlist import KeywordList

# Standard Library
import time

class RSSCrawler(Crawler):
    def __init__(self,domain,crawl_speed):
        Crawler.__init__(self,domain)
        self.kw_list = KeywordList()
        self.crawl_speed = crawl_speed

        self.article_list = []
        

    def makeRequest(self):
        # Grab RSS feed
        self.getCount = self.getCount + 1        
        self.last_request_time = time.time()
        rss_feed_text = requests.get(self.domain).text

        # Decode RSS and crawl through stories
        rss_feed_decode = feedparser.parse(rss_feed_text)
        self.article_list = rss_feed_decode.entries

    def isAvailable(self):
        if(self.getCount == 0):
            return True
        else:
            return False
