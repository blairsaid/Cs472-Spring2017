from crawler import Crawler
import requests
import time
import json

class IntrinioFinance(Crawler):
    def __init__(self,apiUID,apiPW,reqLimit,dbInterface):
        self.reqLimit = reqLimit
        self.domain = "https://api.intrinio.com"
        self.apiUID = apiUID
        self.apiPW = apiPW
        self.dbInterface = dbInterface
        self.getCount = 0

    # entire chain of get requests, not just a single request
    # should return an array of dictionaries corresponding to the leaderboard
    def makeRequest(self):
        print("Making intrinio api request")

        ldrcall = self.domain + "/securities/search?conditions=volume~gte~250000,percent_change~gte~.05,weightedavebasicsharesos~lte~50000000,open_price~gte~.01,close_price~gte~.01&order_column=percent_change&order_direction=desc"

        self.getCount = self.getCount + 1
        ldrBrdJS = requests.get(ldrcall,auth=(self.apiUID,self.apiPW)).text # a json is returned from intrinio
        ldrDecode = json.load(ldrBrdJS)
        return ldrDecode["data"]

    # TODO rate limit this later, maybe no more than once every 5 seconds?
    def isAvailable(self):
        return self.getCount < self.reqLimit

