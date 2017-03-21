import mysql.connector

config = {"user": "ec2-user","password": "","host": "127.0.0.1","database": "fltr"}


# Privileges on the MySQL server need to be set up before this works
cnx = mysql.connector.connect(**config)
#cnx = mysql.connector.connect(user="ec2-user",password="",host="127.0.0.1",database="fltr")

cursor = cnx.cursor()

query = ("SELECT * FROM leaderboard")

cursor.execute(query)

for i in cursor:
    print(i)

cursor.close()
cnx.close()
