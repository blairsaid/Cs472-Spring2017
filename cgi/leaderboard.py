#!/usr/bin/python3

import cgitb
import mysql.connector
import json

cgitb.enable()

config = {"user": "ec2-user","password": "","host": "127.0.0.1","database": "fltr"}

cnx = mysql.connector.connect(**config)

cursor = cnx.cursor()

query = ("SELECT * FROM leaderboard")

cursor.execute(query)

myJSON = []
for row in cursor:
    item = {}
    item["ticker"] = row[0]
    item["volume"] = str(row[1])
    item["price"] = str(row[2])
    item["pct_change"] = str(row[3])
    item["os_shares"] = str(row[4])
    myJSON.append(item)

print("Content-Type: text/html;charset=utf-8\n")
print(json.dumps(myJSON))

cursor.close()
cnx.close()

