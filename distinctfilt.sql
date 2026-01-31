
CREATE TABLE Student (
  student_id INTEGER PRIMARY KEY,
  name TEXT,
  city TEXT,
  grade INTEGER
);


INSERT INTO Student (student_id, name, city, grade) VALUES
(1, 'Alice Brown', 'Accra', 10),
(2, 'Bob Smith', 'Kumasi', 11),
(3, 'Anna White', 'Accra', 10),
(4, 'Brian Johnson', 'Cape Coast', 12),
(5, 'Alex Green', 'Kumasi', 11);


SELECT *
FROM Student
WHERE name LIKE 'A%';


SELECT *
FROM Student
WHERE city = 'Kumasi' AND grade = 11;


SELECT *
FROM Student
ORDER BY name ASC;


SELECT DISTINCT city
FROM Student;

SELECT DISTINCT city
FROM Student
WHERE name LIKE '%an%'
ORDER BY city;
