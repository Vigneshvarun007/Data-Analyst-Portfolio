# 🚗 Car Price SQL Project

### 📌 Objective:
To analyze factors affecting car prices using structured SQL queries on a sample dataset.

### 🗂 Files Included:
- `Car_Price.csv`: Dataset containing car features and their prices
- `Car_Price_Analysis.sql`: SQL queries used for data analysis

### 🔍 Key Business Questions Answered:
- What is the average price of cars by fuel type?
- How does transmission type impact price?
- Which companies have the most expensive models?
- What is the price distribution across car body types?

### 🧠 Tools Used:
- SQL (MySQL/PostgreSQL/SQLite)
- Local environment (VSCode / DBeaver / pgAdmin)

---

### 📝 Sample Query
```sql
SELECT Fuel_Type, AVG(Price) AS Avg_Price
FROM Car_Price
GROUP BY Fuel_Type
ORDER BY Avg_Price DESC;

