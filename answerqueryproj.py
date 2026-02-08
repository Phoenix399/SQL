# Import necessary libraries
import sqlite3
import pandas as pd

# Connect to database
database = 'database.sqlite'
conn = sqlite3.connect(database)
print('Opened data successfully')

# Display all tables in the database
tables = pd.read_sql("""
SELECT *
FROM sqlite_master
WHERE type='table';
""", conn)
print(tables)

# Read Match table
matches = pd.read_sql("""
SELECT *
FROM Match;
""", conn)
print(matches.head())

"""
Conclusion –
- Dataset contains numeric and categorical features
- Some columns contain null values
"""

# 1. DISTINCT – get distinct countries from Player table
result1 = pd.read_sql("""
SELECT DISTINCT Country_Id
FROM Player;
""", conn)
print(result1)

# 2. ORDER BY – list players ordered by name
result2 = pd.read_sql("""
SELECT Player_Name
FROM Player
ORDER BY Player_Name ASC;
""", conn)
print(result2)

# 3. GROUP BY + COUNT – number of players per country
result3 = pd.read_sql("""
SELECT Country_Id, COUNT(Player_Id) AS Total_Players
FROM Player
GROUP BY Country_Id;
""", conn)
print(result3)

# 4. AGGREGATE (COUNT) – total number of matches
result4 = pd.read_sql("""
SELECT COUNT(Match_Id) AS Total_Matches
FROM Match;
""", conn)
print(result4)

# 5. AGGREGATE (MAX) – maximum runs scored in a ball
result5 = pd.read_sql("""
SELECT MAX(Runs_Scored) AS Max_Runs
FROM Ball_by_Ball;
""", conn)
print(result5)

# 6. GROUP BY + ORDER BY – number of cities per country
result6 = pd.read_sql("""
SELECT Country_Id, COUNT(City_Id) AS Total_Cities
FROM City
GROUP BY Country_Id
ORDER BY Total_Cities DESC;
""", conn)
print(result6)

# 7. DISTINCT + ORDER BY – distinct venues alphabetically
result7 = pd.read_sql("""
SELECT DISTINCT Venue_Name
FROM Venue
ORDER BY Venue_Name;
""", conn)
print(result7)

# 8. GROUP BY + COUNT – matches played by each team
result8 = pd.read_sql("""
SELECT Team_Id, COUNT(Match_Id) AS Matches_Played
FROM Match
GROUP BY Team_Id;
""", conn)
print(result8)

# Close connection
conn.close()
