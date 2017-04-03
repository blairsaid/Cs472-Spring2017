# Super Class:
from crawler import Crawler

# Crawling Toosl:
import requests

# Parsing Tools:
import feedparser
from pparser import Pparser 
from keywordlist import KeywordList

# Standard Library
import time

class RSSCrawler(Crawler):
    def __init__(self,domain,crawl_speed,dbInterface):
        Crawler.__init__(self)
        self.domain = domain
        self.dbIf = dbInterface
        self.kw_list = KeywordList(self.dbIf)
        self.crawl_speed = crawl_speed

    def makeRequest(self):
        self.last_request_time = time.time()

        # Grab RSS feed
        self.getCount = self.getCount + 1        
        rss_feed_text = requests.get(self.domain).text

        # Decode RSS and crawl through stories
        rss_feed_decode = feedparser.parse(rss_feed_text)
        for story in rss_feed_decode.entries:
            # Get Article
            time.sleep(self.crawl_speed)
            self.getCount = self.getCount + 1
            story_text = requests.get(story.link).text
            t_stamp = time.time()

            # TODO add search for ticker symbol here

            # TODO add intrinio search for open price if ticker is found

            # Keyword paragraph tag search
            parser = Pparser(self.kw_list)
            parser.feed(story_text)  
            data = []
            if(len(parser.hits) > 0):
                tmp = ""
                for kw in parser.hits:
                    tmp = tmp + kw + ","

                story_data = {"ticker":"stub","title":story.title,"url":story.link,
                            "url":story.link,"time":t_stamp,
                            "open_price":0.0,"description":"stub",
                            "matchs":tmp}
                data.append(story_data)    
            
            if(len(parser.hits) > 0):
                self.dbIf.sendPressData(data)

            parser.close()


    def isAvailable(self):
        if(self.getCount == 0):
            return True
        else:
            return False
