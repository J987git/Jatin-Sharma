-- Top Category by Sales
SELECT 
    od.Category,
    SUM(od.Quantity ) AS ProductSales
FROM orderdetails_clean od
GROUP BY od.Category
ORDER BY ProductSales DESC
LIMIT 5;
