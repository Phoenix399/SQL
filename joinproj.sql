import pandas as pd
import sqlite3

# Create an in-memory database for this food example
conn = sqlite3.connect(":memory:")
cursor = conn.cursor()

# Setup dummy food data
cursor.executescript("""
CREATE TABLE Chefs (Chef_Id INT, Name TEXT);
CREATE TABLE Dishes (Dish_Id INT, Dish_Name TEXT, Chef_Id INT, Price INT);

INSERT INTO Chefs VALUES (1, 'Gordon'), (2, 'Julia'), (3, 'Guy Fieri'), (4, 'Jamie Oliver');
INSERT INTO Dishes VALUES (101, 'Beef Wellington', 1, 50), (102, 'Boeuf Bourguignon', 2, 40), 
                          (103, 'Trash Can Nachos', 3, 20), (104, 'Mystery Salad', NULL, 15);
""")

# 1. INNER JOIN: Only chefs who have a specific dish assigned
inner_food = pd.read_sql("""
    SELECT c.Name, d.Dish_Name
    FROM Chefs c
    INNER JOIN Dishes d ON c.Chef_Id = d.Chef_Id;
""", conn)

# 2. LEFT JOIN: All chefs, even if they don't have a dish on the menu (e.g., Jamie Oliver)
left_food = pd.read_sql("""
    SELECT c.Name, d.Dish_Name
    FROM Chefs c
    LEFT JOIN Dishes d ON c.Chef_Id = d.Chef_Id;
""", conn)

# 3. RIGHT JOIN: All dishes, even those without a chef (SQLite 3.39+)
right_food = pd.read_sql("""
    SELECT c.Name, d.Dish_Name
    FROM Chefs c
    RIGHT JOIN Dishes d ON c.Chef_Id = d.Chef_Id;
""", conn)

# 4. FULL OUTER JOIN: All chefs and all dishes, regardless of a match (SQLite 3.39+)
full_food = pd.read_sql("""
    SELECT c.Name, d.Dish_Name
    FROM Chefs c
    FULL OUTER JOIN Dishes d ON c.Chef_Id = d.Chef_Id;
""", conn)

# 5. CROSS JOIN: Every possible combination of Chef and Dish (Menu planning)
cross_food = pd.read_sql("""
    SELECT c.Name, d.Dish_Name
    FROM Chefs c
    CROSS JOIN Dishes d;
""", conn)

# 6. UNION: A master list of all unique names (Chefs and Dishes combined)
union_food = pd.read_sql("""
    SELECT Name AS Entry_Name FROM Chefs
    UNION
    SELECT Dish_Name FROM Dishes;
""", conn)

print("--- Chefs with Dishes (Inner) ---")
print(inner_food)

conn.close()
