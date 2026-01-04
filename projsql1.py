CREATE TABLE IF NOT EXISTS student (
    student_id TEXT,
    name TEXT,
    class TEXT,
    address TEXT,
    phone_number TEXT
);

INSERT INTO student (student_id, name, class, address, phone_number) VALUES
('SCH/2026/001', 'James Hoog', 'JSS1', 'New York', '1234567890'),
('SCH/2026/002', 'Nail Knite', 'JSS1', 'Paris', '1234567891'),
('SCH/2026/003', 'Pit Alex', 'JSS2', 'London', '1234567892'),
('SCH/2026/004', 'Mc Lyon', 'JSS2', 'Athens', '1234567893'),
('SCH/2026/005', 'Paul Adam', 'JSS3', 'Rome', '1234567894'),
('SCH/2026/006', 'Lauson Hen', 'JSS3', 'San Jose', '1234567895');

SELECT * FROM student;
