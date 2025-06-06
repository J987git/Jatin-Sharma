CREATE database salesdb;
USE salesdb;
select * from listoforders_clean  ;
select * from orderdetails_clean;
select * from listoforders_clean  ;
select * from orderdetails_clean;
select * from salestarget_clean;
-- Total Sales per Order
SELECT 
    od.`Order ID`,
    SUM(od.Amount) AS TotalOrderValue
FROM orderdetails_clean od
GROUP BY od.`Order ID`;
Output
Order ID, TotalOrderValue
B-25601	1429
B-25602	3889
B-25603	2025
B-25604	222
B-25605	75
B-25606	87
B-25607	50
B-25608	2953
-- Total Sales per City
SELECT 
    lo.City,
    SUM(od.Amount) AS TotalSales
FROM listoforders_clean lo
JOIN orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
GROUP BY lo.City;
Output
 City, TotalSales
'Ahmedabad', '14230'
'Pune', '33481'
'Bhopal', '23583'
'Jaipur', '10076'
'Kolkata', '14086'
-- Top 5 Customers by Total Spending
SELECT 
    lo.CustomerName,
    SUM(od.Amount) AS TotalSpent
FROM listoforders_clean  lo
JOIN  orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
GROUP BY lo.CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;
Output
CustomerName, TotalSpent
'Yaanvi', '9177'
'Pooja', '9030'
'Abhishek', '8135'
'Surabhi', '6889'
'Soumya', '6869'
-- Top Category by Sales
SELECT 
    od.Category,
    SUM(od.Quantity ) AS ProductSales
FROM orderdetails_clean od
GROUP BY od.Category
ORDER BY ProductSales DESC
LIMIT 5;
Output
# Category, ProductSales
'Clothing', '3516'
'Electronics', '1154'
'Furniture', '945'
-- TotaL Profit BY Category
SELECT SUM(Profit) as Total_Profit,Category
FROM orderdetails_clean
group by Category;
Output
 Total_Profit, Category
'2298', 'Furniture'
'11163', 'Clothing'
'10494', 'Electronics'
-- Category Contribution Compared to Total
SELECT 
    Category,
    SUM(Profit) AS Category_Profit,
    ROUND(100.0 * SUM(Profit) / SUM(SUM(Profit)) OVER(), 2) AS Profit_Percentage
FROM orderdetails_clean
GROUP BY Category;
 -- Top 3 Customers by Spending per City
WITH CustomerSpending AS (
    SELECT 
        lo.City,
        lo.CustomerName,
        SUM(od.Amount) AS TotalSpent,
        ROW_NUMBER() OVER (PARTITION BY lo.City ORDER BY SUM(od.Amount) DESC) AS rn
    FROM listoforders_clean lo
    JOIN orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
    GROUP BY lo.City, lo.CustomerName
)
SELECT *
FROM CustomerSpending
WHERE rn <= 3;
 City, CustomerName, TotalSpent, rn
Output
'Ahmedabad', 'Gaurav', '3208', '1'
'Ahmedabad', 'Trupti', '2017', '2'
'Ahmedabad', 'Shardul', '1907', '3'
'Allahabad', 'Pooja', '5809', '1'
'Allahabad', 'Seema', '5228', '2'
'Allahabad', 'Vedant', '2208', '3'
'Amritsar', 'Monu', '1246', '1'
-- Monthly Sales Change
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(lo.`Order Date`, '%d-%m-%Y'), '%Y-%m') AS Month,
        SUM(od.Amount) AS TotalSales
    FROM listoforders_clean lo
    JOIN orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
    GROUP BY Month
)
SELECT 
    Month,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY Month) AS PrevMonthSales,
    (TotalSales - LAG(TotalSales) OVER (ORDER BY Month)) AS SalesChange
FROM MonthlySales;




