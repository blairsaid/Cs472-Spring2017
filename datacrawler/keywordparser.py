from html.parser import HTMLParser

class KeywordParser(HTMLParser):
    def __init__(self,keywords):
        HTMLParser.__init__(self)
        self.keywords = keywords

    def keyword_search(self,text):
        matchs = []
    
        words = text.split()
        criteria = self.keywords.getList()
        for w in words:
            for k in criteria:
                if(w == k):
                    matchs.append(k)

        return matchs

    def printHits(self):
        for i in self.hits:
            print("Keyword Match: ",i)            


