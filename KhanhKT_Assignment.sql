CREATE DATABASE KhanhKT_Assignment
GO

USE KhanhKT_Assignment
GO

CREATE TABLE Registration 
(
	username varchar(20) NOT NULL,
	password varchar(20) NOT NULL,
	fullName nvarchar(20) NOT NULL,
	isAdmin bit DEFAULT (0) NOT NULL,
	CONSTRAINT PK_Registration PRIMARY KEY (username)
)
GO

CREATE TABLE Product
(
	SKU varchar(20) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Price money NOT NULL,
	Description nvarchar(50) NOT NULL,
	Quantity int NOT NULL,
	CONSTRAINT PK_Product PRIMARY KEY (SKU)
)
GO

CREATE TABLE Orders
(
	OrderID int IDENTITY,
	Name nvarchar(50) NOT NULL,
	Address nvarchar(50) NOT NULL,
	[Date] datetime DEFAULT GetDate() NOT NULL,
	Total money NOT NULL,
	CONSTRAINT PK_Order PRIMARY KEY (OrderID)
)
GO

CREATE TABLE OrderDetails
(
	SKU varchar(20) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Price money NOT NULL,
	Quantity int NOT NULL,
	Total money NOT NULL,
	OrderID int NOT NULL,

	CONSTRAINT FK_OrderDetails_Orders 
	FOREIGN KEY (OrderID) 
	REFERENCES Orders(OrderID),

	CONSTRAINT FK_OrderDetails_Product 
	FOREIGN KEY (SKU) 
	REFERENCES Product(SKU),
)
GO

INSERT INTO Registration (username, password, fullName, isAdmin)
VALUES 
	('admin', 'admin123', 'Khoa', 1),
	('kasi', 'khoa123', 'KhoaNDA', 1),
	('se1', 'khoa123', 'KhoaNA', 0),
	('se2', 'khoa123', 'Khoaaa', 0),
	('se3', 'khoa123', 'KhanhKT', 1),
	('se4', 'khoa123', 'HoangNT', 0),
	('se5', 'khoa123', 'HoaDoan', 0),
	('se6', 'khoa123', 'DuongNG', 0),
	('se7', 'khoa123', 'TrieuNM', 0),
	('se8', 'khoa123', 'KhoaNA', 0),
	('se9', 'khoa123', 'ABC', 0),
	('se10', 'khoa123', 'XYZa', 0)
GO

INSERT INTO Product (SKU, Name, Price, Description, Quantity)
VALUES 
	('BOOK01', 'Servlet', '100000', 'Servlet Fundamental', 100),
	('BOOK02', 'Tomcat', '90000', 'Tomcat Fundamental', 90),
	('BOOK03', 'JSP', '80000', 'JSP Fundamental', 80),
	('BOOK04', 'MVC2', '70000', 'MVC2 Fundamental', 70),
	('BOOK05', 'JavaEE', '60000', 'JavaEE Fundamental', 60),
	('BOOK06', 'Expression Language', '50000', 'EL Fundamental', 50),
	('BOOK07', 'EJB2', '40000', 'EJB2 Fundamental', 40),
	('BOOK08', 'EJB3', '30000', 'EJB3 Fundamental', 30),
	('BOOK09', 'Scripting Elements', '20000', 'Scripting Elements Fundamental', 20),
	('BOOK10', 'Jboss', '10000', 'Jboss Fundamental', 0)
GO

-- sau khi checkout thì quantity (Product) = quantity(Product) - quantity (OrderDetail)

CREATE TRIGGER TR_OderDetails_Insert ON OrderDetails AFTER INSERT AS 
BEGIN

	DECLARE @SKU VARCHAR(20);
	DECLARE @orderDetailsQuantity INT;

	SELECT @SKU = SKU, @orderDetailsQuantity = Quantity 
	FROM inserted;

	IF ((SELECT Quantity FROM Product WHERE SKU = @SKU) >= @orderDetailsQuantity)
	BEGIN
		UPDATE Product
		SET Quantity = Quantity - @orderDetailsQuantity
		WHERE SKU = @SKU
	END
	ELSE 
		ROLLBACK TRAN;
END
GO
