# Thomas Teren
# 2-13-17

# These both don't come installed by default.
# "pip install requests" will install requests
# "pip install HTMLParser" will install HTMLParser
#
# I spent a bunch of time this weekend resolving
# dependency problems with Visual Studio this weekend
# so I should be able to help with any issues that come up.

from html.parser import HTMLParser
import requests
import re


# HTMLParser parsers the input feed into a parse tree
# and visits the nodes without doing anything by default.
#
# We override and implement the visit/handle methods and 
# to extract what data we need from the html files.
class FinvizParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.urls = []

    # This method will be called when any start tag is encountered.
    # Will most likely be the most useful to our project.
    def handle_starttag(self,tag,attr):
        if(tag == 'a'):
            for i in attr:
                if i[0] == 'href':
                    self.urls.append(i[1])

    def printURLs(self):
        for i in self.urls:
            print(i)
                    

# script begins here:

# first, pull the html file from finviz.com/news/ashx 
# currently only saves the body of the html reply
finvizhome = requests.get('http://finviz.com/news.ashx').text

# parser object must first be instantiated before use
parser = FinvizParser()

# feed will parse the input into a parse tree
# and then visit the nodes in a single function call.
parser.feed(finvizhome)

#urls = re.findall('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+{}]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+',finvizhome)

# print out the urls encountered in html, hopefully
#parser.printURLs()


# Filter through the urls from the <a> tags and only look for ones with http[s]
# because they are external to finviz.com
externalnews= []
for i in parser.urls:
    if re.match('http[s]?',i) != None  and re.search('news',i) != None:
        externalnews.append(i)


# Filter the urls by site
marketwatch = []
bloomberg = []
wsj = []
bbc = []
for i in externalnews:
    if re.search('www.bloomberg.com',i) != None:
        bloomberg.append(i)
    elif re.search('www.marketwatch.com',i) != None:
        marketwatch.append(i)    
    elif re.search('www.wsj.com',i) != None:
        wsj.append(i)        
    elif re.search('www.bbc.co.uk',i) != None:
        bbc.append(i)

