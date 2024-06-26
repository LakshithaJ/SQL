import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword"
)

print(mydb)

# Creating a Database
# To create a database in MySQL, use the "CREATE DATABASE" statement:
mycursor = mydb.cursor()
mycursor.execute("CREATE DATABASE mydatabase")

# Return a list of system's databases:
mycursor.execute("SHOW DATABASES")
for x in mycursor:
  print(x)

# Create a table named "customers":
mycursor.execute("CREATE TABLE customers (name VARCHAR(255), address VARCHAR(255))")

# Check if Table Exists
mycursor.execute("SHOW TABLES")
for x in mycursor:
  print(x)

# Create primary key when creating the table:
mycursor.execute("CREATE TABLE customers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), address VARCHAR(255))")

# Insert a record in the "customers" table:
sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = ("John", "Highway 21")
mycursor.execute(sql, val)
mydb.commit()


# Insert Multiple Rows
sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = [
  ('Peter', 'Lowstreet 4'),
  ('Amy', 'Apple st 652'),
  ('Hannah', 'Mountain 21'),
  ('Michael', 'Valley 345'),
  ('Sandy', 'Ocean blvd 2'),
  ('Betty', 'Green Grass 1'),
  ('Richard', 'Sky st 331'),
  ('Susan', 'One way 98'),
  ('Vicky', 'Yellow Garden 2'),
  ('Ben', 'Park Lane 38'),
  ('William', 'Central st 954'),
  ('Chuck', 'Main Road 989'),
  ('Viola', 'Sideway 1633')
]

mycursor.executemany(sql, val)
mydb.commit()

# Select all records from the "customers" table, and display the result:
mycursor.execute("SELECT * FROM customers")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Select only the name and address columns:
mycursor.execute("SELECT name, address FROM customers")
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# The fetchone() method will return the first row of the result:
mycursor.execute("SELECT * FROM customers")
myresult = mycursor.fetchone()
print(myresult)

# Select record(s) where the address is "Park Lane 38": result:
sql = "SELECT * FROM customers WHERE address ='Park Lane 38'"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Wildcard Characters
# Select records where the address contains the word "way":
sql = "SELECT * FROM customers WHERE address LIKE '%way%'"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Prevent SQL Injection
# When query values are provided by the user, you should escape the values.
# This is to prevent SQL injections, which is a common web hacking technique to destroy or misuse your database.
sql = "SELECT * FROM customers WHERE address = %s"
adr = ("Yellow Garden 2", )
mycursor.execute(sql, adr)

myresult = mycursor.fetchall()
for x in myresult:
  print(x)

# Sort the Result
# Use the ORDER BY statement to sort the result in ascending or descending order
# The ORDER BY keyword sorts the result ascending by default. To sort the result in descending order, use the DESC keyword.
sql = "SELECT * FROM customers ORDER BY name"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Sort the result reverse alphabetically by name:
sql = "SELECT * FROM customers ORDER BY name DESC"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Delete Record
# You can delete records from an existing table by using the "DELETE FROM" statement:
# Delete any record where the address is "Mountain 21":
sql = "DELETE FROM customers WHERE address = 'Mountain 21'"
mycursor.execute(sql)
mydb.commit()

print(mycursor.rowcount, "record(s) deleted")

# Escape values by using the placeholder %s method:
sql = "DELETE FROM customers WHERE address = %s"
adr = ("Yellow Garden 2", )
mycursor.execute(sql, adr)
mydb.commit()

print(mycursor.rowcount, "record(s) deleted")

# Delete the table "customers":
sql = "DROP TABLE customers"
mycursor.execute(sql)

# Delete the table "customers" if it exists:
sql = "DROP TABLE IF EXISTS customers"
mycursor.execute(sql)

# Overwrite the address column from "Valley 345" to "Canyon 123":
sql = "UPDATE customers SET address = 'Canyon 123' WHERE address = 'Valley 345'"
mycursor.execute(sql)
mydb.commit()

print(mycursor.rowcount, "record(s) affected")

# Escape values by using the placeholder %s method:
sql = "UPDATE customers SET address = %s WHERE address = %s"
val = ("Valley 345", "Canyon 123")
mycursor.execute(sql, val)
mydb.commit()

print(mycursor.rowcount, "record(s) affected")

# Select the 5 first records in the "customers" table:
mycursor.execute("SELECT * FROM customers LIMIT 5")
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# Start From Another Position
# If you want to return five records, starting from the third record, you can use the "OFFSET" keyword:
# Start from position 3, and return 5 records:
mycursor.execute("SELECT * FROM customers LIMIT 5 OFFSET 2")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# users
# { id: 1, name: 'John', fav: 154},
# { id: 2, name: 'Peter', fav: 154},
# { id: 3, name: 'Amy', fav: 155},
# { id: 4, name: 'Hannah', fav:},
# { id: 5, name: 'Michael', fav:}
# products
# { id: 154, name: 'Chocolate Heaven' },
# { id: 155, name: 'Tasty Lemons' },
# { id: 156, name: 'Vanilla Dreams' }

# Join users and products to see the name of the users favorite product:
sql = "SELECT \
  users.name AS user, \
  products.name AS favorite \
  FROM users \
  INNER JOIN products ON users.fav = products.id"
mycursor.execute(sql)
myresult = mycursor.fetchall()

for x in myresult:
  print(x)

# LEFT JOIN
# Select all users and their favorite product:
sql = "SELECT \
  users.name AS user, \
  products.name AS favorite \
  FROM users \
  LEFT JOIN products ON users.fav = products.id"

# RIGHT JOIN
# Select all products, and the user(s) who have them as their favorite:
sql = "SELECT \
  users.name AS user, \
  products.name AS favorite \
  FROM users \
  RIGHT JOIN products ON users.fav = products.id"