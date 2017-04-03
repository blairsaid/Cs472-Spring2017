from keywordparser import KeywordParser

class Pparser(KeywordParser):
    def __init__(self,keywords):
        KeywordParser.__init__(self,keywords)
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
                for tmp in hits:
                    self.hits.append(tmp)
