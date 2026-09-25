USE OnlinestoreDB;
GO


-- ============================================
-- Question 1: What are the top-selling products by quantity sold?
-- ============================================

SELECT 
    P.ProductName,
    SUM(OI.Quantity) AS TotalQuantitySold
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantitySold DESC;

/*
Finding:
The query successfully identifies top-selling products by aggregating 
order quantities. Since the underlying data is randomly generated for 
this demo, the differences between products (90-156 units) reflect 
random distribution rather than real market patterns -- but the query 
itself would surface meaningful business insights on real transactional 
data.
*/


-- ============================================
-- Question 2: What percentage of customers are repeat customers?
-- ============================================

SELECT 
    COUNT(DISTINCT CustomerID) AS TotalCustomers,
    SUM(CASE WHEN OrderCount > 1 THEN 1 ELSE 0 END) AS RepeatCustomers,
    CAST(SUM(CASE WHEN OrderCount > 1 THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(DISTINCT CustomerID) * 100 AS RepeatCustomerPercentage
FROM (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
) AS CustomerOrderCounts;

/*
Finding:
100% of customers made repeat purchases. This result is an artifact of 
the synthetic data design -- with 200 orders randomly distributed across 
only 10 customers, every customer was statistically certain to appear 
multiple times. A more realistic dataset would need a much larger and 
more varied customer base (e.g., 500+ customers) to produce a meaningful 
repeat-purchase rate.
*/


-- ============================================
-- Question 3: What is the monthly sales trend?
-- ============================================

SELECT 
    FORMAT(O.OrderDate, 'yyyy-MM') AS OrderMonth,
    COUNT(DISTINCT O.OrderID) AS TotalOrders,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY FORMAT(O.OrderDate, 'yyyy-MM')
ORDER BY OrderMonth;

/*
Finding:
Monthly order counts and revenue show no consistent trend or seasonality, 
fluctuating between 1-16 orders and $6,000-$55,000 in revenue per month. 
This is expected, since order dates were randomly generated rather than 
following real-world purchasing patterns (e.g., holiday seasonality). On 
real transactional data, this same query would reveal genuine trends and 
seasonal patterns, as it did in the Superstore sales analysis project.
*/


-- ============================================
-- Question 4: Which category and brand generate the most revenue?
-- ============================================

SELECT 
    C.CategoryName,
    B.BrandName,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN Brands B ON P.BrandID = B.BrandID
GROUP BY C.CategoryName, B.BrandName
ORDER BY TotalRevenue DESC;

/*
Finding:
Laptops (TechNova brand) generate by far the highest revenue ($365,910), 
nearly 3x more than the next category. Despite roughly similar unit sales 
across products (see Question 1), high-ticket items like laptops 
naturally dominate total revenue due to their higher unit price. This 
highlights that revenue and sales volume can tell very different stories 
-- a business should track both metrics separately.
*/


-- ============================================
-- Question 5: Who are the top-spending customers?
-- ============================================

SELECT 
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalSpent
FROM OrderItems OI
JOIN Orders O ON OI.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

/*
Finding:
Top-spending customers range from $36,856 to $88,817, a roughly 2.4x 
difference. Since order-to-customer assignment was randomized, this 
spread mainly reflects which high-ticket items (e.g., laptops) each 
customer happened to purchase, rather than genuine spending behavior. On 
real data, this query would be a key tool for identifying VIP customers 
for loyalty programs or targeted marketing.
*/