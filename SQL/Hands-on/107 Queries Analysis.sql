--First create database abd use it
create database big_assignment
use big_assignment

-- now import datasets SUDIES,DOFTWARE,PROGRAMER
CREATE TABLE studies (PNAME varchar(20), INSTITUTE varchar(20), COURSE varchar(20), COURSE_FEE int );
INSERT INTO studies VALUES('ANAND','SABHARI','PGDCA',4500),('ALTAF','COIT','DCA',7200), 
('JULIANA','BDPS','MCA',22000),('KAMALA','PRAGATHI','DCA',5000),
('MARY','SABHARI','PGDCA ',4500),('NELSON','PRAGATHI','DAP',6200),
('PATRICK','PRAGATHI','DCAP',5200), ('QADIR','APPLE','HDCA',14000),
('RAMESH','SABHARI','PGDCA',4500),('REBECCA','BRILLIANT','DCAP',11000),
('REMITHA','BDPS','DCS',6000),('REVATHI','SABHARI','DAP',5000),('VIJAYA','BDPS','DCA',48000);

CREATE TABLE software (PNAME varchar(20), TITLE varchar(20), DEVELOPIN varchar(20), SCOST decimal(10,2), DCOST int, SOLD int);
INSERT INTO software VALUES( 'MARY','README','CPP',300, 1200, 84),('ANAND','PARACHUTES','BASIC',399.95, 6000, 43), 
('ANAND','VIDEO TITLING','PASCAL',7500, 16000, 9), 
('JULIANA','INVENTORY','COBOL',3000, 3500, 0),('KAMALA','PAYROLL PKG.','DBASE',9000, 20000, 7), 
('MARY','FINANCIAL ACCT.','ORACLE',18000, 85000, 4), 
('MARY','CODE GENERATOR','C',4500, 20000, 23), 
('PATRICK','README','CPP',300, 1200, 84), 
('QADIR','BOMBS AWAY','ASSEMBLY',750, 3000, 11), 
('QADIR','VACCINES','C',1900, 3100, 21), 
('RAMESH','HOTEL MGMT.','DBASE',13000, 35000, 4), 
('RAMESH','DEAD LEE','PASCAL',599.95, 4500, 73),  
('REMITHA','PC UTILITIES','C',725, 5000, 51), 
('REMITHA','TSR HELP PKG.','ASSEMBLY',2500, 6000, 7),  
('REVATHI','HOSPITAL MGMT.','PASCAL',1100, 75000, 2), 
('VIJAYA','TSR EDITOR','C',900, 700, 6);

CREATE TABLE programer (PNAME varchar(20), DOB date, DOJ date, GENDER varchar(2), PROF1 varchar(20), PROF2 varchar(20), SALARY int);
 INSERT INTO programer VALUES('ANAND','12-Apr-66','21-Apr-92','M','PASCAL','BASIC',3200), 
 ('ALTAF','02-Jul-64','13-Nov-90','M','CLIPPER','COBOL',2800), 
 ('JULIANA','31-Jan-60','21-Apr-90','F','COBOL','DBASE',3000), 
 ('KAMALA','30-Oct-68','02-Jan-92','F','C','DBASE',2900), 
 ('MARY','24-Jun-70','01-Feb-91','F','CPP','ORACLE',4500), 
 ('NELSON','11-Sep-85','11-Oct-89','M','COBOL','DBASE',2500),  
 ('PATRICK','10-Nov-65','21-Apr-90','M','PASCAL','CLIPPER',2800), 
 ('QADIR','31-Aug-65','21-Apr-91','M','ASSEMBLY','C',3000), 
 ('RAMESH','03-May-67','28-Feb-91','M','PASCAL','DBASE',3200),
 ('REBECCA','01-Jan-67','01-Dec-90','F','BASIC','COBOL',2500), 
 ('REMITHA','19-Apr-70','20-Apr-93','F','C','ASSEMBLY',3600),
 ('REVATHI','02-Dec-69','02-Jan-92','F','PASCAL','BASIC',3700), 
 ('VIJAYA','14-Dec-65','02-May-92','F','FOXPRO','C',3500);

SELECT*FROM STUDIES

SELECT*FROM SOFTWARE

SELECT*FROM PROGRAMER



--1 Find out the selling cost AVG for packages developed in Pascal

select avg(SCOST) as Avg_scost from SOFTWARE where DEVELOPIN ='PASCAL';

--2 Display Names, Ages of all Programmers

select *into PROGRAMERU from(select *, year(DOB) as YEAR from PROGRAMER)cr;
select PNAME,2023-YEAR as age from PROGRAMERU;

--3 Display the Names of those who have done the DAP Course

select PNAME,COURSE from STUDIES where COURSE='DAP';

--4 Display the Names and Date of Births of all Programmers Born in January. 

select *into PROGRAMERM from(select *,month(DOB) as MONTH from PROGRAMER)cr;
select PNAME,DOB from PROGRAMERM where MONTH = '01';

--5 . What is the Highest Number of copies sold by a Package? 

select *into #msold from(select TITLE,sum(SOLD)  as Highest_no_copies from SOFTWARE
group by TITLE)cr;
select *from #msold
select max(Highest_no_copies) as Highest_copies from #msold;

--6 Display lowest course Fee.

select min(COURSE_FEE) from STUDIES

--7 How many programmers done the PGDCA Course? 

select count(COURSE) from STUDIES where COURSE ='PGDCA';


--8 How much revenue has been earned thru sales of Packages Developed in C

select sum(SCOST*SOLD) as Revenue from SOFTWARE where DEVELOPIN='c'

--9 Display the Details of the Software Developed by Ramesh. 

select * from SOFTWARE where PNAME='RAMESH';

--10 How many Programmers Studied at Sabhari? 

select count(PNAME) from STUDIES where INSTITUTE='SABHARI';

--11 Display details of Packages whose sales crossed the 2000 Mark

select *into #sale from(select *,sum(SCOST*SOLD) as Sales from SOFTWARE group by PNAME,TITLE,DEVELOPIN,SCOST,DCOST,SOLD)cr; 
select *from #sale where Sales > 2000; 


--12. Display the Details of Packages for which Development Cost have been recovered.

select *into #sale1 from(select *,sum(SCOST*SOLD) as Sales from SOFTWARE group by PNAME,TITLE,DEVELOPIN,SCOST,DCOST,SOLD)cr; 
select *from #sale1 where Sales >= DCOST;

--13. What is the cost of the costliest software development in Basic?

select TITLE,DCOST from SOFTWARE where DEVELOPIN = 'BASIC';

--14. How many Packages Developed in DBASE?

select count(TITLE) as Packages from SOFTWARE where DEVELOPIN ='DBASE';

--15. How many programmers studied in Pragathi?

select Count(PNAME) as No_Programers from STUDIES where INSTITUTE ='PRAGATHI';

16. How many Programmers Paid 5000 to 10000 for their course?

select count(PNAME) as No_Programers from STUDIES where  COURSE_FEE between 5000 and 10000  ;

--17. What is AVG Course Fee
select avg(COURSE_FEE) as AVG_COURSE_FEE from STUDIES;

--18. Display the details of the Programmers Knowing C.

select *from PROGRAMER where PROF1='C' OR PROF2 ='C';

19. How many Programmers know either COBOL or PASCAL.

select count(PNAME) from PROGRAMER where PROF1='COBOL' or PROF2='COBOL' or PROF1='PASCAL'or PROF2='PASCAL';

--20. How many Programmers Don’t know PASCAL and C

select count(PNAME) from PROGRAMER where PROF1 !='PASCAL' and PROF2 !='C' and PROF1!='C'and PROF2!='PASCAL';

--21. How old is the Oldest Male Programmer.

select *into #oldm from(select *,2023-YEAR as Age from PROGRAMERU)cr 
select *from #oldm
select max(AGE) as Oldest from #oldm where GENDER='M'; 

--22. What is the AVG age of Female Programmers?

select avg(Age) as Avg_age_of_women from #oldm  where GENDER ='F';

--23. Calculate the Experience in Years for each Programmer and Display with their
names in Descending order.

select *into PROGRAMERex from(select *, year(DOJ) as YEAR1 from PROGRAMER)cr;
select*from PROGRAMERex
select PNAME,2023-YEAR1 as Experience from PROGRAMERex
order by Experience  desc;

-- 24. Who are the Programmers who celebrate their Birthday’s During the Current
Month?

select PNAME,DOB from PROGRAMERM where MONTH = '05';

--25. How many Female Programmers are there?

select count(GENDER) from PROGRAMER where GENDER='F';

--26. What are the Languages studied by Male Programmers.

select *into #un from(select PROF1 as Language from PROGRAMER where GENDER ='M'
union
select PROF2 from PROGRAMER where GENDER ='M')cr
select*from #un
select count(Language) as No_Language from #un

--27. What is the AVG Salary?

select avg(SALARY) as Avg_salary from PROGRAMER

--28. How many people draw salary 2000 to 4000?

select count(PNAME) as Peoples from PROGRAMER where SALARY between 2000 and 4000;

--29. Display the details of those who don’t know Clipper, COBOL or PASCAL.

select * from PROGRAMER where PROF1 !='CLIPPER'and PROF1 !='COBOL'and PROF1 !='PASCAL' and PROF2 !='CLIPPER'and PROF2 !='COBOL'and PROF2 !='PASCAL'; 

--30. Display the Cost of Package Developed By each Programmer

select PNAME,TITLE,SCOST from SOFTWARE 

--31. Display the sales values of the Packages Developed by the each Programmer.

select PNAME,sum(SCOST*SOLD) as Sales from SOFTWARE
group by PNAME;

--32. Display the Number of Packages sold by Each Programmer.

select PNAME,sum(SOLD) as No_Packages from SOFTWARE 
group by PNAME;

--33. Display the sales cost of the packages Developed by each Programmer Language wise. 

select DEVELOPIN,sum(SCOST*SOLD) as sales_cost from SOFTWARE
group by DEVELOPIN

--34. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy.

select DEVELOPIN,avg(DCOST) as avg_development_cost,avg(SCOST) as avg_selling_cost,
case 
when sum(SOLD)=0 then null
else avg(SCOST/nullif(SOLD,0)) end as avg_per_copy from SOFTWARE
group by DEVELOPIN

--35. Display each programmer’s name, costliest and cheapest Packages Developed by him or her

select PNAME,max(DCOST) as Costliest_package,min(DCOST) as Cheapest_package from SOFTWARE
group by PNAME;

--36. Display each institute name with number of Courses, Average Cost per Course.

select INSTITUTE,count(distinct COURSE) as No_of_Course,avg(COURSE_FEE) as Avg_cost from STUDIES
group by INSTITUTE;

--37. Display each institute Name with Number of Students.

select INSTITUTE,count(PNAME) as NO_of_Student from STUDIES
group by INSTITUTE;

--38. Display Names of Male and Female Programmers. Gender also.

select PNAME,GENDER from PROGRAMER;

--39. Display the Name of Programmers and Their Packages.

select a.PNAME,b.TITLE from PROGRAMER as a
inner join
SOFTWARE as b
on a.PNAME=b.PNAME

--40. Display the Number of Packages in Each Language Except C and C++.

select DEVELOPIN,count(TITLE) as No_of_Packages from SOFTWARE 
group by DEVELOPIN
having DEVELOPIN != 'c' and DEVELOPIN != 'CPP';

--41. Display the Number of Packages in Each Language for which Development Cost is less than 1000.

select count(TITLE) as No_of_Packages from SOFTWARE where DCOST <1000;

--42. Display AVG Difference between SCOST, DCOST for Each Package.

select *into #dtable from(select avg(SCOST) as avg_scost,avg(DCOST) as avg_dcost from SOFTWARE)cr
select avg_scost-avg_dcost as avg_diff from #dtable;

--43. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered.

select *into #tb from (select PNAME,sum(DCOST-(SCOST*SOLD)) as reco from SOFTWARE group by PNAME )cr
select *into #tn from(select *from #tb where reco>0)cr 
select sum(a.SCOST) as Total_scost ,sum(a.DCOST) as total_Dcost,sum(b.reco) as amount_to_be_recoverd from SOFTWARE as a
full join
#tn as b
on a.PNAME=b.PNAME

--44. Display Highest, Lowest and Average Salaries for those earning more than 2000.

select max(SALARY) as Highest,min(SALARY) as Lowest,avg(SALARY) from PROGRAMER where SALARY>2000;

--45. Who is the Highest Paid C Programmers?

select PNAME from PROGRAMER where SALARY= (select max(SALARY) from PROGRAMER where PROF1='C' or PROF2='C');

--46. Who is the Highest Paid Female COBOL Programmer?

select PNAME from PROGRAMER where GENDER='F' and SALARY= (select max(SALARY) from PROGRAMER where PROF1='COBOL'or PROF2='COBOL');

--47. Display the names of the highest paid programmers for each Languag

select p.PROF1 AS LANGUAGE, MAX(p.SALARY) AS MAX_SALARY, 
    stuff((select ', ' + PNAME
           FROM PROGRAMER
           where PROF1 = p.PROF1
           and SALARY = MAX(p.SALARY)
           for xml path('')), 1, 2, '') as Programer
from PROGRAMER p
group by p.PROF1;

--48. Who is the least experienced Programmer.

select top 1 PNAME
from PROGRAMER
order by DOJ desc;

--49. Who is the most experienced male programmer knowing PASCAL.

select top 1 PNAME, DOJ AS DateOfJoining, 
datediff(year, DOJ, getdate()) as ExperienceInYears
from PROGRAMER
where GENDER = 'M' and (PROF1 = 'PASCAL' or PROF2 = 'PASCAL')
order by DOJ;

--50. Which Language is known by only one Programmer?
select p.PROF1 as PROF
from PROGRAMER p
where not exists (
  select 1
  from PROGRAMER p2
  where p2.PROF1 = p.PROF1 and p2.PNAME <> p.PNAME
)
and not exists (
  select 1
  from PROGRAMER p3
  where p3.PROF2 = p.PROF1 and p3.PNAME <> p.PNAME
)
union
select p.PROF2 as PROF
from PROGRAMER p
where not exists (
  select 1
  from PROGRAMER p2
  where p2.PROF1 = p.PROF2 and p2.PNAME <> p.PNAME
)
and not exists (
  select 1
  from PROGRAMER p3
  where p3.PROF2 = p.PROF2 and p3.PNAME <> p.PNAME
)
order by PROF;

--51. Who is the Above Programmer Referred in 50?

select distinct p1.PNAME, p1.PROF1 as PROF
from PROGRAMER p1
where p1.PROF1 not in (
  select p2.PROF1
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF1 = p2.PROF1
  union all
  select p2.PROF2
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF1 = p2.PROF2
  union all
  select p2.PROF1
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF2 = p2.PROF1
  union all
  select p2.PROF2
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF2 = p2.PROF2
) 
UNION 
select distinct p1.PNAME, p1.PROF2 AS PROF
FROM PROGRAMER p1
where p1.PROF2 not in (
  select p2.PROF1
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF2 = p2.PROF1
  union all
  select p2.PROF2
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF2 = p2.PROF2
  union all
  select p2.PROF1
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF1 = p2.PROF1
  union all
  select  p2.PROF2
  from PROGRAMER p2
  where p1.PNAME <> p2.PNAME and p1.PROF1 = p2.PROF2
)
order by PNAME, PROF;
-- 52. Who is the Youngest Programmer knowing DBASE?
SELECT TOP 1 PNAME
FROM PROGRAMER
WHERE (PROF1 = 'DBASE' OR PROF2 = 'DBASE')
ORDER BY DATEDIFF(year, DOB, GETDATE()) ASC;
select *from PROGRAMER
-- 53. Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE?
SELECT PNAME
FROM PROGRAMER
WHERE GENDER = 'F'
    AND SALARY > 3000
    AND PROF1 NOT IN ('C', 'CPP', 'ORACLE', 'DBASE')
    AND PROF2 NOT IN ('C', 'CPP', 'ORACLE', 'DBASE');

-- 54. Which Institute has the most number of Students?

SELECT TOP 1 INSTITUTE
FROM STUDIES
GROUP BY INSTITUTE
ORDER BY COUNT(*) DESC;

-- 55. What is the Costliest course?

SELECT TOP 1 COURSE AS Course_Name
FROM STUDIES
ORDER BY COURSE_FEE DESC;

-- 56. Which course has been done by the most of the Students?

SELECT TOP 1 COURSE, COUNT(*) AS STUDENT_COUNT
FROM STUDIES
GROUP BY COURSE
ORDER BY STUDENT_COUNT DESC;

-- 57. Which Institute conducts the costliest course.

SELECT TOP 1 INSTITUTE, COURSE, COURSE_FEE
FROM STUDIES
ORDER BY COURSE_FEE DESC;

-- 58. Display the name of the Institute and Course, which has below AVG course fee.

SELECT INSTITUTE, COURSE
FROM STUDIES
WHERE COURSE_FEE < (SELECT AVG(COURSE_FEE) FROM studies)
ORDER BY INSTITUTE, COURSE;

-- 59. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee.

SELECT COURSE
FROM STUDIES
WHERE COURSE_FEE BETWEEN (SELECT AVG(COURSE_FEE) - 1000 FROM studies) AND (SELECT AVG(COURSE_FEE) + 1000 FROM studies)
ORDER BY COURSE;

-- 60. Which package has the Highest Development cost?

SELECT TOP 1 TITLE, DEVELOPIN, DCOST
FROM software
ORDER BY DCOST DESC;

-- 61. Which course has below AVG number of Students?

WITH course_count AS (
SELECT course, COUNT(*) as Num
FROM STUDIES
GROUP BY course
),
average_students AS (
SELECT AVG(CAST(Num as float)) as avg_students
FROM course_count
)
SELECT c.course
FROM course_count c, average_students a
WHERE c.Num < a.avg_students;

-- 62. Which Package has the lowest selling cost?

SELECT TOP 1 s.TITLE
FROM SOFTWARE s
ORDER BY s.SCOST ASC

-- 63. Who Developed the Package that has sold the least number of copies?

SELECT PNAME
FROM SOFTWARE s
WHERE SOLD = (SELECT MIN(SOLD) FROM software)

-- 64. Which language has been used to develop the package, which has the highest sales amount?

SELECT TOP 1 s.DEVELOPIN
FROM SOFTWARE s
ORDER BY s.SCOST * s.SOLD DESC

-- 65. How many copies of the package that has the least difference between development and selling cost were sold.

SELECT TOP 1 SOLD
FROM SOFTWARE
ORDER BY ABS(SCOST - DCOST) ASC;

-- 66. Which is the costliest package developed in PASCAL.

SELECT TOP 1 TITLE, SCOST
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL'
ORDER BY SCOST DESC;

-- 67. Which language was used to develop the most number of Packages.

SELECT DEVELOPIN, COUNT(*) AS NUM_PACKAGES
FROM SOFTWARE
GROUP BY DEVELOPIN
ORDER BY NUM_PACKAGES DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- 68. Which programmer has developed the highest number of Packages?

SELECT TOP 1 PNAME
FROM SOFTWARE
GROUP BY PNAME
ORDER BY COUNT(*) DESC;

-- 69. Who is the Author of the Costliest Package?

SELECT TOP 1 PNAME, TITLE, SCOST
FROM software
ORDER BY SCOST DESC;

-- 70. Display the names of the packages, which have sold less than the AVG number of copies.

SELECT TITLE
FROM SOFTWARE
WHERE SOLD < (SELECT AVG(SOLD) FROM software)
ORDER BY SOLD ASC;

-- 71. Who are the authors of the Packages, which have recovered more than double the Development cost?

SELECT DISTINCT PNAME AS Package_Author
FROM SOFTWARE
WHERE (SCOST*SOLD) > (2 * DCOST);

-- 72. Display the programmer Name and the cheapest packages developed by them in each language.

WITH CTE AS (
    SELECT p.PNAME AS Programmer_Name, s.TITLE AS Package_Title, s.DEVELOPIN AS Package_Language, s.SCOST AS Package_Cost
        , ROW_NUMBER() OVER (PARTITION BY p.PNAME, s.DEVELOPIN ORDER BY s.SCOST) AS RowNum
    FROM PROGRAMER p
    JOIN software s ON p.PNAME = s.PNAME
)
SELECT CTE.Programmer_Name, CTE.Package_Title, CTE.Package_Language, CTE.Package_Cost
FROM CTE
WHERE CTE.RowNum = 1;

-- 73. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package.
WITH CTE AS (
    SELECT 
        p.PNAME AS Programmer,
        s.SCOST,
        s.TITLE,
        s.DEVELOPIN,
        MAX(s.SCOST) OVER (PARTITION BY p.PNAME) AS Highest_Software_Cost,
        MIN(s.SCOST) OVER (PARTITION BY p.PNAME) AS Lowest_Software_Cost
    FROM 
        PROGRAMER p
        JOIN software s ON p.PNAME = s.PNAME
)
SELECT 
    Programmer,
   	MAX(CASE WHEN SCOST = Highest_Software_Cost THEN TITLE END) AS Highest_Cost_Title,
	MAX(CASE WHEN SCOST = Highest_Software_Cost THEN DEVELOPIN END) AS Highest_Cost_Developin,
	Highest_Software_Cost,
    MIN(CASE WHEN SCOST = Lowest_Software_Cost THEN TITLE END) AS Lowest_Cost_Title,
    MIN(CASE WHEN SCOST = Lowest_Software_Cost THEN DEVELOPIN END) AS Lowest_Cost_Developin,
	Lowest_Software_Cost
FROM 
    CTE
GROUP BY 
    Programmer,
    Highest_Software_Cost,
    Lowest_Software_Cost;

-- 74. Who is the youngest male Programmer born in 1965?

SELECT TOP 1 p.PNAME AS Youngest_Male_Programmer_Born_In_1965
FROM programer p
WHERE p.GENDER = 'M' AND p.DOB >= '1965-01-01' AND p.DOB <= '1965-12-31'
ORDER BY p.DOB ASC;

-- 75. Who is the oldest Female Programmer who joined in 1992?

SELECT TOP 1 p.PNAME AS Oldest_Female_Programmer_Joined_In_1992
FROM programmer p
WHERE p.GENDER = 'F' AND p.DOJ >= '1992-01-01' AND p.DOJ <= '1992-12-31'
ORDER BY p.DOB ASC;

-- 76. In which year was the most number of Programmers born?

SELECT YEAR(DOB) AS BirthYear, COUNT(*) AS NumProgrammers
FROM programer
GROUP BY YEAR(DOB)
ORDER BY NumProgrammers DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- 77. In which month did the most number of programmers join?

SELECT MONTH(DOJ) AS JoinMonth, COUNT(*) AS NumProgrammers
FROM programer
GROUP BY MONTH(DOJ)
ORDER BY NumProgrammers DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- 78. In which language are most of the programmer’s proficient?

WITH combined_proficiencies AS (
SELECT PROF1 AS Language 
FROM programer UNION ALL
SELECT PROF2 FROM programer), 
language_proficiency AS (
SELECT Language, COUNT(*) AS Num_Proficient 
FROM combined_proficiencies GROUP BY Language), max_proficient AS (SELECT MAX(Num_Proficient) AS MaxValue
FROM language_proficiency)
SELECT lp.Language, lp.Num_Proficient
FROM language_proficiency lp
JOIN max_proficient mp ON lp.Num_Proficient = mp.MaxValue;

-- 79. Who are the male programmers earning below the AVG salary of Female Programmers?

SELECT PNAME, SALARY
FROM programer
WHERE GENDER = 'M' AND SALARY < (SELECT AVG(SALARY) FROM programer WHERE GENDER = 'F');

-- 80. Who are the Female Programmers earning more than the Highest Paid Male Programmers?

WITH HighestPaidMale AS (
  SELECT MAX(SALARY) AS MaxMaleSalary
  FROM programer
  WHERE GENDER = 'M'
)
SELECT PNAME, SALARY
FROM programer
WHERE GENDER = 'F' AND SALARY > (SELECT MaxMaleSalary FROM HighestPaidMale);

-- 81. Which language has been stated as the proficiency by most of the Programmers?

WITH combined_proficiencies AS (
SELECT PROF1 AS Language 
FROM programer UNION ALL
SELECT PROF2 FROM programer), 
language_proficiency AS (
SELECT Language, COUNT(*) AS Num_Proficient 
FROM combined_proficiencies GROUP BY Language), max_proficient AS (SELECT MAX(Num_Proficient) AS MaxValue
FROM language_proficiency)
SELECT lp.Language, lp.Num_Proficient
FROM language_proficiency lp
JOIN max_proficient mp ON lp.Num_Proficient = mp.MaxValue;

-- 82. Display the details of those who are drawing the same salary.

SELECT *
FROM programer
WHERE SALARY IN 
( SELECT SALARY
  FROM programer
  GROUP BY SALARY
  HAVING COUNT(*) > 1 )
ORDER BY SALARY;

-- 83. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-.

SELECT s.*, p.GENDER, p.SALARY, p.DOB, p.DOJ, p.PROF1, p.PROF2
FROM software s
JOIN programer p ON s.PNAME = p.PNAME
WHERE p.GENDER = 'M' AND p.SALARY > 3000;

-- 84. Display the details of the packages developed in Pascal by the Female Programmers.

SELECT s.*, p.GENDER, p.SALARY, p.DOB, p.DOJ, p.PROF1, p.PROF2
FROM software s
JOIN programer p ON s.PNAME = p.PNAME
WHERE p.GENDER = 'F' AND s.DEVELOPIN = 'PASCAL';

-- 85. Display the details of the Programmers who joined before 1990.

SELECT *
FROM programer
WHERE YEAR(DOJ) < 1990;

-- 86. Display the details of the Software Developed in C By female programmers of Pragathi.

SELECT software.*
FROM software, studies, programer
WHERE software.PNAME = programer.PNAME AND studies.PNAME = programer.PNAME
AND software.DEVELOPIN = 'C' AND programer.GENDER = 'F';

-- 87. Display the number of packages, No. of Copies Sold and sales value of each programmer institute wise.

SELECT INSTITUTE, COUNT(software.TITLE) AS NumPACKAGES, SUM(SOLD) AS NumCOPIES, SUM(SCOST * SOLD) AS SALES_VALUE
FROM software, studies
WHERE software.PNAME = studies.PNAME
GROUP BY INSTITUTE;

-- 88. Display the details of the software developed in DBASE by Male Programmers, who belong to the institute in which most number of Programmers studied.

SELECT DISTINCT s.PNAME, s.TITLE, s.DEVELOPIN, s.SCOST, s.DCOST, s.SOLD
FROM software s
JOIN studies st on s.PNAME = st.PNAME
JOIN programer p ON s.PNAME = p.PNAME
WHERE s.DEVELOPIN = 'DBASE'
AND p.GENDER = 'M'
AND st.INSTITUTE = (
    SELECT TOP 1 INSTITUTE
    FROM studies
    GROUP BY INSTITUTE
    ORDER BY COUNT(*) DESC
);

-- 89. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975.

SELECT s.PNAME, s.TITLE, s.DEVELOPIN, s.SCOST, s.DCOST, s.SOLD
FROM software s
INNER JOIN programer p ON s.PNAME = p.PNAME
WHERE (p.GENDER = 'M' AND YEAR(DOB) < 1965) OR (p.GENDER = 'F' AND YEAR(DOB) > 1975)

-- 90. Display the details of the software that has developed in the language which is neither the first nor the second proficiency of the programmers.

SELECT s.*
FROM software s
INNER JOIN programer p ON s.PNAME = p.PNAME
WHERE s.DEVELOPIN NOT IN (p.PROF1, p.PROF2);

-- 91. Display the details of the software developed by the male students of Sabhari.

SELECT s.*
FROM software s
INNER JOIN studies st ON s.PNAME = st.PNAME
WHERE st.INSTITUTE = 'SABHARI' AND EXISTS (
    SELECT 1 FROM programer p
    WHERE p.PNAME = s.PNAME AND p.GENDER = 'M'
);

-- 92. Display the names of the programmers who have not developed any packages.

SELECT p.PNAME
FROM programer p
LEFT JOIN software s ON s.PNAME = p.PNAME
WHERE s.PNAME IS NULL;

-- 93. What is the total cost of the Software developed by the programmers of Apple?

SELECT S.PNAME, S.INSTITUTE, SUM(SO.SCOST + SO.DCOST) AS TOTAL_COST
FROM STUDIES S, SOFTWARE SO
WHERE S.INSTITUTE = 'APPLE' AND S.PNAME = SO.PNAME
GROUP BY S.PNAME, S.INSTITUTE;

-- 94. Who are the programmers who joined on the same day?

WITH tab AS (
  SELECT p1.PNAME AS PNAME1, p2.PNAME AS PNAME2, p1.DOJ
  FROM programer p1
  INNER JOIN programer p2 ON p1.DOJ = p2.DOJ
  WHERE p1.PNAME < p2.PNAME
)
SELECT PNAME1 AS PNAME, DOJ
FROM tab 
UNION
SELECT PNAME2 AS PNAME, DOJ
FROM tab;

-- 95. Who are the programmers who have the same Prof2?

SELECT p1.PNAME AS PNAME_1, p2.PNAME AS PNAME_2, p2.PROF2
FROM programer p1
INNER JOIN programer p2 ON p1.PROF2 = p2.PROF2 AND p1.PNAME <> p2.PNAME;

-- 96. Display the total sales value of the software, institute wise.

SELECT t.INSTITUTE, SUM(s.SCOST * s.SOLD) AS total_sales_value
FROM software s
JOIN studies t ON s.PNAME = t.PNAME
GROUP BY t.INSTITUTE
ORDER BY t.INSTITUTE;

-- 97. In which institute does the person who developed the costliest package studied?

SELECT t.INSTITUTE
FROM software s
JOIN studies t ON s.PNAME = t.PNAME
WHERE s.SCOST = (SELECT MAX(SCOST) FROM software)
GROUP BY t.INSTITUTE;

-- 98. Which language listed in prof1, prof2 has not been used to develop any package.

SELECT DISTINCT p.PROF1 AS PROF
FROM programer p
WHERE p.PROF1 NOT IN (SELECT DEVELOPIN FROM software)
UNION
SELECT DISTINCT p.PROF2
FROM programer p
WHERE p.PROF2 NOT IN (SELECT DEVELOPIN FROM software);

-- 99. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo.

SELECT t.COURSE, p.SALARY
FROM programer p
JOIN software s ON p.PNAME = s.PNAME
JOIN studies t ON p.PNAME = t.PNAME
WHERE s.SOLD = (SELECT MAX(SOLD) FROM software);

-- 100. What is the AVG salary for those whose software sales is more than 50,000/-.

SELECT AVG(p.SALARY) AS AVG_SALARY
FROM programer p
JOIN software s ON p.PNAME = s.PNAME
WHERE s.SCOST * s.SOLD > 50000;

-- 101. How many packages were developed by students, who studied in institutes that charge the lowest course fee?

WITH MinCourseFee AS (
SELECT DISTINCT S.PNAME, S.INSTITUTE, S.COURSE_FEE, SW.TITLE, SW.DEVELOPIN
FROM STUDIES S
INNER JOIN SOFTWARE SW ON S.PNAME = SW.PNAME
WHERE S.COURSE_FEE = (SELECT MIN(COURSE_FEE) FROM STUDIES)
)
SELECT COUNT(TITLE) AS Packages_developed
FROM MinCourseFee;

-- 102. How many packages were developed by the person who developed the cheapest package, where did HE/SHE study?

WITH cheapest_package AS (
  SELECT TOP 1 PNAME
  FROM software
  ORDER BY SCOST ASC
)
SELECT COUNT(*) AS num_packages, st.INSTITUTE
FROM software s
JOIN studies st ON s.PNAME = st.PNAME
JOIN cheapest_package cp ON s.PNAME = cp.PNAME
GROUP BY st.INSTITUTE;

-- 103. How many packages were developed by the female programmers earning more than the highest paid male programmers?

WITH highest_male_salary AS (
  SELECT MAX(SALARY) AS max_salary
  FROM programer
  WHERE GENDER = 'M'
),
female_programmers AS (
  SELECT PNAME
  FROM programer
  WHERE GENDER = 'F' AND SALARY > (SELECT max_salary FROM highest_male_salary)
)
SELECT COUNT(*) AS num_packages
FROM software
WHERE PNAME IN (SELECT PNAME FROM female_programmers);

-- 104. How many packages are developed by the most experienced programmer from BDPS.

WITH ProgrammerExperience AS (
SELECT P.PNAME, P.DOJ,
DATEDIFF(year, P.DOJ, GETDATE()) as Years_of_Experience
FROM Programer P
INNER JOIN STUDIES S ON P.PNAME = S.PNAME
WHERE S.INSTITUTE = 'BDPS'
),
MostExperiencedProgrammer AS (
SELECT TOP 1 PNAME
FROM ProgrammerExperience
ORDER BY Years_of_Experience DESC
)
SELECT MEP.PNAME, COUNT(S.SCOST) as Software_Count
FROM MostExperiencedProgrammer MEP
INNER JOIN SOFTWARE S ON MEP.PNAME = S.PNAME
GROUP BY MEP.PNAME

-- 105. List the programmers (form the software table) and the institutes they studied.

SELECT DISTINCT s.PNAME AS Programmer, st.INSTITUTE AS Institute
FROM software s
JOIN studies st ON s.PNAME = st.PNAME;

-- 106. List each PROF with the number of Programmers having that PROF and the number of the packages in that PROF.

SELECT sub_query.PROF, 
       SUM(sub_query.NUM_PROGRAMMERS) AS NUM_PROGRAMMERS, 
       SUM(sub_query.NUM_PACKAGES) AS NUM_PACKAGES
FROM (
    SELECT p.PROF1 AS PROF, 
           COUNT(DISTINCT p.PNAME) AS NUM_PROGRAMMERS, 
           COUNT(s.TITLE) AS NUM_PACKAGES
    FROM programer p
    LEFT JOIN software s ON p.PNAME = s.PNAME AND p.PROF1 = s.DEVELOPIN
    GROUP BY p.PROF1
    UNION ALL
    SELECT p.PROF2 AS PROF, 
           COUNT(DISTINCT p.PNAME) AS NUM_PROGRAMMERS, 
           COUNT(s.TITLE) AS NUM_PACKAGES
    FROM programer p
    LEFT JOIN software s ON p.PNAME = s.PNAME AND p.PROF2 = s.DEVELOPIN
    WHERE p.PROF2 IS NOT NULL
    GROUP BY p.PROF2
) AS sub_query
GROUP BY sub_query.PROF
ORDER BY sub_query.PROF;

-- 107. List the programmer names (from the programmer table) and No. Of Packages each has developed.

SELECT p.PNAME AS Programmer, COUNT(*) AS NumPackages
FROM software s
JOIN programer p ON s.PNAME = p.PNAME
GROUP BY p.PNAME;