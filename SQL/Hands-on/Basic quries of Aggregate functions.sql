create database Supermart;
use Supermart

select*from Supermart_sales

--1
select max(Sales) as max_sale , min(Sales) as min_sale from Supermart_sales;

--2
select City,max(Sales) as Max_sales,min(sales) as min_sales from Supermart_sales
group by city; 

--3 
select City,Region,max(Sales) as Max_sales,min(sales) as min_sales from Supermart_sales
group by city,Region;

--4
select City,sum(Sales) as sales from Supermart_sales
group by city;

select City,Region ,sum(Sales) as sales from Supermart_sales
group by city,Region;

select sum(Sales) as sale from Supermart_sales

--5

select District='Chennai',avg(Sales) as chennai_sales from Supermart_sales

--6

select District='Chennai',avg(Sales) as chennai_sales from Supermart_sales where Sales > 800;

--7

select count(*) from Supermart_sales;

-- 8 
 
 select  * into Supermart_upd from (select *,month(Order_Date) as Month,  

 year(Order_Date) as Year from Supermart_sales)cr;
 select count(*) as no_of_record from Supermart_upd where Year=2016 and Month=11;

 --9
 select count(*) as no_of_record from Supermart_sales where Year(Order_Date) in(2016,2015);

 --10 
 Select substring(Customer_Name,1,3)  as customer_name from  Supermart_sales