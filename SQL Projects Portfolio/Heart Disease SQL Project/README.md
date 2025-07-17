# ❤️ Heart Disease Analysis Using SQL

## 📌 Objective
Analyze a heart disease dataset using SQL to identify key risk factors, patterns, and high-risk segments for early detection and prevention strategies.

---

## 🗂 Files Included

- `Heart_Disease.sql` – Contains all SQL queries for analysis
- *(Optional)* `heart_disease.csv` – The dataset used (if you're allowed to share it)
- *(Optional)* `ERD.png` – Database schema (Entity Relationship Diagram)

---

## 🛠 Tools Used

- MySQL / PostgreSQL
- SQL Window Functions
- Case Statements, Aggregates, Joins (if needed)

---

## 🔍 Business Questions Answered

### 1. 🧮 Total Patients & Disease Rate
- Count of patients
- % of patients with heart disease

### 2. 👵 Age Group Risk Segmentation
- Categorized by `<40`, `40–55`, `56–70`, `>70`
- Disease prevalence by age range

### 3. 🚻 Gender-Based Risk
- How disease rates vary between sexes

### 4. 💔 Chest Pain vs Heart Disease
- Risk % by chest pain type

### 5. ⚠️ High BP & Cholesterol
- Identify patients with **BP > 140** and **cholesterol > 240** who have heart disease

### 6. 🍬 Fasting Sugar Impact
- Does high fasting blood sugar increase heart disease risk?

### 7. 🧬 Thalassemia & Risk
- Heart disease rate across different `thal` values

### 8. 🏃 Exercise-Induced Angina
- Analyzing its correlation with heart disease presence

### 9. 🧮 Custom Risk Score
- Risk Score = `blood pressure + cholesterol + (oldpeak × 10)`
- Top 10 high-risk patients

### 10. 💓 Max Heart Rate Ranking
- Ranks patients by `max_heart_rate_achieved` using SQL window functions

---

## 📈 Sample Query

```sql
SELECT sex, COUNT(*) AS total,
SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS disease_rate
FROM disease
GROUP BY sex;
