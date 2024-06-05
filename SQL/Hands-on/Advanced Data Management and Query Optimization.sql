-- CASE STUDY 3

-- CREATE DATABASE

CREATE DATABASE CASESTUDY3;
USE CASESTUDY3

-- IMPORT THE DATASETS

SELECT *FROM CONTINENT
SELECT *FROM CUSTOMERS
SELECT *FROM TRANSACTIO

-- 1. Display the count of customers in each region who have done the transaction in the year 2020.
SELECT c.region_id, COUNT(c.customer_id) as customer_count
FROM Customers c
JOIN Transactio t ON c.customer_id = t.customer_id
WHERE YEAR(CONVERT(date, t.txn_date, 103)) = 2020 
GROUP BY c.region_id;
-- Use CONVERT function with format 103 (dd/mm/yyyy)

-- 2. Display the maximum and minimum transaction amount of each transaction type.
SELECT txn_type, MAX(txn_amount) as max_amount, MIN(txn_amount) as min_amount
FROM Transactio
GROUP BY txn_type;

-- 3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.
SELECT c.customer_id, r.region_name, t.txn_amount
FROM Customers c
JOIN Transactio t ON c.customer_id = t.customer_id
JOIN Continent r ON c.region_id = r.region_id
WHERE t.txn_type = 'deposit' AND t.txn_amount > 2000;

-- 4. Find duplicate records in the Customer table.

SELECT customer_id, region_id, start_date, end_date, COUNT(*)
FROM Customers
GROUP BY customer_id, region_id, start_date, end_date
HAVING COUNT(*) > 1;

-- 5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.
SELECT c.customer_id, r.region_name, t.txn_type, t.txn_amount
FROM Customers c
JOIN Transactio t ON c.customer_id = t.customer_id
JOIN Continent r ON c.region_id = r.region_id
WHERE t.txn_type = 'deposit' AND t.txn_amount = (SELECT MIN(txn_amount) FROM Transactio WHERE txn_type = 'deposit');

-- 6. Create a stored procedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020.
CREATE PROCEDURE GetTransactionDetailsAfterJune2020
AS
BEGIN
    SELECT *
    FROM Transactio
    WHERE txn_date > '2020-06-30'
END;

-- 7. Create a stored procedure to insert a record in the Continent table.
CREATE PROCEDURE InsertContinentRecord @region_id INT, @region_name NVARCHAR(255)
AS
BEGIN
    INSERT INTO Continent(region_id, region_name)
    VALUES (@region_id, @region_name)
END;

-- 8. Create a stored procedure to display the details of transactions that happened on a specific day.
CREATE PROCEDURE GetTransactionsOnSpecificDay @input_date DATE
AS
BEGIN
    SELECT *
    FROM Transactio
    WHERE CAST(txn_date AS DATE) = @input_date
END;

-- 9. Create a user defined function to add 10% of the transaction amount in a table.
CREATE FUNCTION AddTenPercentToAmount (@amount FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN @amount * 1.1
END;

-- 10. Create a user defined function to find the total transaction amount for a given transaction type.
CREATE FUNCTION GetTotalTransactionAmountByType (@txn_type NVARCHAR(255))
RETURNS FLOAT
AS
BEGIN
    DECLARE @total_amount FLOAT;
    SELECT @total_amount = SUM(txn_amount)
    FROM Transactio
    WHERE txn_type = @txn_type;

    RETURN @total_amount
END;

-- 11. Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table.
CREATE FUNCTION dbo.CustomerTransactions()
RETURNS TABLE
AS
RETURN
    SELECT
        c.customer_id,
        c.region_id,
        t.txn_date,
        t.txn_type,
        t.txn_amount
    FROM Customers c
    JOIN "Transaction" t ON c.customer_id = t.customer_id;

-- 12. Create a TRY...CATCH block to print a region id and region name in a single column.
BEGIN TRY
    SELECT CONCAT(region_id, ' - ', region_name) AS region_info
    FROM Continent;
END TRY
BEGIN CATCH
    PRINT 'An error occurred while fetching region information.';
END CATCH;

-- 13. Create a TRY...CATCH block to insert a value in the Continent table.
BEGIN TRY
    INSERT INTO Continent (region_id, region_name)
    VALUES (999, 'New Region');
END TRY
BEGIN CATCH
    PRINT 'An error occurred while inserting into Continent table.';
END CATCH;

-- 14. Create a trigger to prevent deleting a table in a database.
CREATE TRIGGER PreventCustomersDelete
ON Customers
FOR DELETE
AS
BEGIN
    ROLLBACK;
    RAISERROR('Cannot delete records from Customers table.', 16, 1);
END;

-- 15. Create a trigger to audit the data in a table.
CREATE TRIGGER AuditT
ON Transactio
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO Transaction_Audit -- Insert audit columns here
    SELECT * FROM inserted; -- For INSERT and UPDATE operations
    UNION ALL
    SELECT * FROM deleted; -- For DELETE operations
END;

-- 16. Create a trigger to prevent login of the same user id in multiple pages.
-- Create Users Table
CREATE TABLE Users
(
    user_id INT PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    password NVARCHAR(50) NOT NULL
);

-- Create LoginSessions Table
CREATE TABLE LoginSessions
(
    session_id UNIQUEIDENTIFIER PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    login_time DATETIME DEFAULT GETDATE(),
    logout_time DATETIME NULL,
    logged_in BIT DEFAULT 1
);

-- Now, we'll create the trigger that prevents multiple logins of the same user using the existed table schemas.

GO -- Add this line to separate it into two batches

-- Create the trigger to prevent multiple active logins for the same user
CREATE TRIGGER trg_PreventMultipleLogins
ON LoginSessions
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT * 
        FROM LoginSessions ls
        INNER JOIN inserted ins ON ls.user_id = ins.user_id
        WHERE ls.user_id = ins.user_id AND ls.logged_in = 1
        GROUP BY ls.user_id
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('A user is already logged in. Multiple logins are not allowed.', 16, 1)
        ROLLBACK TRANSACTION;
    END
END

-- 17. Display top n customers on the basis of transaction type.
SELECT TOP 5 *
FROM Transactio
WHERE txn_type = 'purchase'
ORDER BY txn_amount DESC;

-- 18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.
SELECT customer_id,
       SUM(CASE WHEN txn_type = 'purchase' THEN txn_amount ELSE 0 END) AS total_purchase,
       SUM(CASE WHEN txn_type = 'withdrawal' THEN txn_amount ELSE 0 END) AS total_withdrawal,
       SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount ELSE 0 END) AS total_deposit
FROM Transactio
GROUP BY customer_id;