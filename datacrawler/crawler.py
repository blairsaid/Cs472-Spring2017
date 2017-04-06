import requests
import time

# Abstract class

class Crawler():
    def __init__(self,domain):
        self.domain = domain
        self.getCount = 0 # total number of get requests made by the crawler
        self.last_request_time = time.time()

    def makeRequest(self):
        pass

    def isAvailable(self):
        pass    

