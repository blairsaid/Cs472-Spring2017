import mysql.connector
import time

class dbInterface():
    def __init__(self):
        pass

    def sendFinancialData(self,data):
        for d in data:
            print("sending sql cmd to database")
                
