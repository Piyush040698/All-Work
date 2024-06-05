-- PROJECT QUERYING LARGE RELATIONAL DATA
-- 1. Get all the details from the person table including email ID, phone number, and phone number type:

SELECT p.FirstName, p.LastName, e.EmailAddress, ph.PhoneNumber, pt.Name AS PhoneNumberType
FROM Person.Person AS p
JOIN Person.EmailAddress AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN Person.PersonPhone AS ph ON p.BusinessEntityID = ph.BusinessEntityID
JOIN Person.PhoneNumberType AS pt ON ph.PhoneNumberTypeID = pt.PhoneNumberTypeID;

-- 2. Get the details of the sales header order made in May 2011:
SELECT *
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 5;

-- 3. Get the details of the sales details order made in the month of May 2011:

SELECT sd.*
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd ON sh.SalesOrderID = sd.SalesOrderID
WHERE YEAR(sh.OrderDate) = 2011 AND MONTH(sh.OrderDate) = 5;

-- 4. Get the total sales made in May 2011:

SELECT SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 5;

-- 5. Get the total sales made in the year 2011 by month order by increasing sales:
SELECT MONTH(OrderDate) AS Month, SUM(TotalDue) AS Sales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011
GROUP BY MONTH(OrderDate)
ORDER BY Sales;

-- 6. Get the total sales made to the customer with FirstName='Gustavo' and LastName='Achong':
SELECT SUM(sh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.Customer AS c ON sh.CustomerID = c.CustomerID
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE p.FirstName = 'Gustavo' AND p.LastName = 'Achong';
