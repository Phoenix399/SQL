import sqlite3

# Connect to the SQLite database
conn = sqlite3.connect("database.db")  # replace with your database file name
cursor = conn.cursor()

# Query to get all table names
cursor.execute("""
SELECT name 
FROM sqlite_master 
WHERE type='table';
""")

# Fetch and print tables
tables = cursor.fetchall()
print("Tables in the database:")
for table in tables:
    print(table[0])

# Close the connection
conn.close()
