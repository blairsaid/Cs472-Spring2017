import mysql.connector
import time

class dbInterface():
    def __init__(self,uid,pw,host):
        self.dbconfig = {"user": uid,"password": pw,"host": host,"database": "fltr"}

    # TODO add error checking for db conenction and data input
    # TODO execute the commands atomically somehow
    def sendLdrBrd(self,data):
        print("sending sql cmd to database")
        cnx = mysql.connector.connect(**self.dbconfig) 
        cursor = cnx.cursor()

        clrcmd = "DELETE FROM leaderboard;"
        cursor.execute(clrcmd)

        # Template for adding stock data
        # TODO 'oustandingshares', fix in the database
        add_stock = ("INSERT INTO leaderboard "
                    "(ticker, volume, price, percentchange, oustandingshares) "
                    "VALUES ($%s, %s, %s, %s, %s)")

        for row in data:
            data_stock = (row["ticker"],str(row["volume"]),str(row["open_price"]),str(row["percent_change"]),str(row["weightedavebasicsharesos"]))
            cursor.execute(add_stock,data_stock)

        cnx.commit()
        cursor.close()
        cnx.close()

    # TODO finish this
    def sendPressData(self,data):
        print("RSS test START:")
        print(data)
        print("RSS test END:")
