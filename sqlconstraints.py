import sqlite3

conn = sqlite3.connect('database.sqlite')

print("Opened database successfully")

#Create a new table in given datbase woth mention constrains
conn.execute('''CREATE TABLE CLASS_10 
            (SNO INT PRIMARY KEY NOT NULL,
            Roll_No INT NOT NULL,
            Name TEXT NOT NULL,
            AGE INT DEFAULT (15),  
            GENDER TEXT NOT NULL,
            Email_ID TEXT NOT NULL, 
            Contact_No REAL NOT NULL);''')

print("Table created successfully")

#Enter data for 3 different entries 
conn.execute("INSERT INTO CLASS_10 (SNO, Roll_No, Name, AGE, GENDER, Email_ID, Contact_No) " \
"VALUES (1, 101, 'Alice', 15, 'Female', 'alice@example.com', 9876543210)")

conn.execute("INSERT INTO CLASS_10 (SNO, Roll_No, Name, AGE, GENDER, Email_ID, Contact_No) " \
"VALUES (2, 102, 'Bob', 16, 'Male', 'bob@example.com', 9876543211)")

conn.execute("INSERT INTO CLASS_10 (SNO, Roll_No, Name, AGE, GENDER, Email_ID, Contact_No) " \
"VALUES (3, 103, 'Charlie', 17, 'Male', 'charlie@example.com', 9876543212)")

#Save the changess
conn.commit()
print("Records created successfully")

#Display all the tables of this database
import pandas as pd
tables = pd.read_sql("""SELECT *
                     FROM sqlite_master
                    WHERE type='table';""", conn)
print(tables)

#REad Tabble from the databse into datframe
class_10_d = pd.read_sql("SELECT * "
                        "FROM CLASS_10", conn)

class_10_d.head()
