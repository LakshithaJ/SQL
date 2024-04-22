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