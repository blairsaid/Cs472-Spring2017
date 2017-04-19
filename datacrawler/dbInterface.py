import mysql.connector
import time

# TODO add error checking for db conenction and data input
class dbInterface():
    dbconfig = {}
    def setDBConfig(uid,pw,host):
        dbInterface.dbconfig["user"] = uid
        dbInterface.dbconfig["password"] = pw
        dbInterface.dbconfig["host"] = host
        dbInterface.dbconfig["database"] = "fltr"

    def sendLdrBrd(data):
        print("sending leaderboard data to database.")
        cnx = mysql.connector.connect(**dbInterface.dbconfig) 
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

    # TODO check for empty keys before sending to database.
    def sendPressData(data):
        print("sending press data to database.")

        cnx = mysql.connector.connect(**dbInterface.dbconfig) 
        cursor = cnx.cursor()

        # Template for adding press data.
        add_press = ("INSERT INTO pressboard "
                    "(ticker, title, url, time, open_price, description) "
                    " VALUES (%s, %s, %s, %s, %s, %s)")

        for row in data:
            data_press = (row["tickers"],row["title"],row["url"],str(row["time"]),str(row["open_price"]),str(row["description"]))
            cursor.execute(add_press,data_press)

        cnx.commit()
        cursor.close()
        cnx.close()

    def printPressData(data):
        print("Printing Press Data START")
        
        if(len(data) == 0):
            print("No Press Data Present.")
            print("Printing Press Data END")
            return

        for datum in data:
            print("\nArticle START")
            print(datum)
#            print("Tickers: ",datum.get("tickers",default="'ticker' not found in article."))
#            print("Title: ",datum.get("title",default="'title' not found in article."))
#            print("URL: ",datum.get("url",default="'url' not found in article."))
#            print("Published date: ",datum.get("time",default="'time' not in article found."))
#            print("Open Price: ",datum.get("open_price",default="'open_price' not retrieved from intrinio."))
#            print("Description: ",datum.get("description",default="'description' not found."))
#            print("Article END\n")
    
        print("Printing Press Data END")
