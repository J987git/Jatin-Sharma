-- TotaL Profit BY Category
SELECT SUM(Profit) as Total_Profit,Category
FROM orderdetails_clean
group by Category;