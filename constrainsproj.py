import pandas as pd
import numpy as np
import sqlite3

# Connect to database
database = 'database.sqlite'
conn = sqlite3.connect(database)
print("Opened database successfully")

# Display all tables in the database
df = pd.read_sql("""
SELECT *
FROM sqlite_master
WHERE type='table';
""", conn)
print(df)

# -------- PLAYER TABLE --------
player = pd.read_sql("""
SELECT *
FROM Player;
""", conn)
print(player.head())

null_player = pd.read_sql("""
SELECT *
FROM Player
WHERE Player_Name IS NULL;
""", conn)
print(null_player)

# -------- TEAM TABLE --------
team = pd.read_sql("""
SELECT *
FROM Team;
""", conn)
print(team.head())

null_team = pd.read_sql("""
SELECT *
FROM Team
WHERE Team_Name IS NULL;
""", conn)
print(null_team)

# -------- SEASON TABLE --------
season = pd.read_sql("""
SELECT *
FROM Season;
""", conn)
print(season.head())

null_season = pd.read_sql("""
SELECT *
FROM Season
WHERE Season_Year IS NULL;
""", conn)
print(null_season)

# -------- VENUE TABLE --------
venue = pd.read_sql("""
SELECT *
FROM Venue;
""", conn)
print(venue.head())

null_venue = pd.read_sql("""
SELECT *
FROM Venue
WHERE Venue_Name IS NULL;
""", conn)
print(null_venue)

# Close connection
conn.close()
