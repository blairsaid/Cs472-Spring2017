import mysql

# This class will need to keep a list of keyword maintined from the database

class KeywordList():
    def __init__(self,dbInterface):
        self.dbIf = dbInterface
        # TODO maintain the list from the database
        # TODO make this eventually return regular expressions
        #TODO get this working with a regular expression for any large sum of money as well
        self.keywords = ["Positive","Receives","Grants","FDA","Approval","Drug Trials",
                        "Cancer","Improvements","Benifits","Benifical","Agreement",
                        "Partnership","Investors","Billonaire","Carl Ichan","Phase I ",
                        "Phase II","Phase III","Successful","Fast Track","Breakout",
                        "Increase","Acquire","Accepted","New","Contract","Awarded",
                        "Signs","Completes","Merger","Promising ","Gain","Increase",
                        "Primary","Endpoints"]


    def getList(self):
        return self.keywords         
