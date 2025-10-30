CREATE DATABASE Company;

CREATE TABLE Dept
(
Dname 		VARCHAR(20) 	NOT NULL,
Dnumber 		INT,
Mgr_start_date 	VARCHAR(10),
Mgr_ssn 		INT,

CONSTRAINT dept_pk 
PRIMARY KEY (Dnumber),

CONSTRAINT unique_name
UNIQUE (Dname)
);


CREATE TABLE Dept_locations
(
Dnumber 	INT 			NOT NULL,
Dlocation 	VARCHAR(10) 	NOT NULL,

CONSTRAINT Dept_locations_pk
PRIMARY KEY (Dnumber, Dlocation),

CONSTRAINT dept_locations_fk
FOREIGN KEY (Dnumber) REFERENCES Dept (Dnumber)
);


CREATE TABLE Project
(
Pname 		VARCHAR(10) 	NOT NULL,
Pnumber 	INT,
Plocation 	VARCHAR(10),
Dnumber 	INT 			NOT NULL,

CONSTRAINT proj_pk 
PRIMARY KEY (Pnumber),

CONSTRAINT dept_proj_fk
FOREIGN KEY (Dnumber) REFERENCES Dept (Dnumber)
);


CREATE TABLE Employee
(
Fname 			VARCHAR(20) 	NOT NULL,
Minit 			CHAR,
Lname 		VARCHAR(20) 	NOT NULL,
Ssn 			INT 			NOT NULL,
Bdate 			VARCHAR(10),
Emp_address 		VARCHAR(30),
Sex 			CHAR,
Salary 			INT 			NOT NULL,
Super_ssn                    INT,	
Dno 			INT 			NOT NULL,

CONSTRAINT emp_pk 
PRIMARY KEY (Ssn),

CONSTRAINT employee_supervisor_fk
FOREIGN KEY (Super_ssn) REFERENCES Employee (Ssn),

CONSTRAINT dept_employee
FOREIGN KEY (Dno) REFERENCES Dept (Dnumber)
);


CREATE TABLE Dependent
(
Essn 				INT 			NOT NULL,
Dependent_name 		VARCHAR(20)  	NOT NULL,
Sex 				CHAR 		NOT NULL,
Bdate 				VARCHAR(10),
Relationship 			VARCHAR(10) 	NOT NULL,

CONSTRAINT dependent_pk 
PRIMARY KEY (Essn, Dependent_name),

CONSTRAINT Employee_dependent_fk
FOREIGN KEY (Essn) REFERENCES Employee(Ssn)
);


CREATE TABLE Works_On
(
Essn 	INT 		NOT NULL,
Pno 	INT 		NOT NULL,
Hrs 	INT 		NOT NULL

CONSTRAINT works_pk
PRIMARY KEY (Essn, Pno)

CONSTRAINT proj_works_fk
FOREIGN KEY (Pno) REFERENCES Project(Pnumber),

CONSTRAINT employee_works_fk
FOREIGN KEY (Essn) REFERENCES Employee (Ssn)
);

Alter table Dept
add constraint emp_dept_fk_2
foreign key (Mgr_ssn) references Employee(ssn)
on update cascade
on delete set null;

-- Dept values --
INSERT INTO Dept
VALUES ('Research',1,'22/07/2010',null);

INSERT INTO Dept
VALUES ('HR' , 2, '25/08/2010' ,null);

INSERT INTO Dept
VALUES ('PR',3,'10/07/2011',null);

INSERT INTO Dept
VALUES ('IT',4,'02/06/2010',null);

INSERT INTO Dept
VALUES ('Marketing',5,' ',null);

INSERT INTO Dept
VALUES ('Accounting' ,6, '01/01/2011', null);

-- Employee values --
INSERT INTO Employee(Fname,Minit,Lname,Ssn,Sex,Salary, Dno)
VALUES ('Ahmed','M','Omar',102,'M','3000','1');

INSERT INTO Employee
VALUES ('Mohamed','K','Hassan',101,' ',' ','M','2400','102','1');

INSERT INTO Employee
VALUES ('Aya','L','Yousef',103,'22/07/1960','Heliopolis','F','3000','102','1');

INSERT INTO Employee(Fname,Lname,Ssn,Sex,Salary, Dno)
VALUES ('Noha','Ahmed',104,'F','3500','2');

INSERT INTO Employee
VALUES ('Rana','S','Hamdy',105,'23/04/1967','Sheraton','M','3360','102','2');

INSERT INTO Employee
VALUES ('Nadia','F','Fahmy',106,'21/08/1963','Zamalek','F','2280','102','3');

-- Adding the Mgr_ssn to the Dept table --

UPDATE Dept
SET Mgr_ssn = '101'
WHERE Dnumber = 1;

UPDATE Dept
SET Mgr_ssn = '101'
WHERE Dnumber = 2;

UPDATE Dept
SET Mgr_ssn = '103'
WHERE Dnumber = 4;

UPDATE Dept
SET Mgr_ssn = '104'
WHERE Dnumber = 5;

UPDATE Dept
SET Mgr_ssn = '103'
WHERE Dnumber = 6;

-- Project values --
INSERT INTO Project
VALUES ('Proj101', 101, 'Zamalek', '1');

INSERT INTO Project
VALUES ('Proj102', 102, 'Heliopolis', '1');

INSERT INTO Project
VALUES ('Proj103', 103, 'Maadi', '2');

INSERT INTO Project
VALUES ('Proj104', 104, 'Heliopolis', '2');

INSERT INTO Project
VALUES ('Proj105', 105, 'Nasr city', '3');

INSERT INTO Project
VALUES ('Proj106', 106, 'Heliopolis', '6');

INSERT INTO Project
VALUES ('Proj107', 107, 'Heliopolis', '5');

-- Dependent values --
INSERT INTO Dependent
VALUES (101,'Sara', 'F', '23/04/1996', 'daughter' );

INSERT INTO Dependent
VALUES (102,'Aya', 'F', '12/07/1998', 'daughter' );

INSERT INTO Dependent
VALUES (103,'Ahmed', 'M', '01/06/1995', 'son' );

INSERT INTO Dependent
VALUES (104,'Basel', 'M', '01/02/1997', 'son' );

-- Dept_location values --
INSERT INTO Dept_locations
VALUES (1,'Heliopolis');

INSERT INTO Dept_locations
VALUES (1,'Zamalek');

INSERT INTO Dept_locations
VALUES (2,'Heliopolis');

INSERT INTO Dept_locations
VALUES (3,'Heliopolis');

INSERT INTO Dept_locations
VALUES (3,'Nasr city');

INSERT INTO Dept_locations
VALUES (4,'Zamalek');

INSERT INTO Dept_locations
VALUES (5,'Heliopolis');

INSERT INTO Dept_locations
VALUES (5,'Zamalek');

INSERT INTO Dept_locations
VALUES (6,'Heliopolis');

-- Works_On values --
INSERT INTO Works_On
VALUES (101,101,'2');

INSERT INTO Works_On
VALUES (101,102,'5');

INSERT INTO Works_On
VALUES (102,103,'4');

INSERT INTO Works_On
VALUES (103,102,'4');

INSERT INTO Works_On
VALUES (104,103,'4');

INSERT INTO Works_On
VALUES (105,103,'3');

SELECT Dname, Dnumber
FROM Dept;

SELECT Fname, Lname
FROM Employee
WHERE Ssn = 103;

SELECT Pnumber AS ProjectID, Pname AS ProjectName
FROM Project
WHERE Pname LIKE '%Proj%';

SELECT Dependent_name
FROM Dependent
WHERE Dependent_name NOT IN ('Ahmed', 'Samir', 'Reem');

SELECT DISTINCT Lname, Salary
FROM Employee
WHERE Salary > 2500;

SELECT Fname, Lname
FROM Employee
ORDER BY Fname ASC;

SELECT 
    CONCAT(Fname, ' ', Lname) AS "Full Name",
    Dno AS "Department Number",
    Ssn AS "Employee SSN"
FROM Employee
ORDER BY Lname DESC;
