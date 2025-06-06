
# **Sales Database Analysis Project**

## **Overview**
This project involves performing SQL-based analysis on a sales database. The analysis covers various aspects of the sales data, such as total sales per order, total sales by city, top customers by total spending, and the top-selling categories. The project utilizes the following SQL operations:
- **Database Creation**
- **Data Aggregation**
- **Joins between tables**
- **Grouping and Summarizing Data**

## **Database Schema**
The project works with three main tables:

1. **listoforders_clean**: Contains order details such as `Order ID`, `CustomerName`, `City`, etc.
2. **orderdetails_clean**: Contains details for each order such as `Order ID`, `Amount`, `Quantity`, `Category`, etc.
3. **salestarget_clean**: Includes sales target data (though not used in the current queries).

## **SQL Queries in the Project**

### 1. **Creating the Database**
```sql
CREATE database salesdb;
USE salesdb;
```

### 2. **Retrieving Data from Tables**
```sql
SELECT * FROM listoforders_clean;
SELECT * FROM orderdetails_clean;
SELECT * FROM salestarget_clean;
```

### 3. **Total Sales per Order**
This query calculates the total value of each order.
```sql
SELECT 
    od.`Order ID`,
    SUM(od.Amount) AS TotalOrderValue
FROM orderdetails_clean od
GROUP BY od.`Order ID`;
```

### 4. **Total Sales per City**
This query calculates the total sales for each city by joining the `listoforders_clean` and `orderdetails_clean` tables.
```sql
SELECT 
    lo.City,
    SUM(od.Amount) AS TotalSales
FROM listoforders_clean lo
JOIN orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
GROUP BY lo.City;
```

### 5. **Top 5 Customers by Total Spending**
This query finds the top 5 customers who have spent the most, based on their order totals.
```sql
SELECT 
    lo.CustomerName,
    SUM(od.Amount) AS TotalSpent
FROM listoforders_clean lo
JOIN orderdetails_clean od ON lo.`Order ID` = od.`Order ID`
GROUP BY lo.CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;
```

### 6. **Top Category by Sales**
This query calculates the total sales per product category and ranks them in descending order.
```sql
SELECT 
    od.Category,
    SUM(od.Quantity) AS ProductSales
FROM orderdetails_clean od
GROUP BY od.Category
ORDER BY ProductSales DESC
LIMIT 5;
```

### 7. **Total Profit by Category**
This query calculates the total profit per product category.
```sql
SELECT 
    SUM(Profit) AS Total_Profit,
    Category
FROM orderdetails_clean
GROUP BY Category;
```

### 8. **Category Contribution Compared to Total**
This query calculates the total profit percentage per product category.
```sql
SELECT 
    Category,
    SUM(Profit) AS Category_Profit,
    ROUND(100.0 * SUM(Profit) / SUM(SUM(Profit)) OVER(), 2) AS Profit_Percentage
FROM orderdetails_clean
GROUP BY Category;
```

### 9. **Top 3 Customers by Spending per City**
```sql
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
```

### 10.**Monthly Sales Change**
```sql
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
```

## **Project Setup**

### 1. **Database Setup**
Run the following command to create the database:
```sql
CREATE database salesdb;
```
Then, use the following command to select the database:
```sql
USE salesdb;
```

### 2. **Running Queries**
Execute the provided SQL queries sequentially to analyze the data. The queries are designed to be run in a typical SQL environment such as MySQL Workbench, SQL Server Management Studio, or any compatible platform.

### 3. **Data Analysis**
Each query serves a specific purpose to help analyze different aspects of sales, from total sales by order and city to identifying top customers and categories.

---

## **Notes**

- **Data Quality**: The tables `listoforders_clean`, `orderdetails_clean`, and `salestarget_clean` are assumed to have cleaned and structured data. If any data cleaning or preprocessing is needed, ensure the datasets are ready for analysis.
