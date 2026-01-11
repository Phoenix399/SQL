CREATE TABLE IF NOT EXISTS student(
 student_id TEXT,
    name TEXT,
    class TEXT,
    subject_name TEXT,
    marks INTEGER
);

INSERT INTO student (student_id, name, class, subject_name, marks) VALUES
('SCH/2026/001', 'James Hoog', 'JSS1', 'Mathematics', 85),
('SCH/2026/002', 'Nail Knite', 'JSS1', 'Mathematics', 78),
('SCH/2026/003', 'Pit Alex', 'JSS2', 'Mathematics', 92),
('SCH/2026/004', 'Mc Lyon', 'JSS2', 'Mathematics', 88),
('SCH/2026/005', 'Paul Adam', 'JSS3', 'Mathematics', 95),
('SCH/2026/006', 'Lauson Hen', 'JSS3', 'Mathematics', 80);
SELECT COUNT(*) AS total_students FROM student;
SELECT AVG(marks) AS average_marks FROM student;
SELECT SUM(marks) AS total_marks FROM student;
SELECT MIN(marks) AS minimum_marks FROM student;
SELECT MAX(marks) AS maximum_marks FROM student;
