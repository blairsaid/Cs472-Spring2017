from keywordparser import KeywordParser

class YahFinParser(KeywordParser):
    def __init__(self):
        KeywordParser.__init__(self)

        self.hits = []
        self.time = ""
        self.ticker = ""        

        self.in_p_tag = False

    def handle_starttag(self,tag,attr):
        if(tag == "p"):
            self.in_p_tag = True
        # TODO maintain this code because itll break if they change the site
        if(tag == "time"):
            for a in attr:
                if(a[0] == "datetime"):
                    self.time = a[1]
        if(tag == "a"):
            for a in attr:
                if(a[0] == "href"):
                    if(a[1][0:5] == "/q?s="):
                        self.ticker = a[1][5:len(a[1])]            
            

    def handle_endtag(self,tag):
        if(tag == "p"):
            self.in_p_tag = False

    def handle_data(self,data):
        if(self.in_p_tag):
            hits = self.keyword_search(data)

            if(len(hits) > 0):
                for tmp in hits:
                    self.hits.append(tmp)
