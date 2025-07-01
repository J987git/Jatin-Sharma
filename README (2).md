
# 🩺 Doctor Prescription & Pharma Sales Data Analysis

This project analyzes doctor prescription behavior and pharmaceutical revenue patterns using a self-generated dataset. It demonstrates how prescription data can be transformed into actionable business insights through Python, SQL, and data visualization.

---

## 📌 Project Overview

This end-to-end data analysis project simulates how doctors prescribe medicines, evaluates the impact of medicine pricing and preference patterns, and identifies high-performing medicines, doctors, and companies.

The dataset was **created manually** to resemble realistic pharmaceutical sales and prescription behavior.

---

## 📁 Dataset Structure

The project is based on 4 core tables:

1. **doctors.csv** – Doctor ID, name, specialization  
2. **medicines.csv** – Medicine ID, name, category, price, company_id  
3. **pharma_companies.csv** – Company ID, name  
4. **prescriptions.csv** – Doctor ID, medicine ID (who prescribed what and how often)

These were ingested into a SQLite database and combined into a summary view using SQL joins.

---

## 🧠 Key Features

- ✅ Created a custom dataset (no public source)
- ✅ Built data ingestion pipeline using `pandas` + `SQLAlchemy`
- ✅ Logged ingestion and transformation steps
- ✅ Built a `doctors_summary` table with:
  - `estimated_revenue`
  - `doctor_pref_score`
  - `avg_cost_per_prescription`
- ✅ Performed full Exploratory Data Analysis (EDA)
- ✅ Quantile-based segmentation (Top 25%, 50%, etc.)
- ✅ Correlation analysis for price, loyalty, and revenue drivers

---

## 📊 Analysis Performed

### 🔹 Revenue by Specialization
Identified high-revenue specializations like Orthopedic and Neurologist.

### 🔹 Top Medicines & Pharma Companies
Ranked by estimated revenue. Highlighted key performers.

### 🔹 Doctor Preference Score
Measured how loyal each doctor is to specific medicines (DPS).

### 🔹 Quantile Analysis
Segmented records into quartiles and deciles to find top 25% and top 10% performers.

### 🔹 Correlation Matrix
Analyzed how variables like price, revenue, and loyalty are related.

---

## 🛠️ Tools & Technologies Used

| Tool | Purpose |
|------|---------|
| **Python** | Data processing and automation |
| **Pandas** | DataFrame manipulation |
| **SQLite** | Relational data storage |
| **SQLAlchemy** | Python-to-SQL interface |
| **Matplotlib / Seaborn** | Visualizations |
| **Logging** | ETL tracking and debugging |

---

## 📁 Folder Structure

```
├── data/
│   ├── doctors.csv
│   ├── medicines.csv
│   ├── prescriptions.csv
│   ├── pharma_companies.csv
├── inventory.db
├── doctors_summary.log
├── ingestion_script.py
├── doctors_summary_analysis.ipynb
├── README.md
```

---

## 🚀 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/pharma-doctor-analysis.git
   cd pharma-doctor-analysis
   ```

2. Install dependencies:
   ```bash
   pip install pandas sqlalchemy matplotlib seaborn
   ```

3. Run the ingestion script:
   ```bash
   python ingestion_script.py
   ```

4. Open the Jupyter notebook to explore analysis:
   ```bash
   jupyter notebook doctors_summary_analysis.ipynb
   ```

---

## 📈 Sample Visualizations

- Revenue distribution by specialization
- Unit price vs revenue scatter
- Doctor preference score histogram
- Correlation heatmap
- Revenue segment box plots

---

## 📌 Key Learnings

- How data engineering connects to real-world business problems
- Value of quantile analysis for customer segmentation
- Importance of building datasets when real ones aren't available
- How unit price impacts pharma revenue more than volume

---




