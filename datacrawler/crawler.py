import requests

# Abstract class

class Crawler():
    def __init__(self):
        self.domain = "" # website domain name
        self.getCount = 0 # total number of get requests made by the crawler

    def makeRequest(self):
        pass

    def isAvailable(self):
        pass    

