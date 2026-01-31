import sqlite3

database ='database.sqlite'

conn = sqlite3.connect(database)
print("Opened data successfully")

#Read SQL query for getting all the tables of database into a dataframe
import pandas as pd
tables = pd.read_sql_query("""SELECT *
                                FROM sqlite_master
                                WHERE type='table';""", conn)

tables
#Check team is of all team
teams = pd.read_sql("""SELECT *
                         FROM Team;""", conn)
teams

#REad Table from the database into database
matches = pd.read_sql("""SELECT *
                         FROM Match;""", conn)


"""**Conclusion -**
- 12 Numeric features (Integer and Numeric) and 1 categorical feature (Text)
- 3 columns with null values
"""

matches

# Check details of all the matches won by Mumbai Indians
MI_wins = pd.read_sql("""SELECT *
FROM Match
WHERE Match_Winner = 7;""", conn)

MI_wins

# Check details of all the matches won by Mumbai Indians in last...
MI_wins_last5 = pd.read_sql("""SELECT *
                            FROM Match
                            WHERE Match_Winner == 7;""", conn)
print(MI_wins_last5)

#Check details of all the matches won by Mumbai Indians in last two seasons (2018 and 2019)
MI_S8_S9_wins = pd.read_sql("""SELECT *
                            FROM Match
                            WHERE Match_Winner == 7 AND Season IN (8, 9);""", conn)
print(MI_S8_S9_wins)

new_teams = pd.read_sql("""SELECT *
                            FROM Team
                            WHERE Team_Name LIKE 'De%';""", conn)
print(new_teams)

#Check the minimum and maximum win_margins of all the matches 
win_margins = pd.read_sql("""SELECT MIN(Win_Margin),MAX(Win_Margin) 
                            FROM Match;""", conn)

print(win_margins)
#Print Table info
