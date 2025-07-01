
# 🎬 IMDb SQL Analysis Project

This project is based on a synthetic IMDb-style dataset containing 100,000+ rows and 16 columns. The project showcases advanced SQL techniques for analyzing movie-related data such as revenue, ratings, genres, actors, and more.

---



- **Rows**: 100,000
- **Columns**: 16
  
- **File**: `imdb_large_100k.csv`

---

## 📁 Columns Used

- `movie_id`
- `title`
- `original_title`
- `year`
- `genres`
- `duration`
- `certificate`
- `language`
- `country`
- `average_rating`
- `num_votes`
- `budget`
- `box_office`
- `director_name`
- `main_actor`
- `production_company`

---

## 💡 SQL Queries Used in Analysis

### 1. Top 3 Movies Per Genre by Box Office
```sql
SELECT *
FROM (
    SELECT title, genres, box_office,
           ROW_NUMBER() OVER (PARTITION BY genres ORDER BY box_office DESC) AS rn
    FROM imdb
) AS genre_ranked
WHERE rn <= 3;
```

### 2. Highest-Grossing Movie by Each Director
```sql
SELECT director_name, title, box_office
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY director_name ORDER BY box_office DESC) AS rn
    FROM imdb
) AS ranked
WHERE rn = 1;
```

### 3. Average Box Office per Certificate
```sql
SELECT certificate, COUNT(*) AS movie_count,
       ROUND(AVG(box_office), 2) AS avg_box_office
FROM imdb
GROUP BY certificate
ORDER BY avg_box_office DESC;
```

### 4. Top 5 Languages by Total Revenue
```sql
SELECT language, COUNT(*) AS total_movies,
       SUM(box_office) AS total_revenue
FROM imdb
GROUP BY language
ORDER BY total_revenue DESC
LIMIT 5;
```

### 5. Most Common Genre Combinations
```sql
SELECT genres, COUNT(*) AS count
FROM imdb
GROUP BY genres
ORDER BY count DESC
LIMIT 10;
```

### 6. Year with Highest Average Rating
```sql
SELECT year, ROUND(AVG(average_rating), 2) AS avg_rating
FROM imdb
GROUP BY year
ORDER BY avg_rating DESC
LIMIT 1;
```

### 7. Country-wise Best Movie (by Votes)
```sql
SELECT country, title, num_votes
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY num_votes DESC) AS rn
    FROM imdb
) AS ranked
WHERE rn = 1;
```

### 8. Movies Where Box Office > 5x Budget
```sql
SELECT title, budget, box_office,
       ROUND(box_office / budget, 2) AS return_ratio
FROM imdb
WHERE box_office > 5 * budget
ORDER BY return_ratio DESC;
```

### 9. Director with Highest Average Revenue (min 5 movies)
```sql
SELECT director_name, COUNT(*) AS movie_count,
       ROUND(AVG(box_office), 2) AS avg_revenue
FROM imdb
GROUP BY director_name
HAVING COUNT(*) >= 5
ORDER BY avg_revenue DESC
LIMIT 1;
```

### 10. Latest Movie per Language
```sql
SELECT language, title, year
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY language ORDER BY year DESC) AS rn
    FROM imdb
) AS latest
WHERE rn = 1;
```

### 11. Top 3 Highest-Grossing Movies per Actor
```sql
SELECT main_actor, title, box_office
FROM (
    SELECT main_actor, title, box_office,
           ROW_NUMBER() OVER (PARTITION BY main_actor ORDER BY box_office DESC) AS rn
    FROM imdb
) AS actor_collection
WHERE rn <= 3;
```

### 12. Directors Whose Ratings Never Dropped
```sql
SELECT director_name
FROM (
    SELECT director_name, year, average_rating,
           LAG(average_rating) OVER (PARTITION BY director_name ORDER BY year) AS prev_rating
    FROM imdb
) t
GROUP BY director_name
HAVING MAX(CASE WHEN average_rating < prev_rating THEN 1 ELSE 0 END) = 0;
```








