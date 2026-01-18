DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Teacher;

CREATE TABLE Teacher (
  teacher_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT,
  bonus_rate REAL
);

CREATE TABLE Student (
  student_id INTEGER PRIMARY KEY,
  student_name TEXT NOT NULL,
  city TEXT,
  grade_level INTEGER,
  advisor_id INTEGER
);

CREATE TABLE Enrollment (
  enroll_no INTEGER PRIMARY KEY,
  course_name TEXT,
  fee REAL,
  enroll_date DATE,
  student_id INTEGER,
  teacher_id INTEGER
);

INSERT INTO Teacher VALUES
(5001,'James','New York',0.15),
(5002,'Nail','Paris',0.13),
(5003,'Lauson','San Jose',0.15),
(5005,'Pit','London',0.11),
(5006,'Mc','Paris',0.14),
(5007,'Paul','Rome',0.13);

INSERT INTO Student VALUES
(3001,'Brad','London',NULL,5005),
(3002,'Nick','New York',10,5001),
(3003,'Jozy','Moscow',11,5007),
(3005,'Graham','California',11,5002),
(3007,'Davis','New York',11,5001),
(3008,'Julian','London',12,5002),
(3084,'Fabian','Paris',12,5006),
(3089,'Geoff','Berlin',10,5003);

INSERT INTO Enrollment VALUES
(70001,'Biology',150.50,'2012-10-05',3005,5002),
(70002,'Algebra',65.26,'2012-10-05',3002,5003),
(70004,'PE',110.50,'2012-08-17',3003,5007),
(70005,'French',2400.60,'2012-07-27',3084,5006),
(70007,'Chemistry',948.50,'2012-09-10',3005,5002),
(70009,'History',270.65,'2012-09-10',3001,5005);

SELECT * FROM Teacher;
SELECT * FROM Student;
SELECT * FROM Enrollment;

SELECT student_name, name
FROM Student, Teacher
WHERE Student.advisor_id = Teacher.teacher_id;

SELECT enroll_no, student_name, course_name, fee
FROM Enrollment, Student
WHERE Enrollment.student_id = Student.student_id;

SELECT enroll_no, course_name, name
FROM Enrollment, Teacher
WHERE Enrollment.teacher_id = Teacher.teacher_id;

SELECT * FROM Student
WHERE grade_level >= 11;

SELECT name, SUM(fee)
FROM Teacher, Enrollment
WHERE Teacher.teacher_id = Enrollment.teacher_id
GROUP BY name;

SELECT AVG(fee) FROM Enrollment;
