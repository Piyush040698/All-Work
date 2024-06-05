-- CRATE DATABASE
CREATE DATABASE PROJECT2;
USE PROJECT2

-- LET'S CREATE TABLES 
CREATE TABLE ROLE( ID INT PRIMARY KEY,role_name varchar(100)); 
CREATE TABLE user_has_role(ID INT PRIMARY KEY,role_start_time datetime2,role_end_time datetime2 not null,user_account_id int foreign key references user_account(ID),role_id int foreign key references 
ROLE(ID));
create table user_account(ID int primary key,user_name varchar(100),email varchar(254),password varchar(200),password_salt varchar(50) null,password_hash_algorithm varchar(40));
create table status(ID int primary key,status_name varchar(100),is_user_working  bit);
create table user_has_status(ID int primary key,status_start_time datetime2,status_end_time datetime2 not null,user_account_id int foreign key references user_account(ID),status_id int foreign key references 
status(ID));

-- 1. Insert data into each of the above tables. With at least two rows in each of the table, make sure, that you have created respective foreign keys.
insert into ROLE values(1,'Manager'),(2,'User');


insert into user_account values(1, 'Isha', 'is@etc.com', 'ipass28', 'salt11', 'SHA522'),
       (2, 'Yogi', 'yo@etc.com', 'ypass11', 'salt22', 'SHA511');

insert into status values(1, 'Inactive', 0), (2, 'Active', 1);

insert into user_has_role values(1, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, 1, 1), (2, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, 2, 2);

insert into user_has_status values(1, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, 1, 1), (2, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, 2, 2);

-- 2. Delete all the data from each of the tables.
DELETE FROM user_has_status
DELETE FROM user_has_role
DELETE FROM status
DELETE FROM user_account
DELETE FROM role