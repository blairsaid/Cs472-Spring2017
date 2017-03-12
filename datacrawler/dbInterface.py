import mysql.connector
from dataitem import DataItem
import time

class dbInterface():
    def __init__(self):
        pass

    def sendData(self,data):
        while(data.hasNext()):
            time.sleep(1)            
            print("Sending sql cmd to database!")
            data.getInsertCmd() # throwing out the cmd just to test functionality atm
                
