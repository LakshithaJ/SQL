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