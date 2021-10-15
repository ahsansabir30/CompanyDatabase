CREATE DATABASE companydatabase;
USE companydatabase;

CREATE TABLE departments(
	departmentID INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(50) NOT NULL,
    employees INT DEFAULT 0,
    operationcost INT,
    managerID INT,
    address VARCHAR(50)
);

CREATE TABLE employees(
    employeeID INT PRIMARY KEY AUTO_INCREMENT,
    departmentID INT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    sex VARCHAR(1),
    employeerole VARCHAR(100),
    managerID INT,
    datestarted DATE,
    salary INT,
    date_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(departmentID) REFERENCES departments(departmentID) ON DELETE SET NULL,
    CONSTRAINT sex CHECK (sex IN ('M','F', 'O'))
 );
 
ALTER TABLE departments ADD FOREIGN KEY(managerID) REFERENCES employees(employeeID) ON DELETE SET NULL;

-- creating triggers to update the departments table (managers)
CREATE TRIGGER managerupdatedepartment500 BEFORE UPDATE ON employees FOR EACH ROW
	UPDATE departments SET managerID=(SELECT employeeID FROM employees WHERE employeerole LIKE '%Manager' AND departmentID=500)
	WHERE departmentID=500;
 
CREATE TRIGGER managerupdatedepartment501 BEFORE UPDATE ON employees FOR EACH ROW
	UPDATE departments SET managerID=(SELECT employeeID FROM employees WHERE employeerole LIKE '%Manager' AND departmentID=501)
	WHERE departmentID=501;

CREATE TRIGGER managerupdatedepartment502 BEFORE UPDATE ON employees FOR EACH ROW 
	UPDATE departments SET managerID=(SELECT employeeID FROM employees WHERE employeerole LIKE '%Manager' AND departmentID=502)
	WHERE departmentID=502;
 
CREATE TRIGGER managerupdatedepartment503 BEFORE UPDATE ON employees FOR EACH ROW 
	UPDATE departments SET managerID=(SELECT employeeID FROM employees WHERE employeerole LIKE '%Manager' AND departmentID=503)
	WHERE departmentID=503;

CREATE TRIGGER managerupdatedepartment504 BEFORE UPDATE ON employees FOR EACH ROW 
	UPDATE departments SET managerID=(SELECT employeeID FROM employees WHERE employeerole LIKE '%Manager' AND departmentID=504)
	WHERE departmentID=504;

CREATE TRIGGER employeecount_insert AFTER INSERT ON employees FOR EACH ROW 
	UPDATE departments SET employees=(SELECT COUNT(employees) FROM employees WHERE departmentID=NEW.departmentID)
	WHERE departmentID=NEW.departmentID;

CREATE TRIGGER employeecount_delete AFTER DELETE ON employees FOR EACH ROW 
	UPDATE departments SET employees=(SELECT COUNT(employees) FROM employees WHERE departmentID=OLD.departmentID)
	WHERE departmentID=OLD.departmentID;
  
CREATE TRIGGER employeeoperatingcost_insert AFTER INSERT ON employees FOR EACH ROW 
	UPDATE departments SET operationcost=(SELECT SUM(salary) FROM employees WHERE departmentID=NEW.departmentID)
	WHERE departmentID=NEW.departmentID;

CREATE TRIGGER employeeoperatingcost_update AFTER UPDATE ON employees FOR EACH ROW
	UPDATE departments SET operationcost = (SELECT SUM(salary) FROM employees WHERE departmentID = NEW.departmentID) 
	WHERE departmentID=NEW.departmentID;
    
CREATE TRIGGER employeeoperatingcost_delete AFTER DELETE ON employees FOR EACH ROW
	UPDATE departments SET operationcost = (SELECT SUM(salary) FROM employees WHERE departmentID = OLD.departmentID) 
	WHERE departmentID=OLD.departmentID;

INSERT INTO departments(departmentID, department, address) VALUES
(500,'HR','11 Kenilworth Road, Barry,CF63 2HB'),
(501,'Marketing', '10 Leicester Avenue, Cliftonville,CT9 3BZ'),
(502,'Accounting', '139 Rochester Road, Gravesend,DA12 2JE'),
(503,'IT', 'Lees Farmhouse, Green Lane, Rotherwick,RG27 9BA'),
(504,'Warehouse', 'Southings Farm Barn, Main Road, Westfield,TN35 4SL');

INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(NULL, 'Kye', 'Wyatt', 'M', 'Operation Manager', '2020-07-01', 70250);
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(500, 'Rohit', 'Horne', 'M', 'HR Manager', '2020-07-23', 35800),
(500, 'Ananya', 'Hodges', 'F', 'Talent Management', '2020-07-25', 21000),
(500, 'Liya', 'Shannon','F', 'HR Compliance', '2020-08-10', 22000);
INSERT INTO Employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(501, 'Yasmeen', 'Santos', 'F', 'Marketing Manager', '2020-07-25', 30000),
(501, 'Tarun', 'Hibbert', 'M', 'Social Media', '2020-10-16', 25890),
(501, 'Callan', 'Hurst', 'M', 'Advert','2020-09-21', 27250),
(501, 'Kelsea', 'Bob', 'F', 'Research', '2020-12-04', 25897);
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(502, 'Tasnia', 'Ashley', 'F', 'Accounting Manager', '2020-07-02', 50000),
(502, 'Bayley', 'Moore', 'O', 'Payroll', '2020-07-03', 32891),
(502, 'Nojus', 'Millar', 'M', 'Budgeting', '2020-12-08', 34891),
(502, 'Tayyab', 'Simmondsr', 'M', 'Reports and Financial Statements', '2021-01-21', 36891),
(502, 'Shanice', 'Galindo', 'F', 'Incoming/Outgoing payments', '2021-01-06', 32651),
(502, 'Tommy-Lee', 'Walker', 'M', 'Record-Keeping', '2021-01-21', 39891),
(502, 'Gracie-Mae', 'Harrington', 'F', 'Taxation', '2020-09-1', 42846);
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(503, 'Dominic', 'Fowler', 'M', 'IT Manager', '2020-07-29', 45846),
(503, 'Karla', 'Travis', 'F', 'Help Desk Analyst and Support', '2020-09-14', 27856),
(503, 'Grady', 'Castillo', 'O', 'Network Engineer', '2020-10-24', 31726),
(503, 'Reid', 'Andrews', 'M', 'Hardware Technician', '2020-08-01', 28726),
(503, 'Conah', 'Akhtar', 'M', 'Web developer', '2020-07-09', 39726),
(503, 'Brianna', 'Kenny', 'F', 'User Experience Designer', '2020-11-5', 34510),
(503, 'Brianna', 'Kenny', 'F', 'User Experience Designer', '2020-11-5', 34510);
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(504, 'Joe', 'Hoffman', 'M', 'Warehouse Manager', '2020-07-26', 47254),
(504, 'Eoghan', 'Daniel', 'M', 'Recieve', '2020-07-30', 24589),
(504,'Conrad','East', 'M', 'Recieve', '2020-08-01', 24589),
(504,'Gianluca', 'Hodge', 'F', 'Stow', '2020-07-30', 24589),
(504,'Fiona', 'Whittle', 'F', 'Stow', '2020-08-02', 24589),
(504,'Fardeen', 'Chandler', 'M', 'Stow', '2020-08-02', 24589),
(504,'Liyah', 'Mccarthy', 'F', 'Pick', '2020-08-03', 24589),
(504,'Lyndon', 'Esparza', 'O', 'Pick','2020-08-03', 24589),
(504,'Ayaana', 'Oneill', 'F', 'Pick', '2020-08-04', 24589),
(504,'Arthur', 'Haas', 'M', 'Packing', '2020-08-01', 24589);
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(504,'Mike', 'Howard', 'M', 'Packing', '2020-07-30', 24589),
(504,'Jamie', 'Cherry', 'M', 'Packing', '2020-08-04', 24589),
(504,'Rayhaan', 'Underwood', 'M', 'Packing', '2020-09-27', 24589),
(504,'Manisha', 'Farrington', 'F', 'Dock', '2020-08-02', 24589),
(504,'Ryan', 'Molloy', 'M', 'Dock', '2020-08-02', 24589),
(504,'Liyah', 'Smyth', 'F', 'Dock', '2020-08-05', 24589),
(504,'Tonisha', 'Goodwin', 'F', 'Delivery','2020-08-06', 24589),
(504,'Harriett', 'Contreras', 'M', 'Delivery', '2020-08-04', 24589),
(504,'Arthur','Baas', 'M', 'Delivery', '2020-08-01', 24589),
(504,'Mike', 'Jeff', 'M', 'Packing', '2021-09-29', 24589),
(504,'Mike', 'Lee', 'M', 'Packing', '2021-08-01', 24589);	

UPDATE employees SET managerID=1 WHERE departmentID=500;
UPDATE employees SET managerID=4 WHERE departmentID=501;
UPDATE employees SET managerID=8 WHERE departmentID=502;
UPDATE employees SET managerID=15 WHERE departmentID=503;
UPDATE employees SET managerID=22 WHERE departmentID=504;
UPDATE employees SET managerID=1 WHERE employeerole LIKE '%Manager';
UPDATE employees SET managerID=NULL WHERE employeeID=1;

-- testing triggers, to see if the managers have been updated on the departments table
SELECT * FROM departments;
--triggers - for employeed count and the operation cost for running each department (assuming the only cost is labour)
-- testing tigger employeeoperationcost_delete/ employeecount_delete
DELETE FROM employees WHERE employeeID=43;
SELECT operationcost FROM departments WHERE departmentID=504;
SELECT employees FROM departments;
-- testing trigger employeeoperationcost_update
UPDATE employees SET salary=25589 WHERE departmentID=504 AND employeerole LIKE 'R%';
SELECT operationcost FROM departments WHERE departmentID = 504;
-- testing trigerrs employeeoperatingcost_insert/ employeecount_insert
INSERT INTO employees(departmentID, firstName, lastName, sex, employeeRole, dateStarted, salary) VALUES
(504,'Jog', 'Stearn', 'M', 'Picker', '2020-08-15', 24589);
SELECT employees FROM departments WHERE departmentID=504;
SELECT operationcost FROM departments WHERE departmentID=504;

-- deletion table - if an employee leaves (we can store this information in the employee deleted table)
-- we insert information into this, using the trigger employeesdeletiont
CREATE TABLE employeesdeleted(
	  employeeID INT,
    departmentID INT,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    sex VARCHAR(1),
    employeerole VARCHAR(100),
    managerID INT,
    datestarted DATE,
    salary INT,
    date_modified_main TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
 );
 
DELIMITER //
CREATE TRIGGER employeesdeletiont
BEFORE DELETE ON employees 
FOR EACH ROW
BEGIN 
	INSERT INTO employeesdeleted VALUES(OLD.employeeID, OLD.departmentID, OLD.firstName, OLD.lastName, OLD.sex, OLD.employeerole, OLD.managerID, OLD.datestarted, OLD.salary, OLD.date_modified);
END //
DELIMITER ; 

-- testing trigger employeesdeletiont, by deleting a employee from the employee table
DELETE FROM employees WHERE employeeID=30;
SELECT * FROM employeesdeleted;

-- employeeloyalty procedure allows us to see the loyalty of each employee
DELIMITER //
CREATE PROCEDURE employeeloyalty(
     IN pemployeeID INT,
     OUT pemployeeloyalty VARCHAR(20))
BEGIN 
     DECLARE loyalty INT DEFAULT 0;
     
     SELECT DATEDIFF(CURDATE(), datestarted) INTO loyalty
     FROM employees
     WHERE employeeID = pemployeeID;
     
     IF loyalty>= 100 THEN SET pemployeeloyalty = 'OG';
	 ELSEIF loyalty BETWEEN 50 AND 100 THEN SET pemployeeloyalty='GOLD';   
	 ELSE SET pemployeeloyalty = 'NEW';
	END IF;
END //
DELIMITER ;
CALL employeeloyalty(43, @level);
SELECT @level;

CREATE PROCEDURE totalsalary(IN pdepartmentID INT,
                             OUT ptotalsalary INT)
 SET ptotalsalary = (SELECT SUM(salary) FROM employees WHERE departmentID=pdepartmentID);
CALL totalsalary('504', @salary);
SELECT @salary;

-- cursor - list of employee names
DELIMITER //
CREATE PROCEDURE createemployeeslist (
	INOUT employeeslist VARCHAR(5000))
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE employeesname VARCHAR(100) DEFAULT "";
	DEClARE cursor_employees CURSOR FOR SELECT firstName FROM employees;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursor_employees;
    
	getemployees: LOOP
		FETCH cursor_employees 
        INTO employeesname;
		IF finished = 1 THEN 
		LEAVE getemployees;
		END IF;
		SET employeeslist = CONCAT(employeesname,",",employeeslist);
	END LOOP getemployees;
	CLOSE cursor_employees;
END //
DELIMITER ;
SET @employeelist = ""; 
CALL createemployeeslist(@employeelist); 
SELECT @employeelist;

-- employeenames - using a procedure(cursor) to update the table with the first name and last name of each employee 
CREATE TABLE employeenames(
  Forename VARCHAR(100),
  Surname VARCHAR(100));

DELIMITER //
CREATE PROCEDURE employeetable_cursor()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cfirstName VARCHAR(100);
  DECLARE clastName VARCHAR(100);
  DECLARE cursor_name CURSOR FOR SELECT firstName, lastName FROM employees;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cursor_name;

  read_loop: LOOP
    FETCH cursor_name INTO cfirstName, clastName;
    IF done THEN
      LEAVE read_loop;
    END IF;
      INSERT INTO employeenames(Forename, Surname) VALUES (cfirstName, clastName);
	END LOOP;
  CLOSE cursor_name;
END //
DELIMITER ;

CALL employeetable_cursor;
SELECT * FROM employeenames;

-- Nonclustered Index 
CREATE INDEX employeedetails ON employees(firstName, lastName, sex);
CREATE INDEX employeeincome ON employees(employeeID, salary, sex);

-- Queries
-- first name, surname (whilst forcing the use of an index)
SELECT firstName AS Forename, lastName AS Surname FROM employees FORCE INDEX(employeedetails) WHERE sex='M'; 
-- department (limited by 1)
SELECT * FROM departments LIMIT 1;
-- maximum salary and average salary by department 
SELECT MAX(SALARY), AVG(salary), departmentID FROM employees GROUP BY departmentID ORDER BY MAX(salary) ASC;
-- data about employees from the department accounting (with the employers salary over 40,000)
SELECT * FROM employees WHERE departmentID=502 AND salary>40000;
-- joining the first name and last name 
SELECT CONCAT(firstName,' ', lastName) AS Fullname FROM employees;
-- amount of employees in the company (and by sex)
SELECT COUNT(employeeID) FROM employees;
SELECT COUNT(employeeID), sex FROM employees GROUP BY sex;
-- employees initials
SELECT SUBSTRING(firstName,2,4) AS 'Substring' FROM employees;
SELECT CONCAT(SUBSTRING(firstName,1,1),'.',SUBSTRING(lastName,1,1)) AS 'Initials' FROM employees; 
-- average salary by sex
SELECT AVG(salary), sex FROM employees GROUP BY sex;
-- employee tenure
SELECT firstName, 
	   lastName, 
       DATEDIFF(CURDATE(), datestarted) 
FROM employees;
-- average employee tenure (by sex)
SELECT DATEDIFF(CURDATE(), datestarted), AVG(DATEDIFF(CURDATE(), datestarted)), sex FROM employees GROUP BY sex;
-- employee tenure (by months)
SELECT TIMESTAMPDIFF(MONTH,datestarted,CURDATE()) FROM employees;
-- amount of employees by department
SELECT COUNT(employeeID), departmentID FROM employees GROUP BY departmentID;
-- total salary by departments
SELECT SUM(salary), departmentID FROM employees GROUP BY departmentID;
-- list of departments in company
SELECT DISTINCT(departmentID) FROM employees;
-- highest salary by department compared to the lowest salary paid (by department)
SELECT MAX(salary), MIN(salary), departmentID FROM employees GROUP BY departmentID;
-- department name, id and employees 
SELECT  departments.department, 
        employees.departmentID, 
        employees.firstName, 
        employees.lastName,
        salary
FROM employees LEFT JOIN departments ON employees.departmentID=departments.departmentID GROUP BY departmentID;
-- employee ID and name where employees name starts with the letter A
SELECT employeeID, 
       firstName, 
       lastName 
FROM employees WHERE firstName LIKE 'A%';
-- Highest and lowest salart paid by the company
SELECT MAX(salary) FROM employees UNION SELECT MIN(salary) FROM employees;
-- common table expressions
WITH cte AS (SELECT departmentID, firstname, lastname FROM employees)
SELECT firstname, lastname FROM cte WHERE departmentid=501;
-- % of employees by department
SELECT((SELECT COUNT(employeeID) FROM employees WHERE departmentID=501)*100/count(departmentID)) FROM employees; 
SELECT departments.department, employees.departmentID, COUNT(*)*100/(SELECT COUNT(*) FROM employees) AS Percentage
FROM employees FULL JOIN departments ON employees.departmentID=departments.departmentID GROUP BY departmentID;
-- Total employees and salary by department
SELECT COUNT(employeeid) AS totalemployees,
       SUM(salary) AS totalsalary,
       departmentID
FROM employees GROUP BY departmentID;
-- Case, seeing which employees earn more, same or less than the average employees in the UK
SELECT firstName, lastName,
 CASE 
  WHEN salary>=31461 THEN 'Above Avearge'
  WHEN salary=31461 THEN 'Average'
  ELSE 'Below Average'
 END AS 'Salary Rating'
FROM employees ORDER BY employeeID;
-- employeeID, name, role and total number of employees per role
SELECT employeeID, 
       firstname, 
       lastname,
       employeerole,
       COUNT(*) OVER (PARTITION BY employeerole) AS 'Total no. of employees per role'
FROM employees ORDER BY employeeID;
-- department name and employee first name 
SELECT d.departmentID, department, firstname FROM employees AS e JOIN departments AS d
ON e.departmentID=d.departmentID;  