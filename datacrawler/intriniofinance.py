from financedata import FinanceData
from crawler import Crawler
import requests
import time

class IntrinioFinance(Crawler):
    def __init__(self,apikey,reqLimit):
        self.reqLimit = reqLimit
        self.domain = "https://api.intrinio.com"
        self.apikey = apikey
        self.getCount = 0

    # entire chain of get requests, not just a single request
    # should return a data object corresponding to the return data from intrinio 
    def makeRequest(self):
        time.sleep(1)
        self.getCount = self.getCount + 1
        print("Making intrinio api request")
        return FinanceData("TEST JSON PLACEHOLDER")
        # only a place holder at the moment

    # just a place holder at the moment
    def isAvailable(self):
        return self.getCount < self.reqLimit
