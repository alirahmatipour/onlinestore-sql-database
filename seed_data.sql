-- Insert sample brands
INSERT INTO Brands (BrandName) VALUES
('TechNova'),
('SoundWave'),
('PixelGear'),
('CoreLine'),
('UrbanTech');

-- Insert sample categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Laptops', 'Portable computers for work and gaming'),
('Headphones', 'Wired and wireless audio devices'),
('Smartphones', 'Mobile phones and accessories'),
('Cameras', 'Digital cameras and photography gear'),
('Smart Home', 'Connected home devices');

-- Insert sample customers
INSERT INTO Customers (FirstName, LastName, Gender, Email) VALUES
('Ali', 'Karimi', 1, 'ali.karimi@example.com'),
('Sara', 'Ahmadi', 0, 'sara.ahmadi@example.com'),
('Reza', 'Hosseini', 1, 'reza.hosseini@example.com'),
('Maryam', 'Ghorbani', 0, 'maryam.ghorbani@example.com'),
('Amir', 'Moradi', 1, 'amir.moradi@example.com'),
('Nasrin', 'Jafari', 0, 'nasrin.jafari@example.com'),
('Hossein', 'Rezaei', 1, 'hossein.rezaei@example.com'),
('Fatemeh', 'Sadeghi', 0, 'fatemeh.sadeghi@example.com'),
('Mohammad', 'Karimi', 1, 'mohammad.karimi@example.com'),
('Zahra', 'Ebrahimi', 0, 'zahra.ebrahimi@example.com');

-- Insert sample products
INSERT INTO Products (ProductName, BrandID, CategoryID, Price, Stock, SKU) VALUES
('TechNova Pro Laptop 15"', 1, 1, 1250.00, 25, 'TN-LP-001'),
('SoundWave Bluetooth Headphones', 2, 2, 89.99, 60, 'SW-HP-001'),
('PixelGear Smartphone X', 3, 3, 699.00, 40, 'PG-SP-001'),
('CoreLine DSLR Camera', 4, 4, 549.50, 15, 'CL-CAM-001'),
('UrbanTech Smart Speaker', 5, 5, 45.00, 100, 'UT-SPK-001'),
('TechNova Gaming Laptop', 1, 1, 1899.00, 10, 'TN-LP-002'),
('SoundWave Wired Earbuds', 2, 2, 19.99, 150, 'SW-EB-001'),
('PixelGear Smartphone Mini', 3, 3, 449.00, 55, 'PG-SP-002'),
('CoreLine Action Camera', 4, 4, 299.00, 30, 'CL-CAM-002'),
('UrbanTech Smart Bulb', 5, 5, 15.00, 200, 'UT-BLB-001');

-- Insert sample addresses (one per customer)
INSERT INTO Addresses (CustomerID, Country, Province, City, AddressLine, PostalCode, IsDefault) VALUES
(1, 'Iran', 'Tehran', 'Tehran', 'Valiasr St, No. 12', '1234567890', 1),
(2, 'Iran', 'Isfahan', 'Isfahan', 'Chahar Bagh St, No. 45', '2345678901', 1),
(3, 'Iran', 'Fars', 'Shiraz', 'Zand St, No. 78', '3456789012', 1),
(4, 'Iran', 'Tehran', 'Tehran', 'Enghelab St, No. 23', '4567890123', 1),
(5, 'Iran', 'Razavi Khorasan', 'Mashhad', 'Imam Reza St, No. 56', '5678901234', 1),
(6, 'Iran', 'Tehran', 'Tehran', 'Azadi St, No. 89', '6789012345', 1),
(7, 'Iran', 'East Azerbaijan', 'Tabriz', 'Shariati St, No. 34', '7890123456', 1),
(8, 'Iran', 'Isfahan', 'Isfahan', 'Hakim Nezami St, No. 67', '8901234567', 1),
(9, 'Iran', 'Tehran', 'Tehran', 'Karimkhan St, No. 90', '9012345678', 1),
(10, 'Iran', 'Fars', 'Shiraz', 'Karimkhan St, No. 11', '0123456789', 1);

-- Generate random orders and order items
DECLARE @i INT = 1;
DECLARE @OrderID INT;
DECLARE @RandomCustomerID INT;
DECLARE @RandomAddressID INT;
DECLARE @RandomProductID INT;
DECLARE @RandomQuantity INT;
DECLARE @ProductPrice DECIMAL(10,2);
DECLARE @NumItems INT;
DECLARE @j INT;

WHILE @i <= 100
BEGIN
    -- Pick a random customer (1 to 10)
    SET @RandomCustomerID = ABS(CHECKSUM(NEWID())) % 10 + 1;

    -- Get that customer's default address
    SELECT TOP 1 @RandomAddressID = AddressesID 
    FROM Addresses 
    WHERE CustomerID = @RandomCustomerID;

    -- Insert the order
    INSERT INTO Orders (CustomerID, OrderDate, Status, ShippingAddressID)
    VALUES (
        @RandomCustomerID,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 700, SYSDATETIME()),
        'Delivered',
        @RandomAddressID
    );

    SET @OrderID = SCOPE_IDENTITY();

    -- Add 1 to 3 random items to this order
    SET @NumItems = ABS(CHECKSUM(NEWID())) % 3 + 1;
    SET @j = 1;

    WHILE @j <= @NumItems
    BEGIN
        SET @RandomProductID = ABS(CHECKSUM(NEWID())) % 10 + 1;
        SET @RandomQuantity = ABS(CHECKSUM(NEWID())) % 5 + 1;

        SELECT @ProductPrice = Price FROM Products WHERE ProductID = @RandomProductID;

        INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
        VALUES (@OrderID, @RandomProductID, @RandomQuantity, @ProductPrice);

        SET @j = @j + 1;
    END

    SET @i = @i + 1;
END



SELECT COUNT(*) FROM Orders;

SELECT COUNT(*) FROM OrderItems;