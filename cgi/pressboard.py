#!/usr/bin/python3

import cgitb
import mysql.connector
import json

cgitb.enable()

config = {"user": "ec2-user","password": "","host": "127.0.0.1","database": "fltr"}

cnx = mysql.connector.connect(**config)

cursor = cnx.cursor()

query = ("SELECT * FROM pressboard")

cursor.execute(query)

myJSON = []
for row in cursor:
    item = {}
    item["ticker"] = row[0]
    item["title"] = row[1]
    item["url"] = row[2]
    item["time"] = str(row[3])
    item["open_price"] = str(row[4])
    item["description"] = row[5]
    myJSON.append(item)

print("Content-Type: text/html;charset=utf-8\n")
print(json.dumps(myJSON))

cursor.close()
cnx.close()

