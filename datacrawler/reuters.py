import requests
import feedparser
from html.parser import HTMLParser

#TODO get this working with a regular expression for any large sum of money as well
keywords = ["Positive","Receives","Grants","FDA","Approval","Drug Trials",
            "Cancer","Improvements","Benifits","Benifical","Agreement",
            "Partnership","Investors","Billonaire","Carl Ichan","Phase I ",
            "Phase II","Phase III","Successful","Fast Track","Breakout",
            "Increase","Acquire","Accepted","New","Contract","Awarded",
            "Signs","Completes","Merger","Promising ","Gain","Increase",
            "Primary","Endpoints"]

# Searches all the paragraphs for keyword hits
class ReutersParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.in_p_tag = False
        self.paragraphs = []
        self.hits = []

    def handle_starttag(self,tag,attr):
        if(tag == "p"):
            self.in_p_tag = True

    def handle_endtag(self,tag):
        if(tag == "p"):
            self.in_p_tag = False

    def handle_data(self,data):
        if(self.in_p_tag):
            self.paragraphs.append(data)
            hits = self.keyword_search(data)
            if(len(hits) > 0):
                self.hits.append(hits)

    def keyword_search(self,p):
        matchs = []
    
        p_words = p.split()
        for w in p_words:
            for k in keywords:
                if(w == k):
                    matchs.append(k)

        return matchs

    def printHits(self):
        for i in self.hits:
            print("Keyword Match: ",i)            

print("Beginning RSS Crawl.\n")

print("Retrieving RSS Feed.\n")
rss_feed = requests.get("http://feeds.reuters.com/reuters/companyNews").text
rss_decode = feedparser.parse(rss_feed)

print("Beginning Article Crawl.\n")
i = 0
for story in rss_decode.entries:
    print("Article START")
    print("Article #:",i)
    print("Title: ",story.title)
    print("Link: ",story.link)

    article_html = requests.get(story.link).text
    r_parser = ReutersParser()
    r_parser.feed(article_html)
    print("Keywords:")
    r_parser.printHits()
    r_parser.close() 

    print("Article END\n")
    i = i + 1
