# This is currently a very shitty way of loading a config
# Any alteration of the config file will almost instantly
# break this.

# TODO make this use xml or json at a minimum later
class Config():
    def __init__(self,configFileName):
        self.apiPW = ""
        self.apiUID = ""        
        self.fileName = configFileName
        self.intrinioLimit = 0
        self.dbUID = ""
        self.dbPW = ""
        self.loadConfig()

    def loadConfig(self):
        in_file = open(self.fileName,"r")
        fileCnt = in_file.read().split()
        # Just look at this, bad
        self.apiUID = fileCnt[2]        
        self.apiPW = fileCnt[5]
        self.intrinioLimit = fileCnt[8]
        self.dbUID = fileCnt[11]
#        self.dbPW = fileCnt[14]
        self.dbPW = "" # TODO a password needs to be added eventually
        in_file.close()

    def printConfig(self):
        print("Configuration:")
        print("Intrinio Username = ",self.apiUID)
        print("Intrinio Password =",self.apiPW)
        print("Intrinio Limit =",self.intrinioLimit)        
        print("MySQL Username =",self.dbUID)
        print("MySQL Password =",self.dbPW)


