
# 🚗 Vehicle Price Analysis (SQL Project)

A data analytics project where I explored and analyzed a vehicle price dataset using **advanced SQL techniques** to uncover insights, detect patterns, and practice complex querying with real-world-like data.

---

## 📁 Dataset
The dataset contains various vehicle listings with details like:
- `make`
- `model`
- `year`
- `price`
- `fuel`
- `transmission`
- `mileage`

---

## 🧠 SQL Techniques Used

- ✅ **Common Table Expressions (CTEs)**
- ✅ **Window Functions**: `RANK()`, `ROW_NUMBER()`, `LAG()`, `PERCENTILE_CONT()`
- ✅ **Correlated Subqueries**
- ✅ **CASE Statements for Categorization**
- ✅ **Aggregate Functions + GROUP BY + JOINS**

---

## 📊 Key Questions Answered

1. Which are the top 3 most expensive models for each brand?
2. What is the most popular transmission type by brand?
3. Which vehicles are priced above their brand’s average?
4. Have vehicle prices increased consistently year-over-year for some models?
5. Which listings are outliers based on price (using IQR method)?
6. How do fuel types contribute to each brand's share?
7. Categorized vehicles into Budget | Mid-Range | Luxury segments

---

## 💻 Full SQL Queries

```sql
-- 1. Get the Latest Price for Each Vehicle Model
WITH latest_price AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY model ORDER BY year DESC) AS rn
  FROM vehicle_price
)
SELECT *
FROM latest_price
WHERE rn = 1;

-- 2. Rank Vehicles by Price Within Each Brand
SELECT make, model, price,
       RANK() OVER (PARTITION BY make ORDER BY price DESC) AS price_rank
FROM vehicle_price;

-- 3. Top 3 Most Expensive Models by Brand
WITH ranked_vehicles AS (
  SELECT *, 
         DENSE_RANK() OVER (PARTITION BY make ORDER BY price DESC) AS price_rank
  FROM vehicle_price
)
SELECT *
FROM ranked_vehicles
WHERE price_rank <= 3;

-- 4. Average Price per Brand and Price Difference
SELECT make, model, year, price,
       ROUND(AVG(price) OVER (PARTITION BY make), 2) AS avg_make_price,
       price - AVG(price) OVER (PARTITION BY make) AS price_diff
FROM vehicle_price;

-- 5. Year-over-Year Price Change for Each Model
SELECT make, model, year, price,
       LAG(price) OVER (PARTITION BY make, model ORDER BY year) AS prev_year_price,
       price - LAG(price) OVER (PARTITION BY make, model ORDER BY year) AS price_change
FROM vehicle_price;

-- 6. Most Common Transmission Type by Brand
WITH trans_counts AS (
  SELECT make, transmission,
         COUNT(*) AS trans_count,
         RANK() OVER (PARTITION BY make ORDER BY COUNT(*) DESC) AS rnk
  FROM vehicle_price
  GROUP BY make, transmission
)
SELECT *
FROM trans_counts
WHERE rnk = 1;

-- 7. Cumulative Sales by Brand Over the Years
SELECT make, year, SUM(price) AS yearly_sales,
       SUM(SUM(price)) OVER (PARTITION BY make ORDER BY year) AS cumulative_sales
FROM vehicle_price
GROUP BY make, year;

-- 8. Vehicles Above Brand Average Price (JOIN version)
SELECT v.*
FROM vehicle_price v
JOIN (
    SELECT make, AVG(price) AS avg_price
    FROM vehicle_price
    GROUP BY make
) avg_table
ON v.make = avg_table.make
WHERE v.price > avg_table.avg_price;

-- 9. Fuel Type Share by Brand
WITH brand_total AS (
  SELECT make, COUNT(*) AS total_count
  FROM vehicle_price
  GROUP BY make
),
fuel_distribution AS (
  SELECT make, fuel, COUNT(*) AS fuel_count
  FROM vehicle_price
  GROUP BY make, fuel
)
SELECT f.make, f.fuel, f.fuel_count,
       ROUND(100.0 * f.fuel_count / b.total_count, 2) AS fuel_share_percentage
FROM fuel_distribution f
JOIN brand_total b ON f.make = b.make
ORDER BY f.make, fuel_share_percentage DESC;

-- 10. Categorize Vehicles by Price Range
SELECT *,
       CASE 
         WHEN price < 300000 THEN 'Budget'
         WHEN price BETWEEN 300000 AND 1000000 THEN 'Mid-Range'
         ELSE 'Luxury'
       END AS price_category
FROM vehicle_price;

-- 11. Find Models That Never Dropped in Price
WITH price_sequence AS (
  SELECT make, model, year, price,
         LAG(price) OVER (PARTITION BY make, model ORDER BY year) AS prev_price
  FROM vehicle_price
),
price_flags AS (
  SELECT make, model,
         CASE WHEN price < prev_price THEN 1 ELSE 0 END AS dropped
  FROM price_sequence
  WHERE prev_price IS NOT NULL
)
SELECT make, model
FROM price_flags
GROUP BY make, model
HAVING SUM(dropped) = 0;

-- 12. Detect Outliers in Price (IQR method)
WITH price_stats AS (
  SELECT 
    make,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) OVER (PARTITION BY make) AS Q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) OVER (PARTITION BY make) AS Q3
  FROM vehicle_price
),
with_bounds AS (
  SELECT DISTINCT make,
         Q1,
         Q3,
         Q1 - 1.5 * (Q3 - Q1) AS lower_bound,
         Q3 + 1.5 * (Q3 - Q1) AS upper_bound
  FROM price_stats
)
SELECT v.make, v.model, v.price
FROM vehicle_price v
JOIN with_bounds w ON v.make = w.make
WHERE v.price < w.lower_bound OR v.price > w.upper_bound;

-- 13. Consecutive Years with Increasing Prices
WITH price_diff AS (
  SELECT make, model, year, price,
         LAG(price) OVER (PARTITION BY make, model ORDER BY year) AS prev_price
  FROM vehicle_price
),
flagged AS (
  SELECT *, 
         CASE WHEN price > prev_price THEN 1 ELSE 0 END AS increased
  FROM price_diff
  WHERE prev_price IS NOT NULL
)
SELECT make, model, COUNT(*) AS consecutive_increases
FROM flagged
WHERE increased = 1
GROUP BY make, model
ORDER BY consecutive_increases DESC;
```

---
