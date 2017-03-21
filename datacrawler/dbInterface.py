import mysql.connector
import time

class dbInterface():
    def __init__(self,uid,pw,host):
        self.dbconfig = {"user": uid,"password": pw,"host": host,"database": "fltr"}
        self.cnx = mysql.connector.connect(**dbconfig)
        self.cursor = cnx.cursor()

    def sendLdrBrd(self,data):
        print("sending sql cmd to database")
                
