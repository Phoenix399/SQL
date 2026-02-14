import pandas as pd
import sqlite3

conn = sqlite3.connect("database.sqlite")

# Show tables
tables = pd.read_sql("""
SELECT name FROM sqlite_master WHERE type='table';
""", conn)
print(tables)

# INNER JOIN
inner_join = pd.read_sql("""
SELECT c.Country_Id, c.Country_Name, ci.City_Name
FROM Country c
INNER JOIN City ci
ON c.Country_Id = ci.Country_Id;
""", conn)
print(inner_join)

# LEFT JOIN
left_join = pd.read_sql("""
SELECT *
FROM Player
LEFT JOIN Season
ON Player.Player_Id = Season.Man_of_the_Series;
""", conn)
print(left_join)

# CROSS JOIN
cross_join = pd.read_sql("""
SELECT c.Country_Name, ci.City_Name
FROM Country c
CROSS JOIN City ci;
""", conn)
print(cross_join)

# UNION
union = pd.read_sql("""
SELECT Player_Name AS Name FROM Player
UNION
SELECT Team_Name FROM Team;
""", conn)
print(union)

conn.close()
