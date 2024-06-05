-- let's create database first 
create database A3;
use  A3;


--1.	Create an ‘Orders’ table which comprises of these columns – ‘order_id’, ‘order_date’, ‘amount’, ‘customer_id’

create table Orders(order_id int,order_date date ,amount int,customer_id int);

insert into Orders values(111,'2022-10-12',5000,3),
(222,'2022-06-04',4000,2),(555,'2022-05-02',6000,1),(444,'2022-07-12',7000,5),(333,'2022-10-14',5500,4);

select *from Orders;

 create table customer(customer_id int,first_name varchar(20),last_name varchar(20),email varchar(30),
 address varchar(50),city varchar(20),state varchar(20),zip int);

insert into customer values(1,'Vivek','Patel','vp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(2,'Isha','Tailor','it123@gmail.com','Gotri','Vadodara','Gujrat',390013),
(3,'Gaurang','Suthar','gs123@gmail.com','Aksharchawk','San Jose','Gujrat',390012),
(4,'Jagdish','Patel','jp123@gmail.com','Atladara','Vadodara','Gujrat',390012),
(5,'Paresh','Patel','pp123@gmail.com','Atladara','Vadodara','Gujrat',390012);

select *from customer;

--2.	Make an inner join on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column 

select *from customer as a inner join Orders as b on a.customer_id=b.customer_id;

--3.	Make left and right joins on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column

select *from customer as a left join Orders as b on a.customer_id=b.customer_id;

select *from customer as a right join Orders as b on a.customer_id=b.customer_id;

--4.	Update the ‘Orders’ table, set the amount to be 100 where ‘customer_id’ is 33

update Orders set amount=100  where customer_id =3;