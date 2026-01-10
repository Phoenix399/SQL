--NOT NULL is used for name to ensure that every student record has a name
CREATE TABLE IF NOT EXISTS STUDENT (
ROLL TEXT ,
NAME TEXT NOT NULL,
ADDRESS TEXT,
PHONE TEXT,
AGE INTEGER
);

--Insert sample data  into the STUDENT table
INSERT INTO STUDENT (ROLL, NAME, ADDRESS, PHONE, AGE) VALUES
('1' , 'RAM', 'DELHI', '*****', 18),
('2' , 'RAMESH', 'GURGAON', '*****', 18),
('3' , 'SUJIT', 'BANGALORE', '*****', 20),
('4' , 'SURESH', 'CHENNAI', '*****', 18),
('5' , 'AMAN', 'DELHI', '*****', 20),
('6' , 'RAMESH', 'ROHTAK', '*****', 18),
('7' , 'HARSHI', 'GURGAON', '*****', 18);



--Select records from the STUDENT table to verify insertion
SELECT * FROM STUDENT;

--Query students who are 18 years old and live in DELHI
SELECT * FROM STUDENT WHERE AGE = 18 AND ADDRESS = 'DELHI';

-- Query students who are18 years old and named RAM
SELECT * FROM STUDENT WHERE AGE = 18 OR NAME = 'RAM';

--Query students named Ram or Sujit
SELECT * FROM STUDENT WHERE NAME = 'RAM' OR NAME = 'SUJIT';

-- Query students named Ram or aged 20
SELECT * FROM STUDENT WHERE NAME = 'RAM' OR AGE = 20;

--Query students aged 18 and named Ram or Ramesh
SELECT * FROM STUDENT WHERE AGE = 18 AND (NAME = 'RAM' OR NAME = 'RAMESH');
