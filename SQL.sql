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
-- Top Category by Sales
SELECT 
    od.Category,
    SUM(od.Quantity ) AS ProductSales
FROM orderdetails_clean od
GROUP BY od.Category
ORDER BY ProductSales DESC
LIMIT 5;
-- TotaL Profit BY Category
SELECT SUM(Profit) as Total_Profit,Category
FROM orderdetails_clean
group by Category;



