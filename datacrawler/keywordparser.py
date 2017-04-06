from html.parser import HTMLParser
from keywordlist import KeywordList

#TODO make this work with regular expressions
class KeywordParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)

    def keyword_search(self,text):
        matchs = []
    
        words = text.split()
        criteria = KeywordList.getList()
        for w in words:
            for k in criteria:
                if(w == k):
                    matchs.append(k)

        return matchs

    def printHits(self):
        for i in self.hits:
            print("Keyword Match: ",i)            


