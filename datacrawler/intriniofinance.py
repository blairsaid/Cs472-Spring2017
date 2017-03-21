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
        self.dbIf = dbInterface
        self.getCount = 0

    # entire chain of get requests, not just a single request
    # sends the data to the database interface 
    def makeRequest(self):
        print("Making intrinio api request")

        # Generate the API call
        conditions = "conditions=volume~gte~250000,percent_change~gte~.05,weightedavebasicsharesos~lte~50000000,open_price~gte~.01,close_price~gte~.01"
        order = "order_column=percent_change" 
        direction = "order_direction=desc"
        ldrcall = self.domain + "/securities/search?" + conditions + "&" + order + "&" + direction

        # Get the Data from Intrinio
        self.getCount = self.getCount + 1
        ldrBrdJS = requests.get(ldrcall,auth=(self.apiUID,self.apiPW)).text # a json is returned from intrinio
        ldrDecode = json.loads(ldrBrdJS)

        # Send the data to the database
        # TODO this will likely need to be changed
        self.dbIf.sendLdrBrd(ldrDecode["data"])

    # TODO rate limit this later, maybe no more than once every 5 seconds?
    def isAvailable(self):
        return self.getCount < self.reqLimit

