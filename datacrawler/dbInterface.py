import mysql.connector
import time

class dbInterface():
    def __init__(self,uid,pw,host):
        self.dbconfig = {"user": uid,"password": pw,"host": host,"database": "fltr"}

    # TODO add error checking for db conenction and data input
    # TODO execute the commands atomically somehow
    def sendLdrBrd(self,data):
        print("sending leaderboard data to database.")
        cnx = mysql.connector.connect(**self.dbconfig) 
        cursor = cnx.cursor()

        clrcmd = "DELETE FROM leaderboard;"
        cursor.execute(clrcmd)

        # Template for adding stock data
        add_stock = ("INSERT INTO leaderboard "
                    "(ticker, volume, price, pct_change, os_shares) "
                    "VALUES (%s, %s, %s, %s, %s)")

        for row in data:
            data_stock = (row["ticker"],str(row["volume"]),str(row["open_price"]),str(row["percent_change"]),str(row["weightedavebasicsharesos"]))
            cursor.execute(add_stock,data_stock)

        cnx.commit()
        cursor.close()
        cnx.close()

    # TODO finish this
    def sendPressData(self,data):
        print("sending press data to database.")
        cnx = mysql.connector.connect(**self.dbconfig) 
        cursor = cnx.cursor()

        add_press = ("INSERT INTO pressboard "
                    "(ticker, title, url, time, open_price, description) "
                    " VALUES (%s, %s, %s, %s, %s, %s)")

        for row in data:
            data_press = (row["ticker"],row["title"],row["url"],str(row["time"]),str(row["open_price"]),str(row["description"]))
            cursor.execute(add_press,data_press)

        cnx.commit()
        cursor.close()
        cnx.close()


