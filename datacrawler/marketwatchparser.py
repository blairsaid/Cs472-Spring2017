from keywordparser import KeywordParser

# Sample Articles Used: 
# http://www.marketwatch.com/story/dupont-nike-kb-home-are-stocks-to-watch-2014-06-27
# http://www.marketwatch.com/story/twitter-co-founder-evan-williams-to-sell-30-of-his-stock-2017-04-06-16103029


class MarketWatchParser(KeywordParser):
    # TODO Maintain this list of abgreviations
    months = {"Apr":4,"June":6}

    def __init__(self,keywords):
        KeywordParser.__init__(self,keywords)

        self.hits = []
        self.time = ""
        self.tickers = []

        self.in_p_tag = False
        self.in_h1_tag = False

        self.in_ticker_tag = False

        self.in_time_stamp = False
        self.in_time_span = False

    # IMPORTANT: maintain this code because itll break if they change the site
    def handle_starttag(self,tag,attr):
        # Read body of story
        if(tag == "p"):
            self.in_p_tag = True
        # Read Headline
        if(tag == "h1"):
            for a in attr:
                if(a[0] == "id" and a[1] == "article-headline"):
                    self.in_h1_tag = True
 
        # Read Published Date
        if(tag == "p"):
            for a in attr:
                if(a[0] == "class" and a[1] == "timestamp"):
                    self.in_time_stamp = True
        if(self.in_p_tag and self.in_time_stamp and tag == "span"):
            self.in_time_span = True

        # Get ticker symbol
        if(tag == "a"):
            for a in attr:
                if(a[1] == "MW_story_quote"):
                    self.in_ticker_tag = True

          

    def handle_endtag(self,tag):
        if(tag == "p"):
            self.in_p_tag = False
            self.in_time_stamp = False
        if(tag == "h1"):
            self.in_h1_tag = False
        if(tag == "a"):
            self.in_ticker_tag = False
        if(tag == "span"):
            self.in_time_span = False

    def handle_data(self,data):
        # Keyword search the story's text
        if(self.in_p_tag or self.in_h1_tag):
            hits = self.keyword_search(data)

            if(len(hits) > 0):
                for tmp in hits:
                    self.hits.append(tmp)
        # Read ticker symbol
        if(self.in_ticker_tag):
            words = data.split(",")
            self.tickers.append(words[0])
            self.in_ticker_tag = False

        # Read Time Stamp
        if(self.in_time_stamp and self.in_time_span):
            self.time = data

    def getDatum(self):
        datum = {}

        # TODO find a better way of selecting the ticker
        datum["ticker"] = self.tickers[0]

        # Filter date
        if(self.time != ""):
            words = self.time.split()
            month = words[0]
            day = words[1][0:len(words[1])]            
            year = words[2]
