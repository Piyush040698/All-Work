---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 1
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Task 1
-- 
-- Connect to AdventureWorksLT Azure SQL Database from Power BI.
--
-- Copy and paste the following query into the Query textbox.
---------------------------------------------------------------------

SELECT	a.CustomerID, a.CompanyName, a.NameStyle, a.Title, a.FirstName, a.LastName, a.SalesPerson,
		c.AddressLine1, c.AddressLine2, c.City, c.StateProvince, c.CountryRegion, c.PostalCode 
FROM	SalesLT.Customer AS a
INNER	JOIN SalesLT.CustomerAddress AS b ON a.CustomerID = b.CustomerID
INNER	JOIN SalesLT.[Address] AS c ON b.AddressID = c.AddressID
WHERE	b.AddressType = 'Main Office'



---------------------------------------------------------------------
-- Task 2
-- 
-- Connect to AdventureWorksLT Azure SQL Database from Power BI.
--
-- Copy and paste the following query into the Query textbox.
---------------------------------------------------------------------

SELECT	b.CustomerID, a.SalesOrderID, a.SalesOrderDetailID, b.RevisionNumber, b.SalesOrderNumber,
		e.Name AS MainCategory, d.Name AS SubCategory, c.ProductID, c.Name AS Product, 
		a.OrderQty, c.ListPrice, 
		b.OrderDate, b.DueDate, b.ShipDate, b.SubTotal 
FROM	SalesLT.SalesOrderDetail AS a
INNER	JOIN SalesLT.SalesOrderHeader AS b ON a.SalesOrderID = b.SalesOrderID 
INNER	JOIN SalesLT.Product AS c ON a.ProductID = c.ProductID 
INNER	JOIN SalesLT.ProductCategory AS d ON c.ProductCategoryID = d.ProductCategoryID
INNER	JOIN SalesLT.ProductCategory AS e ON d.ParentProductCategoryID = e.ProductCategoryID