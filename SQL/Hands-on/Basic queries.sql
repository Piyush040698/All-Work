--let's create database first
create database A2;
use A2

--1.	Create a customer table which comprises of these columns – ‘customer_id’, ‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
 create table customer(customer_id int,first_name varchar(20),last_name varchar(20),email varchar(30),
 address varchar(50),city varchar(20),state varchar(20),zip int);

--2.	Insert 5 new records into the table
insert into customer values(11,'Vivek','Patel','vp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(22,'Isha','Tailor','it123@gmail.com','Gotri','Vadodara','Gujrat',390013),
(33,'Gaurang','Suthar','gs123@gmail.com','Aksharchawk','San Jose','Gujrat',390012),
(44,'Jagdish','Patel','jp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(55,'Paresh','Patel','pp123@gmail.com','Atladara','Vadodara','Gujrat',390012);

select *from customer

--3.	Select only the ‘first_name’ & ‘last_name’ columns from the customer table

select first_name,last_name from customer;

--4.	Select those records where ‘first_name’ starts with “G” and city is ‘San Jose’
select *from customer where first_name like 'G%' and city = 'San Jose';