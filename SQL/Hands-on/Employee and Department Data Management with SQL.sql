-- CASE STUDY 2

-- Create database 
CREATE DATABASE CASESTUDY2;
USE CASESTUDY2
-- CREATE TABLE
CREATE TABLE LOCATION (LOCATION_ID INT PRIMARY KEY,CITY VARCHAR(20));
CREATE TABLE DEPARTMENT(DEPARTMENT_ID INT PRIMARY KEY,NAME VARCHAR(50),LOCATION_ID INT FOREIGN KEY REFERENCES LOCATION(LOCATION_ID));
CREATE TABLE JOB(JOB_ID INT PRIMARY KEY,DESIGNATION VARCHAR(50)); 
CREATE TABLE EMPLOYEE(EMPLOYEE_ID INT,LAST_NAME VARCHAR(20),FIRST_NAME VARCHAR(20),MIDDLE_NAME VARCHAR(20),JOB_ID INT FOREIGN KEY REFERENCES JOB(JOB_ID),MANAGER_ID INT,
HIRE_DATE DATE,SALARY INT,COMM INT, DEPARTMENT_ID INT FOREIGN KEY REFERENCES DEPARTMENT(DEPARTMENT_ID));

INSERT INTO LOCATION VALUES(122,'New_York'),
(123,'Dallas'),
(124,'Chicago'),
(167,'Boston');
INSERT INTO DEPARTMENT VALUES(10,'Accounting',122),
(20,'Sales',124),
(30,'Research',123),
(40,'Operations',167);
INSERT INTO JOB VALUES(667,'Clerk'),
(668,'Staff'),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager'),
(672,'President');
INSERT INTO EMPLOYEE VALUES(7369,'SMITH','JOHN','Q',667,7902,'17-Dec-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-Feb-85',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-Apr-85',2850,NULL,30),
(7506,'DENIS','LYNN','S',671,7839,'15-May-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-Jun-85',220,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698	,'22-Feb-85',1250,500,30);

SELECT *FROM LOCATION;
SELECT *FROM DEPARTMENT;
SELECT *FROM JOB;
SELECT *FROM EMPLOYEE;

-- Simple Queries:
-- 1. List all the employee details
SELECT * FROM EMPLOYEE;

-- 2. List all the department details
SELECT * FROM DEPARTMENT;

-- 3. List all job details
SELECT * FROM JOB;

-- 4. List all the locations
SELECT * FROM LOCATION;

-- 5. List out the First Name, Last Name, Salary, Commission for all Employees
SELECT First_Name, Last_Name, Salary, Comm FROM EMPLOYEE;

-- 6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as Dep_id
SELECT Employee_id AS [ID of the Employee], Last_Name AS [Name of the Employee], DEPARTMENT_ID AS Dep_id FROM EMPLOYEE;

-- 7. List out the annual salary of the employees with their names only
SELECT First_Name, Last_Name, (Salary * 12) AS Annual_Salary FROM EMPLOYEE;

-- WHERE Condition:
-- 1. List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE Last_Name = 'Smith';

-- 2. List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE WHERE Department_Id = 20;

-- 3. List out the employees who are earning salaries between 3000 and 4500.
SELECT * FROM EMPLOYEE WHERE Salary BETWEEN 3000 AND 4500;

-- 4. List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE WHERE Department_Id IN (10, 20);

-- 5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE Department_Id NOT IN (10, 30);

-- 6. List out the employees whose name starts with 'S'.
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S%';

-- 7. List out the employees whose name starts with 'S' and ends with 'H'.
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S%H';

-- 8. List out the employees whose name length is 4 and start with 'S'.
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S___';

-- 9. List out employees who are working in department 10 and draw salaries more than 3500.
SELECT * FROM EMPLOYEE WHERE Department_Id = 10 AND Salary > 3500;

-- 10. List out the employees who are not receiving commission.
SELECT * FROM EMPLOYEE WHERE Comm IS NULL;

-- ORDER BY Clause:
-- 1: List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT Employee_id, Last_Name
FROM EMPLOYEE
ORDER BY Employee_id ASC;

-- 2: List out the Employee ID and Name in descending order based on salary.
SELECT Employee_id, Last_Name + ', ' + First_Name AS Name
FROM EMPLOYEE
ORDER BY Salary DESC;

-- 3: List out the employee details according to their Last Name in ascending order.
SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC;

-- 4: List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC, Department_Id DESC;

-- GROUP BY and HAVING Clause:
-- 1. How many employees are in different departments in the organization?
SELECT Department_Id, COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
GROUP BY Department_Id;

-- 2. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT Department_Id, 
       MAX(CAST(Salary AS FLOAT)) AS MaxSalary, 
       MIN(CAST(Salary AS FLOAT)) AS MinSalary, 
       AVG(CAST(Salary AS FLOAT)) AS AvgSalary
FROM EMPLOYEE
GROUP BY Department_Id;

-- 3. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT Job_Id, 
       MAX(CAST(Salary AS float)) AS MaxSalary, 
       MIN(CAST(Salary AS float)) AS MinSalary, 
       AVG(CAST(Salary AS float)) AS AvgSalary
FROM EMPLOYEE
GROUP BY Job_Id;

-- 4. List out the number of employees who joined each month in ascending order.
SELECT MONTH(Hire_Date) AS Month, COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
GROUP BY MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);

-- 5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT MONTH(Hire_Date) AS Month, YEAR(Hire_Date) AS Year, COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
GROUP BY MONTH(Hire_Date), YEAR(Hire_Date)
ORDER BY YEAR(Hire_Date), MONTH(Hire_Date);

-- 6. List out the Department ID having at least four employees.
SELECT Department_Id, COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
GROUP BY Department_Id
HAVING COUNT(Employee_id) >= 4;

-- 7. How many employees joined in the month of January?
SELECT COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
WHERE MONTH(Hire_Date) = 1;

-- 8. How many employees joined in the month of January or September?
SELECT COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (1, 9);

-- 9. How many employees joined in 1985?
SELECT COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985;

-- 10. How many employees joined each month in 1985?
SELECT MONTH(Hire_Date) AS Month, COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
GROUP BY MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);

-- 11. How many employees joined in March 1985?
SELECT COUNT(Employee_id) AS NumberOfEmployees
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 3;

-- 12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT Department_Id
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4
GROUP BY Department_Id
HAVING COUNT(Employee_id) >= 3;

-- Joins:
-- 1. List out employees with their department names
SELECT e.Employee_id, e.Last_Name, e.First_Name, d.Name AS Department_Name
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id

-- 2. Display employees with their designations
SELECT e.Employee_id, e.Last_Name, e.First_Name, j.Designation
FROM EMPLOYEE e
JOIN JOB j ON e.Job_Id = j.Job_ID

-- 3. Display the employees with their department names and regional groups
SELECT e.Employee_id, e.Last_Name, e.First_Name, d.Name AS Department_Name, l.City
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
JOIN LOCATION l ON d.Location_Id = l.Location_ID
-- 4. How many employees are working in different departments? Display with department names
SELECT d.Name AS Department_Name, COUNT(e.Employee_id) AS NumberOfEmployees
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
GROUP BY d.Name

-- 5. How many employees are working in the sales department?
SELECT COUNT(e.Employee_id) AS NumberOfEmployees
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
WHERE d.Name = 'Sales'

-- 6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order
SELECT d.Name AS Department_Name, COUNT(e.Employee_id) AS NumberOfEmployees
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
GROUP BY d.Name
HAVING COUNT(e.Employee_id) >= 5
ORDER BY d.Name ASC

-- 7. How many jobs are there in the organization? Display with designations
SELECT j.Designation, COUNT(e.Employee_id) AS NumberOfEmployees
FROM EMPLOYEE e
JOIN JOB j ON e.Job_Id = j.Job_ID
GROUP BY j.Designation

-- 8. How many employees are working in "New York"?
SELECT COUNT(e.Employee_id) AS NumberOfEmployees
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
JOIN LOCATION l ON d.LOCATION_ID = l.Location_ID
WHERE l.City = 'New York'

-- 9. Display the employee details with salary grades
-- (assuming, for example, salary grades are as follows: Grade 1: 0-3000, Grade 2: 3001-6000, Grade 3: 6001-9999)
SELECT Employee_id, Last_Name, First_Name, Salary,
  CASE
    WHEN Salary BETWEEN 0 AND 3000 THEN 'Grade 1'
    WHEN Salary BETWEEN 3001 AND 6000 THEN 'Grade 2'
    WHEN Salary BETWEEN 6001 AND 9999 THEN 'Grade 3'
    ELSE 'Ungraded'
  END AS Salary_Grade
FROM EMPLOYEE

-- 10. List out the number of employees grade wise
SELECT Salary_Grade, COUNT(Employee_id) AS NumberOfEmployees
FROM (
  SELECT Employee_id,
    CASE
      WHEN Salary BETWEEN 0 AND 3000 THEN 'Grade 1'
      WHEN Salary BETWEEN 3001 AND 6000 THEN 'Grade 2'
      WHEN Salary BETWEEN 6001 AND 9999 THEN 'Grade 3'
      ELSE 'Ungraded'
    END AS Salary_Grade
  FROM EMPLOYEE
) sub
GROUP BY Salary_Grade

-- 11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary
SELECT Salary_Grade, COUNT(Employee_id) AS NumberOfEmployees
FROM (
  SELECT Employee_id,
    CASE
      WHEN Salary BETWEEN 0 AND 3000 THEN 'Grade 1'
      WHEN Salary BETWEEN 3001 AND 6000 THEN 'Grade 2'
      WHEN Salary BETWEEN 6001 AND 9999 THEN 'Grade 3'
      ELSE 'Ungraded'
    END AS Salary_Grade
  FROM EMPLOYEE
  WHERE Salary BETWEEN 2000 AND 5000
) sub
GROUP BY Salary_Grade

-- 12 Display the employee details with their manager names.
SELECT E1.Employee_id, E1.Last_Name, E1.First_Name, E1.Middle_Name, E1.Job_Id,
       E2.Employee_id AS Manager_Id, E2.Last_Name AS Manager_Last_Name, E2.First_Name AS Manager_First_Name
FROM EMPLOYEE AS E1
JOIN EMPLOYEE AS E2
ON E1.Manager_Id = E2.Employee_id;

-- 13 Display the employee details who earn more than their managers' salaries.
SELECT E1.*
FROM EMPLOYEE AS E1
JOIN EMPLOYEE AS E2
ON E1.Manager_Id = E2.Employee_id
WHERE E1.Salary > E2.Salary;

-- 14 Show the number of employees working under every manager.
SELECT E2.Employee_id AS Manager_Id, E2.Last_Name AS Manager_Last_Name, E2.First_Name AS Manager_First_Name, COUNT(*) AS Employee_Count
FROM EMPLOYEE AS E1
JOIN EMPLOYEE AS E2
ON E1.Manager_Id = E2.Employee_id
GROUP BY E2.Employee_id, E2.Last_Name, E2.First_Name;

-- 15 Display employee details with their manager names. (Same as query 12)
SELECT E1.Employee_id, E1.Last_Name, E1.First_Name, E1.Middle_Name, E1.Job_Id,
       E2.Employee_id AS Manager_Id, E2.Last_Name AS Manager_Last_Name, E2.First_Name AS Manager_First_Name
FROM EMPLOYEE AS E1
JOIN EMPLOYEE AS E2
ON E1.Manager_Id = E2.Employee_id;

-- 16 Display all employees in sales or operation departments.
SELECT E.*
FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D
ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Operation');

-- SET Operators:
-- 1. List out the distinct jobs in sales and accounting departments.
SELECT DISTINCT j.Designation
FROM JOB j
JOIN EMPLOYEE e ON j.Job_ID = e.Job_Id
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
WHERE d.Name IN ('Sales', 'Accounting');

-- 2. List out all the jobs in sales and accounting departments.
SELECT j.Designation
FROM JOB j
JOIN EMPLOYEE e ON j.Job_ID = e.Job_Id
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
WHERE d.Name IN ('Sales', 'Accounting');

-- 3. List out the common jobs in research and accounting departments in ascending order.
SELECT j.Designation
FROM JOB j
JOIN EMPLOYEE e ON j.Job_ID = e.Job_Id
JOIN DEPARTMENT d ON e.Department_Id = d.Department_Id
WHERE d.Name = 'Research'
AND j.Designation IN (
SELECT j2.Designation
FROM JOB j2
JOIN EMPLOYEE e2 ON j2.Job_ID = e2.Job_Id
JOIN DEPARTMENT d2 ON e2.Department_Id = d2.Department_Id
WHERE d2.Name = 'Accounting'
)
ORDER BY j.Designation ASC;

-- Subqueries:
-- 1. Display the employees list who got the maximum salary
SELECT *
FROM EMPLOYEE
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE);

-- 2. Display the employees who are working in the sales department
SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_Id= D.Department_Id
WHERE D.Name = 'Sales';

-- 3. Display the employees who are working as 'Clerk'
SELECT *
FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

-- 4. Display the list of employees who are living in "New York"
SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_Id
WHERE L.City = 'New York';

-- 5. Find out the number of employees working in the sales department
SELECT COUNT(*) AS SalesEmployeesCount
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

-- 6. Update the salaries of employees who are working as clerks on the basis of 10%
UPDATE EMPLOYEE
SET Salary = Salary * 1.1
FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

-- 7. Delete the employees who are working in the accounting department
DELETE FROM EMPLOYEE
WHERE Department_Id = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Accounting');

-- 8. Display the second highest salary drawing employee details
SELECT TOP 1 *
FROM EMPLOYEE
WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE)
ORDER BY Salary DESC;

-- 9. Display the nth highest salary drawing employee details (replace N with the desired number)
DECLARE @N INT;
SET @N = 3;
SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM EMPLOYEE
) AS RankedEmployees
WHERE SalaryRank = @N;

-- 10. List out the employees who earn more than every employee in department 30
SELECT *
FROM EMPLOYEE E1
WHERE E1.Salary > ALL (
    SELECT E2.Salary
    FROM EMPLOYEE E2
    WHERE E2.Department_Id = 30
);

-- 11. List out the employees who earn more than the lowest salary in department 30.
SELECT *
FROM EMPLOYEE
WHERE Salary > (SELECT MIN(Salary) FROM EMPLOYEE WHERE Department_Id = 30);

-- 12. Find out whose department has no employees.
SELECT d.Department_Id, d.Name
FROM DEPARTMENT d
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE e WHERE e.Department_Id = d.Department_Id);

-- 13. Find out which department has no employees.
SELECT d.Department_Id, d.Name, l.City
FROM DEPARTMENT d
LEFT JOIN LOCATION l ON d.Location_Id = l.Location_ID
WHERE d.Department_Id NOT IN (SELECT DISTINCT Department_Id FROM EMPLOYEE);

-- 14. Find out the employees who earn greater than the average salary for their department.
SELECT e.*
FROM EMPLOYEE e
WHERE CAST(Salary AS decimal) > (
    SELECT AVG(CAST(Salary AS decimal)) 
    FROM EMPLOYEE 
    WHERE Department_Id = e.Department_Id
);