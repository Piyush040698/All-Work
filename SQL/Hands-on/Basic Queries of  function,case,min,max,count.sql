--create database 
create database A4;
use A4

--1.	Use the inbuilt functions and find the minimum, maximum and average amount from the orders table

create table Orders(order_id int,order_date date ,amount int,customer_id int);

insert into Orders values(111,'2022-10-12',5000,3),
(222,'2022-06-04',4000,2),(555,'2022-05-02',6000,1),(444,'2022-07-12',7000,5),(333,'2022-10-14',5500,4);

select *from Orders;

select min(amount) as Minimum,max(amount) as Maximum,avg(amount) as Average from Orders;

--2.	Create a user-defined function, which will multiply the given number with 10

create function multiply(@num int)
returns int
as begin
return(@num*10)
end

select dbo.multiply(2) as Result;

--3.	Use the case statement to check if 100 is less than 200, greater than 200 or equal to 2oo and print the corresponding value

select case
when 100<200 then 'Smaller'
when 100>200 then 'Greater'
else 'Equal'
end
