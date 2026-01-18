

CREATE TABLE IF NOT EXISTS Teacher (
  teacher_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL,
  bonus_rate REAL NOT NULL CHECK (bonus_rate >= 0 AND bonus_rate <= 1)
);

CREATE TABLE IF NOT EXISTS Student (
  student_id INTEGER PRIMARY KEY,
  student_name TEXT NOT NULL,
  city TEXT NOT NULL,
  grade_level INTEGER,
  advisor_id INTEGER,
  FOREIGN KEY (advisor_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE IF NOT EXISTS Enrollment (
  enroll_no INTEGER PRIMARY KEY,
  course_name TEXT NOT NULL,
  fee REAL NOT NULL,
  enroll_date DATE,
  student_id INTEGER NOT NULL,
  teacher_id INTEGER NOT NULL,
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- Sample teachers
INSERT OR IGNORE INTO Teacher (teacher_id, name, city, bonus_rate) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.15),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Sample students
INSERT OR IGNORE INTO Student (student_id, student_name, city, grade_level, advisor_id) VALUES
(3002, 'Nick Rimando', 'New York', 10, 5001),
(3007, 'Brad Davis', 'New York', 11, 5001),
(3005, 'Graham Zusi', 'California', 11, 5002),
(3008, 'Julian Green', 'London', 12, 5002),
(3084, 'Fabian Johnson', 'Paris', 12, 5006),
(3089, 'Geoff Cameron', 'Berlin', 10, 5003),
(3003, 'Jozy Altidore', 'Moscow', 11, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);

-- Sample enrollments (course registrations)
INSERT OR IGNORE INTO Enrollment (enroll_no, course_name, fee, enroll_date, student_id, teacher_id) VALUES
(70001, 'Biology 101', 150.50, '2012-10-05', 3005, 5002),
(70009, 'World History', 270.65, '2012-09-10', 3001, 5005),
(70002, 'Algebra I', 65.26,  '2012-10-05', 3002, 5003),
(70004, 'Physical Ed', 110.50, '2012-08-17', 3003, 5007),
(70007, 'Chemistry', 948.50, '2012-09-10', 3005, 5002),
(70005, 'French Language', 2400.60,'2012-07-27', 3084, 5006);

-- ================================================
-- Example queries (school-themed)
-- ================================================

-- 1) Matching students and teachers by city (local advisors)
SELECT s.student_name AS student, t.name AS teacher, t.city
FROM Student s
JOIN Teacher t ON s.city = t.city;

-- 2) Linking students to their assigned advisor
SELECT s.student_name AS student, t.name AS advisor
FROM Student s
JOIN Teacher t ON s.advisor_id = t.teacher_id;

-- 3) Enrollments where student's city does NOT match the teacher's city
SELECT e.enroll_no, s.student_name, s.city AS student_city, t.city AS teacher_city, e.course_name
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Teacher t ON e.teacher_id = t.teacher_id
WHERE LOWER(s.city) <> LOWER(t.city);

-- 4) All enrollments with student names and course details
SELECT e.enroll_no, s.student_name, e.course_name, e.fee, e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
ORDER BY e.enroll_date DESC;

-- 5) Students with a defined grade level (non-NULL)
SELECT student_name AS student, grade_level
FROM Student
WHERE grade_level IS NOT NULL
ORDER BY grade_level DESC;

-- 6) Teachers whose bonus rate is between 0.12 and 0.14
SELECT s.student_name AS student, t.name AS teacher, t.bonus_rate
FROM Student s
JOIN Teacher t ON s.advisor_id = t.teacher_id
WHERE t.bonus_rate BETWEEN 0.12 AND 0.14;

-- 7) Calculate bonus earned per enrollment for upperclass students (grade_level >= 11)
SELECT e.enroll_no,
       s.student_name,
       e.course_name,
       e.fee,
       t.bonus_rate AS bonus_rate,
       ROUND(e.fee * t.bonus_rate, 2) AS bonus_amount
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Teacher t ON e.teacher_id = t.teacher_id
WHERE s.grade_level >= 11
ORDER BY bonus_amount DESC;

-- 8) Total fees and enrollment count per teacher (aggregates)
SELECT t.teacher_id, t.name,
       COALESCE(SUM(e.fee), 0) AS total_fees_collected,
       COUNT(e.enroll_no) AS enrollments_count
FROM Teacher t
LEFT JOIN Enrollment e ON t.teacher_id = e.teacher_id
GROUP BY t.teacher_id, t.name
ORDER BY total_fees_collected DESC;

-- 9) Average course fee per student
SELECT s.student_id, s.student_name, ROUND(AVG(e.fee), 2) AS avg_fee
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_fee DESC;

-- 10) Rank teachers by total collected fees using a window function
SELECT name, total_fees,
       RANK() OVER (ORDER BY total_fees DESC) AS teacher_rank
FROM (
  SELECT t.name, COALESCE(SUM(e.fee), 0) AS total_fees
  FROM Teacher t
  LEFT JOIN Enrollment e ON t.teacher_id = e.teacher_id
  GROUP BY t.teacher_id, t.name
) sub;

-- 11) Students who have an enrollment fee greater than the average enrollment fee
SELECT DISTINCT s.student_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
WHERE e.fee > (SELECT AVG(fee) FROM Enrollment);

-- 12) Defensive check: find rows that would violate referential integrity (if any)
SELECT 'enrollments_missing_teacher' AS problem, e.enroll_no, e.teacher_id
FROM Enrollment e
LEFT JOIN Teacher t ON e.teacher_id = t.teacher_id
WHERE t.teacher_id IS NULL
UNION ALL
SELECT 'students_missing_advisor' AS problem, s.student_id, s.advisor_id
FROM Student s
LEFT JOIN Teacher t ON s.advisor_id = t.teacher_id
WHERE s.advisor_id IS NOT NULL AND t.teacher_id IS NULL;
