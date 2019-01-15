--First Part
CREATE TABLE Titles(
	ID INT IDENTITY(1,1),
	Title nvarchar(20)
)

INSERT INTO Titles(Title)
VALUES ('Director'),
	   ('Vice President'),
	   ('Investment associate'),
	   ('Investment analyst')

CREATE TABLE Users(
	ID INT IDENTITY(1,1),
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Oib nvarchar (11),
	PhoneNumber nvarchar(20),
	Address nvarchar(20),
	City nvarchar(20),
	Country nvarchar(50),
	PostalCode nvarchar(20)
)

CREATE TABLE Transactions(
	ID INT IDENTITY(1,1),
	DateOfTransaction DateTime,
	Status BIT NOT NULL 
)

CREATE TABLE Employees(
	ID INT IDENTITY(1,1),
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Title nvarchar(20),
	Email nvarchar(30)
)

ALTER TABLE Users
ADD UNIQUE (Oib)

INSERT INTO Users(FirstName, LastName, Oib, PhoneNumber, Address, City, Country, PostalCode)
VALUES ('Vedran',N'Lašiæ','12345678901','0989180123',N'Matoševa 18','Split','Croatia','21000'),
	   ('Luka', N'Lukiæ', '98765432109','0977654321', N'Teslina 18','Split','Croatia','21000' ),
	   ('Filip',N'Filipoviæ','12345654321','0918836465',N'Rendiæeva 19','Split','Croatia','21000')

SELECT * FROM Users

UPDATE Users
SET FirstName = 'Ivan'
WHERE LastName = N'Lukiæ'

UPDATE Users
SET  PhoneNumber = '0918636363',
	 LastName = N'Filipiæ'
WHERE Oib = '0918836465'

DELETE Users
WHERE Address = N'Matoševa 18'

ALTER TABLE Transactions
ADD Description nvarchar(100)

ALTER TABLE Employees
ADD EmployeeNotes nvarchar(100)

INSERT INTO Employees(FirstName, LastName, Title, Email, EmployeeNotes)
VALUES ('Ante','Novak','Director', 'antenovak@firma.hr', 'Great and reliable'),
	   ('Josip', N'Novakoviæ','Vice president', 'novakovicjosip1@gmail.com','Hard-working'),
	   ('Viktor', N'Gašpar','Investment analyst','viktorinator@hotmail.com','Funny and cheerful')

SELECT * FROM Employees
WHERE FirstName LIKE N'[a-g]%'

INSERT INTO Transactions(DateOfTransaction, Status, Description)
VALUES ('2019-1-1 10:30:00', 1, 'Transaction completed'),
	   ('2019-1-20 18:00:00', 0, 'Transaction pending')

--Second Part

--1
SELECT TOP 50 CompanyName, ContactName, ContactTitle, Address, City, Phone FROM Customers

--2
SELECT COUNT(CustomerID) AS NumberOfCustomersWithDefinedFaxAndRegion FROM Customers
WHERE Fax IS NOT NULL AND Region IS NOT NULL

--3
SELECT TOP 2 FirstName, LastName, Title FROM Employees
ORDER BY BirthDate

--4
SELECT * FROM Customers
WHERE Address LIKE '[0-9]%' AND CompanyName LIKE '__a%'
ORDER BY Country

--5
SELECT OrderID FROM Orders
WHERE OrderID IN (SELECT TOP 1 OrderID FROM [Order Details]
GROUP BY OrderID
ORDER BY SUM(Quantity) DESC)

--6
SELECT Count(CustomerID) AS NumberOfCustomersWithoutOrders FROM Customers
WHERE NOT EXISTS (SELECT * FROM Orders WHERE Customers.CustomerID = CustomerID)