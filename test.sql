-- SQL Wildcard Characters
-- A wildcard character is used to substitute one or more characters in a string.
-- Wildcard characters are used with the LIKE operator. The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

-- Wildcard Characters
-- Symbol	Description
-- %	    Represents zero or more characters
-- _	    Represents a single character
-- []	    Represents any single character within the brackets *
-- ^	    Represents any character not in the brackets *
-- -	    Represents any single character within the specified range *
-- {}	    Represents any escaped character **

-- Return all customers that ends with the pattern 'es':
SELECT * FROM Customers
WHERE CustomerName LIKE '%es';

-- Return all customers that contains the pattern 'mer':
SELECT * FROM Customers
WHERE CustomerName LIKE '%mer%';

-- Return all customers with a City starting with any character, followed by "ondon":
SELECT * FROM Customers
WHERE City LIKE '_ondon';

-- Return all customers with a City starting with "L", followed by any 3 characters, ending with "on":
SELECT * FROM Customers
WHERE City LIKE 'L___on';

-- Return all customers starting with either "b", "s", or "p":
SELECT * FROM Customers
WHERE CustomerName LIKE '[bsp]%';

-- Return all customers starting with "a", "b", "c", "d", "e" or "f":
SELECT * FROM Customers
WHERE CustomerName LIKE '[a-f]%';

-- Return all customers that starts with "a" and are at least 3 characters in length:
SELECT * FROM Customers
WHERE CustomerName LIKE 'a__%';

-- Return all customers that have "r" in the second position:
SELECT * FROM Customers
WHERE CustomerName LIKE '_r%';

-- SQL IN Operator
-- The IN operator allows you to specify multiple values in a WHERE clause.
-- The IN operator is a shorthand for multiple OR conditions.

-- Syntax
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);

-- Return all customers from 'Germany', 'France', or 'UK'
SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');

-- SQL BETWEEN Operator
-- The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
-- The BETWEEN operator is inclusive: begin and end values are included. 

-- Selects all products with a price between 10 and 20:
SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20;

SELECT * FROM Products
WHERE Price NOT BETWEEN 10 AND 20;

-- The following SQL statement selects all products with a ProductName alphabetically between Carnarvon Tigers and Mozzarella di Giovanni:
SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

-- The following SQL statement selects all orders with an OrderDate between '01-July-1996' and '31-July-1996':
SELECT * FROM Orders
WHERE OrderDate BETWEEN #07/01/1996# AND #07/31/1996#;

SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

-- SQL Aliases
-- SQL aliases are used to give a table, or a column in a table, a temporary name.
-- Aliases are often used to make column names more readable.
-- An alias only exists for the duration of that query.
-- An alias is created with the AS keyword.

SELECT CustomerID AS ID
FROM Customers;

-- AS is Optional
-- Actually, in most database languages, you can skip the AS keyword and get the same result:
SELECT CustomerID ID
FROM Customers;

-- Syntax
-- When alias is used on column:
SELECT column_name AS alias_name
FROM table_name;

-- When alias is used on table:
SELECT column_name(s)
FROM table_name AS alias_name;

SELECT CustomerID AS ID, CustomerName AS Customer
FROM Customers;

-- Using "double quotes" for aliases with space characters:
SELECT ProductName AS "My Great Products"
FROM Products;

-- Concatenate Columns
-- The following SQL statement creates an alias named "Address" that combine four columns (Address, PostalCode, City and Country):

SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;

-- MySQL Example
SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS Address
FROM Customers;

-- Refer to the Customers table as Persons instead:
SELECT * FROM Customers AS Persons;

SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;

-- SQL JOIN
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

-- Different Types of SQL JOINs
-- (INNER) JOIN: Returns records that have matching values in both tables
-- SELECT column_name(s)
-- FROM table1
-- INNER JOIN table2
-- ON table1.column_name = table2.column_name;
-- JOIN and INNER JOIN will return the same result.
-- INNER is the default join type for JOIN, so when you write JOIN the parser actually writes INNER JOIN

SELECT ProductID, ProductName, CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- JOIN Three Tables
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);

-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
-- Note: The LEFT JOIN keyword returns all records from the left table(1), even if there are no matches in the right table(2).
-- LEFT JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- LEFT JOIN table2
-- ON table1.column_name = table2.column_name;

-- The following SQL statement will select all customers, and any orders they might have:
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
-- Note: The RIGHT JOIN keyword returns all records from the right table(2), even if there are no matches in the left table(1).
-- RIGHT JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- RIGHT JOIN table2
-- ON table1.column_name = table2.column_name;

-- The following SQL statement will return all employees, and any orders they might have placed:
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;

-- FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table
-- FULL OUTER JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- FULL OUTER JOIN table2
-- ON table1.column_name = table2.column_name
-- WHERE condition;

-- The following SQL statement selects all customers, and all orders:
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;


-- The SQL UNION Operator
-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- *Every SELECT statement within UNION must have the same number of columns
-- *The columns must also have similar data types
-- *The columns in every SELECT statement must also be in the same order

-- UNION Syntax
-- SELECT column_name(s) FROM table1
-- UNION
-- SELECT column_name(s) FROM table2;

-- UNION ALL Syntax
-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
-- SELECT column_name(s) FROM table1
-- UNION ALL
-- SELECT column_name(s) FROM table2;

-- The following SQL statement returns the cities (only distinct values) from both the "Customers" and the "Suppliers" table:
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;