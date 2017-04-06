import mysql
from dbInterface import dbInterface

# This class will need to keep a list of keyword maintined from the database

class KeywordList():
    keywords = ["Positive","Receives","Grants","FDA","Approval","Drug Trials",
                        "Cancer","Improvements","Benifits","Benifical","Agreement",
                        "Partnership","Investors","Billonaire","Carl Ichan","Phase I ",
                        "Phase II","Phase III","Successful","Fast Track","Breakout",
                        "Increase","Acquire","Accepted","New","Contract","Awarded",
                        "Signs","Completes","Merger","Promising ","Gain","Increase",
                        "Primary","Endpoints"]


    # TODO make this sync with the database
    def getList():
        return KeywordList.keywords         
