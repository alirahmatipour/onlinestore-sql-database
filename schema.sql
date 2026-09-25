Create DataBase OnlinestoreDB;
GO

Use OnlinestoreDB;
GO

Create Table Customers
(
	CustomerID INT IDENTITY (1,1) Primary Key,
	FirstName NVarchar(50) NOT NULL,
	LastName  NVarchar(50) NOT NULL,
	Gender Bit NOT NULL,
	Email NVARCHAR(250) NOT NULL UNIQUE
);
GO

CREATE TABLE Addresses
(
	AddressesID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL,
	Country NVARCHAR(100) NOT NULL,
	Province NVARCHAR(100) NOT NULL,
	City NVARCHAR(100) NOT NULL,
	Area NVARCHAR(100)  NULL,
	AddressLine NVARCHAR(500) NOT NULL,
	PostalCode varchar(500) NULL,

   IsDefault BIT NOT NULL
        CONSTRAINT DF_Addresses_IsDefault DEFAULT 0,

    CONSTRAINT FK_Addresses_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO

Create Table Brands
(
	BrandID INT IDENTITY(1,1) PRIMARY KEY,
	BrandName NVARCHAR(100) NOT NULL
		CONSTRAINT UQ_Brands_BrandName UNIQUE
);
GO

Create table Categories
(
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName NVARCHAR(100) NOT NULL
		CONSTRAINT UQ_Categories_CategoryName UNIQUE,

    Description NVARCHAR(500) NULL
);
GO

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,

    ProductName NVARCHAR(200) NOT NULL,

    Description NVARCHAR(MAX) NULL,

    BrandID INT NOT NULL,

    CategoryID INT NOT NULL,

    Price DECIMAL(10,2) NOT NULL,

    Stock INT NOT NULL
        CONSTRAINT CK_Products_Stock
        CHECK (Stock >= 0),

    SKU VARCHAR(50) NOT NULL
        CONSTRAINT UQ_Products_SKU UNIQUE,

    ImageURL NVARCHAR(500) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Products_IsActive DEFAULT 1,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Products_CreatedAt DEFAULT SYSDATETIME(),

    UpdatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Products_UpdatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Products_Brands
        FOREIGN KEY (BrandID)
        REFERENCES Brands(BrandID),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
GO

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,

    CustomerID INT NOT NULL,

    OrderDate DATETIME2 NOT NULL
        CONSTRAINT DF_Orders_OrderDate DEFAULT SYSDATETIME(),

    Status NVARCHAR(50) NOT NULL
        CONSTRAINT DF_Orders_Status DEFAULT 'Pending',

    ShippingAddressID INT NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Addresses
        FOREIGN KEY (ShippingAddressID)
        REFERENCES Addresses(AddressesID)
);
GO

CREATE TABLE OrderItems
(
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL,

    ProductID INT NOT NULL,

    Quantity INT NOT NULL
        CONSTRAINT CK_OrderItems_Quantity
        CHECK (Quantity > 0),

    UnitPrice DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO