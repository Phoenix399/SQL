import pandas as pd
import sqlite3

database = 'database.sqlite'

# Connect once
conn = sqlite3.connect(database)
cursor = conn.cursor()

# 1. Create table (with correct syntax)
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER
);
""")

# 2. Insert data (without forcing id - auto increment handles it)
cursor.execute("INSERT INTO students (name, age) VALUES (?, ?)", ('Alice', 14))
cursor.execute("INSERT INTO students (name, age) VALUES (?, ?)", ('Bob', 15))

# Commit inserts
conn.commit()

# 3. Fetch using cursor
cursor.execute("SELECT * FROM students")
rows = cursor.fetchall()
print("Using cursor.fetchall():", rows)

# 4. Fetch using pandas(same open conn)
df = pd.read_sql_query("SELECT * FROM students", conn)
print("\nUsing pandas DataFrame:")
print(df)

# Close connection
conn.close()
