--create database
create database A6;
use A6;


--1.	Create a view named ‘customer_san_jose’ which comprises of only those customers who are from san jose

 create table customer(customer_id int,first_name varchar(20),last_name varchar(20),email varchar(30),
 address varchar(50),city varchar(20),state varchar(20),zip int);
 truncate table customer
insert into customer values(1,'Vivek','Patel','vp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(2,'Isha','Tailor','it123@gmail.com','Gotri','Vadodara','Gujrat',390013),
(3,'Gaurang','Suthar','gs123@gmail.com','Aksharchawk','San Jose','Gujrat',390012),
(4,'Jagdish','Patel','jp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(5,'Paresh','Patel','pp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(6,'Popat','Jordan','pj123@gmail.com','Atladara','Vadodara','Gujrat',390012);

select *from customer;

create view customer_san_jose
as
select *from customer where city ='San Jose';

select *from customer_san_jose

--2.	Inside a transaction, update the first name of the customer to Francis, where the last name is Jordan

begin transaction 
   update customer set first_name = 'Francis' where last_name ='Jordan'
   select *from customer

--a.	Rollback the transaction

begin transaction 
   update customer set first_name = 'Francis' where last_name ='Jordan'
   rollback transaction
   select *from customer

--b.	Set the first name of customer to Alex, where the last name is Jordan

begin transaction 
   update customer set first_name = 'Francis' where last_name ='Jordan'

   select *from customer

--3.	Inside a try catch block, divide 100 with 0, print the default error message
begin try
 begin transaction 
   declare @result float;
   set @result=100/0;
   commit transaction
   print 'transaction commited'
   end try
begin catch
      print'default error'
end catch