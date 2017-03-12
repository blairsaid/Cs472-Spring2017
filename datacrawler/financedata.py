from dataitem import DataItem

class FinanceData(DataItem):
    def __init__(self,finJson):
        self.apiReturn = finJson
        self.leaderInserts = []
        self.cvtFinData() 
        self.iterator = -1 # only doing this currently because python doesnt have post incrementation

    # Convert the JSON to a series of sql cmds for insertion into the appropriate table
    def cvtFinData(self):
        self.leaderInserts.append("SQLplaceholder")

    def hasNext(self):
        return self.iterator < len(self.leaderInserts) - 1 

    def getInsertCmd(self):
        self.iterator = self.iterator + 1 
        return self.leaderInserts[self.iterator]
