--create database 
create database A5;
use A5

--1.	Arrange the ‘Orders’ dataset in decreasing order of amount

create table Orders(order_id int,order_date date ,amount int,customer_id int);

insert into Orders values(111,'2022-10-12',5000,3),
(222,'2022-06-04',4000,2),(555,'2022-05-02',6000,1),(444,'2022-07-12',7000,5),(333,'2022-10-14',5500,4);

select *from Orders;

select *from Orders
order by amount desc

--2.	Create a table with name ‘Employee_details1’ and comprising of these columns – ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. Create another table with name ‘Employee_details2’, which comprises of same columns as first table.

create table Employee_details1(Emp_id int,Emp_name varchar(20),Emp_salary int);

insert into Employee_details1 values(1,'Vivek',100000),(2,'Isha',115000),(3,'Divyesh',95000);

create table Employee_details2(Emp_id int,Emp_name varchar(20),Emp_salary int);
drop table Employee_details2
insert into Employee_details2 values(4,'Jagdish',55000),(5,'Gaurang',80000),(6,'Aesha',90000);

select *from Employee_details1;

select *from Employee_details2;

--3.	Apply the union operator on these two tables

select *from Employee_details1 
union 
select *from Employee_details2;

--4.	Apply the intersect operator on these two tables

select *from Employee_details1
intersect
select *from Employee_details2;


--5.	Apply the except operator on these two tables

select *from Employee_details1
except
select *from Employee_details2;