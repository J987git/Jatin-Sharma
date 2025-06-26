
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

*(CSV file uploaded manually or from Kaggle / internal source.)*

---

## 🧠 SQL Techniques Used

- ✅ **Common Table Expressions (CTEs)**
- ✅ **Window Functions**: `RANK()`, `ROW_NUMBER()`, `LAG()`, `PERCENTILE_CONT()`
- ✅ **Correlated Subqueries**
- ✅ **CASE Statements for Categorization**
- ✅ **Aggregate Functions + GROUP BY + JOINS**

---

## 📊 Key Questions Answered

1. **Which are the top 3 most expensive models for each brand?**
2. **What is the most popular transmission type by brand?**
3. **Which vehicles are priced above their brand’s average?**
4. **Have vehicle prices increased consistently year-over-year for some models?**
5. **Which listings are outliers based on price (using IQR method)?**
6. **How do fuel types contribute to each brand's share?**
7. **Categorized vehicles into Budget | Mid-Range | Luxury segments**

---

## 🧪 Sample SQL Queries

### Top 3 Expensive Models by Make
```sql
WITH ranked_vehicles AS (
  SELECT *, 
         DENSE_RANK() OVER (PARTITION BY make ORDER BY price DESC) AS price_rank
  FROM vehicle_price
)
SELECT *
FROM ranked_vehicles
WHERE price_rank <= 3;
```

### Price Above Brand Average
```sql
SELECT v.*
FROM vehicle_price v
JOIN (
    SELECT make, AVG(price) AS avg_price
    FROM vehicle_price
    GROUP BY make
) avg_table
ON v.make = avg_table.make
WHERE v.price > avg_table.avg_price;
```

*(More complex queries available in the `/queries` folder)*

---

## 🛠 Tech Stack

- **SQL (MySQL)**
- **Excel** (for quick data cleanup and profiling)
- *(Optional: Power BI or Python for visualization)*

---

## 📎 Files Included

| File | Description |
|------|-------------|
| `Vehicle Price.csv` | The dataset |
| `vehicle_price_queries.sql` | Full list of SQL queries |
| `README.md` | This file |
| `LinkedIn_Poster.png` | Visual summary for sharing |

---

## 📣 LinkedIn Post

📌 View my [LinkedIn post here](#) — feel free to connect and share feedback!

---

## 📬 Contact

**Jatin Sharma**  
[📧 Email](mailto:jatinsharma@email.com) • [🔗 LinkedIn](https://www.linkedin.com/in/jatinsharma) • [💻 Portfolio](https://github.com/J987git)

---

> **Note**: All data used here is for educational/portfolio purposes only.
