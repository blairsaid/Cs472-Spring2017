# This is currently a very shitty way of loading a config
# Any alteration of the config file will almost instantly
# break this.

class Config():
    def __init__(self,configFileName):
        self.apiPW = ""
        self.apiUID = ""        
        self.fileName = configFileName
        self.intrinioLimit = 0
        self.loadConfig()

    def loadConfig(self):
        in_file = open(self.fileName,"r")
        fileCnt = in_file.read().split()
        # Just look at this, ba4
        self.apiUID = fileCnt[2]        
        self.apiPW = fileCnt[5]
        self.intrinioLimit = fileCnt[8]
        in_file.close()

    def printConfig(self):
        print("Configuration:")
        print("Intrinio Username = ",self.apiUID)
        print("Intrinio Password =",self.apiPW)
        print("Intrinio Limit =",self.intrinioLimit)        


