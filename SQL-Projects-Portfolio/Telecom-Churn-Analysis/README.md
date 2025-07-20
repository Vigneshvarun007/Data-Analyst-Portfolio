# 📞 Telecom Churn Analysis (SQL Project)

## 🎯 Objective
Analyze telecom customer behavior using SQL to identify churn drivers, customer segments at risk, and strategic insights for improving retention.

---

## 📁 Files Included
- `Telecom_Churn_Analysis.sql`: Contains all SQL queries for KPIs, segment analysis, and churn patterns.
- *(Optional)* `telecom_churn.csv`: Dataset with customer behavior and plan details (upload if allowed).
- *(Optional)* `ERD.png`: Entity Relationship Diagram showing table structure.

---

## 🛠 Tools Used
- MySQL or PostgreSQL
- SQL aggregate functions, CASE statements, window functions

---

## 🔍 Key Business Questions Answered

### 1. 🧾 Basic KPIs
- Total number of customers
- Total churned customers
- Churn rate %

### 2. 🌍 State-wise Churn Analysis
- Which states have the highest churn rates?
- Compare churn volume and rates across geographies

### 3. 📦 Plan-Based Churn
- Do customers with **International Plan** or **VoiceMail Plan** churn more?
- Correlation between plan type and churn

### 4. 📞 Customer Service Calls
- Does making more service calls lead to higher churn?
- Analysis of churn by number of support calls

### 5. 📊 Usage Patterns
- Average usage (day, evening, night) by churn status
- Identify if high users are more likely to churn

### 6. ⚠️ High-Risk Segments
- Filter customers with high international usage, frequent support calls, and no voicemail — likely churners

### 7. ⏳ Tenure-Based Segmentation
- Customer grouping by account length (0–50, 51–100, 100+ days)
- Churn rate by tenure group

### 8. 💰 Revenue Impact
- Rank customers by total charges using `RANK()` window function
- Identify top-paying customers and churn risk

---

## 📝 Sample Query

```sql
SELECT State, COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn = 'TRUE' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(100.0 * SUM(CASE WHEN Churn = 'TRUE' THEN 1 ELSE 0 END)/COUNT(*), 2) AS Churn_Rate
FROM no_churn
GROUP BY State
ORDER BY Churn_Rate DESC;
