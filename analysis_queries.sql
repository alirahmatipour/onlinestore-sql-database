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