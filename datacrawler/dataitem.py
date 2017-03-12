
class DataItem():
    def __init__(self):
        self.apiReturn = "" # will be the Json returned from the intrinio api
        self.iterator = -1

    # hasNext() and getInsertCmd() will both be used to 
    # iterate/retrieve all the necessary sql cmds into the database
    def hasNext(self):
        pass

    def getInsertCmd(self):
        pass
