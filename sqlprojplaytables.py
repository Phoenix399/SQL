# Connect with SQLite database
import sqlite3
import pandas as pd

database = 'marks.db'
conn = sqlite3.connect(database)
print("Opened database successfully")

# Create table
conn.execute("""
CREATE TABLE IF NOT EXISTS Marks (
  roll_no INTEGER,
  name TEXT,
  subject TEXT,
  marks INTEGER
);
""")

# Insert values
conn.execute("DELETE FROM Marks;")  # optional: clear old data
conn.executemany("""
INSERT INTO Marks (roll_no, name, subject, marks)
VALUES (?, ?, ?, ?);
""", [
    (1, 'Ama', 'Math', 78),
    (2, 'Kofi', 'Math', 85),
    (3, 'Yaa', 'Science', 92),
    (4, 'Kojo', 'Math', 65),
    (5, 'Abena', 'Science', 88)
])

conn.commit()

# Show all tables in database
tables = pd.read_sql_query("""
SELECT *
FROM sqlite_master
WHERE type='table';
""", conn)
print(tables)

# 1. Display all records
all_records = pd.read_sql("""
SELECT * FROM Marks;
""", conn)
print(all_records)

# 2. Students who scored more than 80
above_80 = pd.read_sql("""
SELECT name, marks
FROM Marks
WHERE marks > 80;
""", conn)
print(above_80)

# 3. Minimum marks
min_marks = pd.read_sql("""
SELECT MIN(marks) AS minimum_marks
FROM Marks;
""", conn)
print(min_marks)

# 4. Maximum marks
max_marks = pd.read_sql("""
SELECT MAX(marks) AS maximum_marks
FROM Marks;
""", conn)
print(max_marks)

# 5. Maximum marks in Math
max_math = pd.read_sql("""
SELECT MAX(marks) AS max_math_marks
FROM Marks
WHERE subject = 'Math';
""", conn)
print(max_math)

# 6. Minimum marks in Science
min_science = pd.read_sql("""
SELECT MIN(marks) AS min_science_marks
FROM Marks
WHERE subject = 'Science';
""", conn)
print(min_science)

# Close connection
conn.close()
